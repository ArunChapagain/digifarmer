import 'package:carousel_slider/carousel_slider.dart';
import 'package:digifarmer/constants/tips.dart';
import 'package:digifarmer/extension/build_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SliderCarousel extends StatefulWidget {
  const SliderCarousel({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<SliderCarousel> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: data.length,
      itemBuilder: (context, index, realIdx) {
        return Container(
          height: 60.h,
          width: 300.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.r),
            color: Theme.of(context).cardColor,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 0.1.w,
                child: Opacity(
                  opacity: 0.4,
                  child: Image.asset(
                    height: 180.h,
                    data[index]['image']!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.w),
                child: Column(
                  children: [
                    Text(
                      data[index]['title']!,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 9.h),
                    Text(
                      data[index]['description']!,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                      data.asMap().entries.map((entry) {
                        return Container(
                          width: 10.0,
                          height: 10.0,
                          margin: EdgeInsets.symmetric(
                            vertical: 8.w,
                            horizontal: 4.w,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.theme.primaryColor.withOpacity(
                              _current == entry.key ? 0.9 : 0.3,
                            ),
                          ),
                        );
                      }).toList(),
                ),
              ),
            ],
          ),
        );
      },
      options: CarouselOptions(
        enlargeFactor: 0.2,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
        onPageChanged: (index, reason) {
          setState(() {
            _current = index;
          });
        },
        autoPlay: true,
      ),
    );
  }
}
