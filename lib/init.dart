import 'package:digifarmer/provider/myapp_provider.dart';
import 'package:digifarmer/provider/network_checker_provider.dart';
import 'package:digifarmer/provider/news_provider.dart';
import 'package:digifarmer/provider/weather_provider.dart';
import 'package:digifarmer/services/diseases_detail_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Init extends StatefulWidget {
  const Init({super.key, required this.child});

  final Widget child;

  @override
  State<Init> createState() => _InitState();
}

class _InitState extends State<Init> {
  late final AppLifecycleListener _appLifecycleListener;

  @override
  void initState() {
    super.initState();

    ///App life cycle
    _appLifecycleListener = AppLifecycleListener(
      onResume: () {},
      onInactive: () {},
      onHide: () {},
      onShow: () {},
      onPause: () {},
      onRestart: () {},
      onDetach: () {},
    );

    ///Initialization
    WidgetsBinding.instance.endOfFrame.then((_) {
      if (mounted) init();
    });
  }

  @override
  void dispose() {
    _appLifecycleListener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
      ),
    );
    return widget.child;
  }

  ///Application initialization
  void init() async {
    final MyappProvider myappProvider = context.read<MyappProvider>();
    final WeatherProvider weatherProvider = context.read<WeatherProvider>();
    final NewsProvider newsProvider = context.read<NewsProvider>();
    final NetworkCheckerProvider networkCheckerProvider =
        context.read<NetworkCheckerProvider>();
    DiseasesDetailService.loadJson();
    
    myappProvider.loadThemeMode();
    networkCheckerProvider.listenNetwork(() {
      weatherProvider.getWeather();
      newsProvider.getNews(1);
    });
    await preCacheImage(context);
  }

  Future<void> preCacheImage(BuildContext context) async {
    final List<String> imagesAssets = [
      'assets/images/home/smart_farmer.png',
      'assets/images/home/education.png',
      'assets/images/home/finance.png',
      'assets/images/home/pest.png',
      'assets/images/home/soil.png',
      'assets/images/home/tech.png',
      'assets/images/home/water.png',
    ];
    for (final String image in imagesAssets) {
      await precacheImage(
        AssetImage(image),
        context,
      );
    }
  }
}
