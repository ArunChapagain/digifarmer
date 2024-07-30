import 'package:digifarmer/firebase_options.dart';
import 'package:digifarmer/init.dart';
import 'package:digifarmer/provider/detection_provider.dart';
import 'package:digifarmer/provider/location_provider.dart';
import 'package:digifarmer/provider/myapp_provider.dart';
import 'package:digifarmer/provider/network_checker_provider.dart';
import 'package:digifarmer/provider/news_provider.dart';
import 'package:digifarmer/provider/weather_provider.dart';
import 'package:digifarmer/theme/app_theme.dart';
import 'package:digifarmer/view/auth/auth_page.dart';
import 'package:digifarmer/widgets/will_pop_scope_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => MyappProvider()),
          ChangeNotifierProvider(create: (context) => NewsProvider()),
          ChangeNotifierProvider(create: (context) => NetworkCheckerProvider()),
          ChangeNotifierProvider(create: (context) => DetectionProvider()),
          ChangeNotifierProvider(create: (context) => LocationProvider()),
          ChangeNotifierProxyProvider<LocationProvider, WeatherProvider>(
              create: (context) => WeatherProvider(null, null),
              update: (context, locationProvider, _) => WeatherProvider(
                  locationProvider.latitude, locationProvider.longitude)),
        ],
        builder: (context, child) {
          return ScreenUtilInit(
              designSize: const Size(360, 640),
              builder: (context, child) {
                return MaterialApp(
                  themeMode: ThemeMode.light,
                  theme: AppTheme.getLightThemeData(context),
                  darkTheme: AppTheme.getDarkThemeData(context),
                  debugShowCheckedModeBanner: false,
                  title: 'DigiFarmer',
                  navigatorObservers: [FlutterSmartDialog.observer],
                  builder: FlutterSmartDialog.init(),
                  home: const WillPopScopeRoute(
                    child: Init(
                      child: AuthPage(),
                    ),
                  ),
                );
              });
        });
  }
}
