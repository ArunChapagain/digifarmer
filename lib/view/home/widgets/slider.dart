import 'package:carousel_slider/carousel_slider.dart';
import 'package:digifarmer/constants/tips.dart';
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
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: data.length,
          itemBuilder: (context, index, realIdx) {
            return Container(
              height: 100.h,
              width: 300.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: Theme.of(context).cardColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset:const  Offset(1, 11),
                    ),
                  ]),
              child: Stack(
                children: [
                  Opacity(
                    opacity: 0.6,
                    child: Transform.scale(
                      scaleY: 1.1,
                      scaleX: 1.08,
                      child: Image.asset(
                        height: 200.h,
                        data[index]['image']!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        data[index]['title']!,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          options: CarouselOptions(
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
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: data.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 12.0,
                height: 12.0,
                margin: EdgeInsets.symmetric(vertical: 8.w, horizontal: 4.w),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: // (Theme.of(context).brightness == Brightness.dark
                        //         ? Colors.white
                        //         : Colors.black)
                        Theme.of(context)
                            .primaryColor
                            .withOpacity(_current == entry.key ? 0.9 : 0.2)),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
