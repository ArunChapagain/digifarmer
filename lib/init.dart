import 'package:digifarmer/provider/myapp_provider.dart';
import 'package:digifarmer/theme/app_theme.dart';
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
      onResume: () => print('App Resume'),
      onInactive: () => print('App Inactive'),
      onHide: () => print('App Hide'),
      onShow: () => print('App Show'),
      onPause: () {},
      onRestart: () => print('App Restart'),
      onDetach: () => print('App Detach'),
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
    ///Immersive mode (full screen mode)
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(
      isDarkMode(context)
          ? SystemUiOverlayStyle.dark.copyWith(
              statusBarColor: Colors.transparent,
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.light,
              systemNavigationBarColor: Colors.transparent,
            )
          : SystemUiOverlayStyle.light.copyWith(
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
    myappProvider.loadThemeMode();
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
