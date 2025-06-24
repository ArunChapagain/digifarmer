import 'package:digifarmer/constants/app_icon.dart';
import 'package:digifarmer/view/alert/alert_screen.dart';
import 'package:digifarmer/view/diseases_detection/diseases_overview_screen.dart';
import 'package:digifarmer/view/home/home_screen.dart';
import 'package:digifarmer/view/news/news_screen.dart';
import 'package:digifarmer/view/weather/weather_screen.dart';
import 'package:digifarmer/widgets/bottom_nav_item.dart';
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

  ///page
  final List<Widget> _pages = [
    const HomePage(),
    const NewsPage(),
    DiseasesDetectionPage(),
    const WeatherPage(),
    AlertPage(),
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
          color:
              appTheme.bottomNavigationBarTheme.backgroundColor ?? Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 24),
          ],
        ),
        child: TabBar(
          enableFeedback: true,
          padding: EdgeInsets.symmetric(horizontal: 6.w),
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
            BottomNavItem(
              iconPath: kHomeLine,
              selectedIconPath: kHomeFill,
              label: 'Home',
              isSelected: _currentPage == 0,
            ),
            BottomNavItem(
              iconPath: kNewsLine,
              selectedIconPath: kNewsFill,
              label: 'News',
              isSelected: _currentPage == 1,
            ),
            BottomNavItem(
              iconPath: kDetectionLine,
              selectedIconPath: kDetectionFill,
              label: 'Detect',
              isSelected: _currentPage == 2,
            ),
            BottomNavItem(
              iconPath: kCloudLine,
              selectedIconPath: kCloudFill,
              label: 'Weather',
              isSelected: _currentPage == 3,
            ),
            BottomNavItem(
              iconPath: kAleartLine,
              selectedIconPath: kAleartFill,
              label: 'Alert',
              isSelected: _currentPage == 4,
            ),
          ],
          onTap: (index) {
            _pageViewController.jumpToPage(index);
            setState(() {
              _currentPage = index;
            });
          },
        ),
      ),
    );
  }
}
