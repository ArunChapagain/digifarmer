import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:digifarmer/constants/constants.dart';
import 'package:digifarmer/provider/detection_provider.dart';
import 'package:digifarmer/widgets/animation.dart';
import 'package:digifarmer/widgets/detect_button.dart';
import 'package:digifarmer/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter/services.dart' as services;
import 'package:image/image.dart' as img;

class DetectPage extends StatefulWidget {
  const DetectPage({
    super.key,
    required this.title,
    required this.imagePath,
    required this.color,
  });
  final String title;
  final String color;
  final String imagePath;

  @override
  State<DetectPage> createState() => _DetectPageState();
}

class _DetectPageState extends State<DetectPage> {
  Interpreter? interpreter;
  List<String>? labels;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  @override
  void dispose() {
    interpreter?.close();
    super.dispose();
  }

  loadModel() async {
    String modelPath = cornDiseaseModel;
    String labelPath = cornDiseasetxt;
    // String modelPath = maizeDiseasesModel;
    // String labelPath = maizeDiseasestxt;

    try {
      // Load the model
      interpreter = await Interpreter.fromAsset(modelPath);

      // Load the labels
      String labelsText = await services.rootBundle.loadString(labelPath);
      labels =
          labelsText.split('\n').where((label) => label.isNotEmpty).toList();
    } catch (e) {
      log('Error loading model: $e');
    }
  }

  Future pickImage(bool isCamera) async {
    final image = await ImagePicker().pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
    );

    if (image == null) return;

    File imageFile = File(image.path);

    classifyImage(imageFile);
  }

  classifyImage(File image) async {
    if (interpreter == null || labels == null) {
      log('Model not loaded');
      return;
    }

    try {
      LoadingOverlay().show(context);
      // Load and preprocess the image
      final imageBytes = await image.readAsBytes();
      final decodedImage = img.decodeImage(imageBytes);

      if (decodedImage == null) {
        log('Could not decode image');
        return;
      }

      // Resize image to expected input size (assuming 224x224, adjust as needed)
      final resizedImage = img.copyResize(
        decodedImage,
        width: 224,
        height: 224,
      );

      // Convert to Float32List and normalize
      final input = Float32List(1 * 224 * 224 * 3);
      int pixelIndex = 0;

      for (int y = 0; y < 224; y++) {
        for (int x = 0; x < 224; x++) {
          final pixel = resizedImage.getPixel(x, y);
          input[pixelIndex++] = (pixel.r / 255.0);
          input[pixelIndex++] = (pixel.g / 255.0);
          input[pixelIndex++] = (pixel.b / 255.0);
        }
      }

      // Reshape input for model
      final inputBuffer = input.reshape([1, 224, 224, 3]);

      // Prepare output buffer
      final outputBuffer = Float32List(
        labels!.length,
      ).reshape([1, labels!.length]);

      // Run inference
      interpreter!.run(inputBuffer, outputBuffer);

      // Get results
      final results = outputBuffer[0];
      double maxScore = results[0];
      int maxIndex = 0;

      for (int i = 1; i < results.length; i++) {
        print('score: ${results[i]} for index: $i');
        if (results[i] > maxScore) {
          maxScore = results[i];
          maxIndex = i;
        }
      }

      print('Predicted index: $maxIndex, Score: $maxScore');

      String predictedLabel = labels![maxIndex];

      // Update provider and display result
      Provider.of<DetectionProvider>(
        context,
        listen: false,
      ).getDetectionDetail(widget.title, predictedLabel);
      LoadingOverlay().hide();

      displayResult(predictedLabel);
    } catch (e) {
      LoadingOverlay().hide();
      log('Error during classification: $e');
    }
  }

  displayResult(String diagnosis) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      isDismissible: true,
      context: context,
      builder: (context) {
        return Consumer<DetectionProvider>(
          builder: (context, value, child) {
            String type = value.classDetection;
            String description = value.details;
            if (value.isDetectionLoading == true) {
              return SizedBox(
                height: 200.h,
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 5,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              );
            } else {
              return Container(
                height: 400.h,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  ),
                  border: Border.all(
                    color: Theme.of(context).primaryColor.withOpacity(0.8),
                    width: 3.w,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 10.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 10.w, top: 5.h),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Theme.of(
                                    context,
                                  ).primaryColor.withOpacity(0.8),
                                  width: 3.w,
                                ),
                              ),
                              child: Icon(Remix.close_line, size: 30.sp),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        //make the first letter and letter after space of the diagnosis to be capital
                        diagnosis[0].toUpperCase() +
                            diagnosis.substring(1).toLowerCase(),
                        style: TextStyle(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Text(
                            type.isEmpty ? '' : 'Class: ',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            type,
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontFamily: GoogleFonts.poppins(fontWeight: FontWeight.w700).fontFamily,
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            children: [
              Row(
                children: [
                  AnimatedPress(
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Remix.arrow_left_s_line, size: 26.sp),
                    ),
                  ),
                  Text(
                    'back',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: Color(int.parse(widget.color)),
                    ),
                    child: Hero(
                      tag: widget.title,
                      child: Image.asset(
                        widget.imagePath,
                        height: 175.h,
                        width: 400.w,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 60.h,
                    left: 10.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: textStyle.copyWith(
                            fontSize: 34.sp,
                            color: const Color(0xFFFFFFFF),
                          ),
                        ),
                        Text(
                          'Identifier',
                          style: TextStyle(
                            fontSize: 24.sp,
                            color: Colors.white,
                            height: 0.6.h,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 35.h),
              Text(
                'Digifarmer',
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontFamily: GoogleFonts.righteous().fontFamily,
                  fontSize: 34.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                'Supporting Farmers in ',
                style: textStyle.copyWith(fontSize: 22.sp),
              ),
              Text(
                'Safegauarding their Crops Health',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 35.h),
              DetectButton(
                isSecondBtn: true,
                onTap: () => pickImage(true),
                title: 'Take picture',
                subTitle: 'of your plant',
                icon: Remix.camera_line,
              ),
              SizedBox(height: 15.h),
              DetectButton(
                onTap: () => pickImage(false),
                title: 'Import',
                subTitle: 'from your gallary',
                icon: Remix.gallery_view_2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
