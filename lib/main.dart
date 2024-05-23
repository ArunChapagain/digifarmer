import 'package:digifarmer/application.dart';
import 'package:digifarmer/init.dart';
import 'package:digifarmer/provider/myapp_provider.dart';
import 'package:digifarmer/provider/weather_provider.dart';
import 'package:digifarmer/theme/app_theme.dart';
import 'package:digifarmer/widgets/will_pop_scope_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => MyappProvider()),
          ChangeNotifierProvider(create: (context) => WeatherProvider())
        ],
        builder: (context, child) {
          final watchApplicationProvider = context.watch<MyappProvider>();

          return ScreenUtilInit(
              designSize: const Size(360, 640),
              builder: (context, child) {
                return MaterialApp(
                  themeMode: watchApplicationProvider.themeMode,
                  theme: AppTheme.getLightThemeData(context),
                  darkTheme: AppTheme.getDarkThemeData(context),
                  debugShowCheckedModeBanner: false,
                  title: 'Digifarmer',
                  home: const WillPopScopeRoute(
                      child: Init(child: Application())),
                );
              });
        });
  }
}
