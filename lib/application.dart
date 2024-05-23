import 'package:digifarmer/view/diseases_detection/diseases_detection.dart';
import 'package:digifarmer/view/home/home_screen.dart';
import 'package:digifarmer/view/news/news_screen.dart';
import 'package:digifarmer/view/weather/weather_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application>
    with TickerProviderStateMixin {
  late int _currentPage = 0;
  final double _tabIconSize = 20.sp;

  ///page
  final List<Widget> _pages = [
    const HomePage(),
    const NewsPage(),
    DiseasesDetectionPage(),
    const WeatherPage()
  ];

  ///Tab control
  late final TabController _pageController = TabController(
    initialIndex: _currentPage,
    length: _pages.length,
    vsync: this,
  );

  ///PageView control
  final PageController _pageViewController = PageController();

  @override
  void dispose() {
    ///Tab control
    _pageController.dispose();

    ///PageView control
    _pageViewController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);

    return Scaffold(
        body: PageView(
          controller: _pageViewController,
          physics: const NeverScrollableScrollPhysics(),
          children: _pages,
        ),
        bottomNavigationBar: DecoratedBox(
          decoration: BoxDecoration(
            color: appTheme.bottomNavigationBarTheme.backgroundColor ??
                Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 24),
            ],
          ),
          child: TabBar(
            enableFeedback: true,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            controller: _pageController,
            indicatorColor: Colors.transparent,
            labelStyle: TextStyle(
              // color: Colors.black,
              height: 0.5.h,
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: TextStyle(
              // color: const Color(0xFF9FA9AF),
              height: 0.5.h,
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
            ),
            tabs: [
              Tab(
                icon: Icon(
                  Remix.home_line,
                  size: _tabIconSize,
                ),
                text: 'Home',
              ),
              Tab(
                icon: Icon(
                  Remix.newspaper_line,
                  size: _tabIconSize,
                ),
                text: 'News',
              ),
              Tab(
                icon: Icon(
                  Remix.search_line,
                  size: _tabIconSize,
                ),
                text: 'Diagnose',
              ),
              Tab(
                icon: Icon(
                  Remix.cloudy_line,
                  size: _tabIconSize,
                ),
                text: 'Weather',
              ),
            ],
            onTap: (index) {
              _pageViewController.jumpToPage(index);
              setState(() {
                _currentPage = index;
              });
            },
          ),
        ));
  }
}
