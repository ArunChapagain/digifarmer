import 'package:digifarmer/application.dart';
import 'package:digifarmer/widgets/will_pop_scope_route/will_pop_scope_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 640),
        builder: (context, child) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Digifarmer',
            home:  WillPopScopeRoute(child:Application()),
          );
        });
  }
}