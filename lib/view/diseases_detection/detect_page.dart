import 'dart:io';
import 'package:digifarmer/constants/constants.dart';
import 'package:digifarmer/widgets/animation.dart';
import 'package:digifarmer/widgets/detect_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:remixicon/remixicon.dart';

class DetectPage extends StatefulWidget {
  const DetectPage(
      {super.key,
      required this.title,
      required this.imagePath,
      required this.color});
  final String title;
  final String color;
  final String imagePath;

  @override
  State<DetectPage> createState() => _DetectPageState();
}

class _DetectPageState extends State<DetectPage> {
  File? _imageFile;
  @override
  void initState() {
    super.initState();
    loadModel();
  }

  loadModel() async {
    print(widget.title);
    if (widget.title == 'Rice Leaf') {
      await Tflite.loadModel(
        model: riceDiseaseModel,
        labels: riceDiseasetxt,
        isAsset: true,
      );
    } else if (widget.title == 'Wheat Leaf') {
      await Tflite.loadModel(
        model: wheatDiseaseModel,
        labels: wheatDiseasetxt,
        isAsset: true,
      );
    } else if (widget.title == 'Tomato Leaf') {
      await Tflite.loadModel(
        model: tomatoDiseaseModel,
        labels: tomatoDiseasetxt,
        isAsset: true,
      );
    } else if (widget.title == 'Sugarcane Leaf') {
      await Tflite.loadModel(
        model: sugarcaneDiseaseModel,
        labels: sugarcaneDiseasetxt,
        isAsset: true,
      );
    } else if (widget.title == 'Cotton Leaf') {
      await Tflite.loadModel(
        model: cottonDiseaseModel,
        labels: cottonDiseasetxt,
        isAsset: true,
      );
    } else if (widget.title == 'Maize Leaf') {
      await Tflite.loadModel(
        model: cornDiseaseModel,
        labels: cornDiseasetxt,
        isAsset: true,
      );
    }
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  Future pickImage(
    bool isCamera,
    // BuildContext context,
  ) async {
    final image = await ImagePicker()
        .pickImage(source: isCamera ? ImageSource.camera : ImageSource.gallery);

    if (image == null) return null;
    setState(() {
      // _loading = true;
      _imageFile = File(image.path);
    });
    classifyImage(_imageFile!);
  }

  classifyImage(
    File image,
    // BuildContext context,
  ) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        imageMean: 0.0,
        imageStd: 255.0,
        numResults: 2,
        threshold: 0.2,
        asynch: true);

    if (output != null) {
      displayResult(output[0]['label']);
    }
  }

  displayResult(
    String digonosis,
    // BuildContext context,
  ) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        isDismissible: true,
        context: context,
        builder: (context) {
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
                  width: 3.w),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
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
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.8),
                                    width: 3.w),
                              ),
                              child: Icon(Remix.close_line, size: 30.sp))),
                    ],
                  ),
                  Text(
                    //make the first |letter and letter after space of the digonois to be capital
                    digonosis[0].toUpperCase() +
                        digonosis.substring(1).toLowerCase(),
                    style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Text(
                        'Class: ',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Fungi',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'episom is a fungal disease that affects the leaves of the plant. It is caused by the fungus Puccinia polysora. The disease is characterized by the presence of small, yellowish-brown spots on the leaves. ',
                    style: TextStyle(
                      fontSize: 20.sp,
                      // height: 1.5.h,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  final textStyle = TextStyle(
      fontFamily: GoogleFonts.poppins(fontWeight: FontWeight.w700).fontFamily);
  @override
  Widget build(BuildContext context) {
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
                      color: Color(
                        int.parse(widget.color),
                      ),
                    ),
                    child: Image.asset(
                      widget.imagePath,
                      height: 175.h,
                      width: 400.w,
                      fit: BoxFit.contain,
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
                  )
                ],
              ),
              SizedBox(height: 30.h),
              Text(
                'Digifarmer',
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontFamily: GoogleFonts.righteous().fontFamily,
                      fontSize: 34.sp,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 20.h),
              Text(
                'Supporting Farmers in ',
                style: textStyle.copyWith(
                  fontSize: 22.sp,
                ),
              ),
              Text(
                'Safegauarding their Crops Health',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 30.h),
              DetectButton(
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
