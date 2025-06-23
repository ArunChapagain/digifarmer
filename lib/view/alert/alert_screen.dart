import 'package:digifarmer/models/alert_model.dart';
import 'package:digifarmer/provider/alert_provider.dart';
import 'package:digifarmer/widgets/empty_widget.dart';
import 'package:digifarmer/widgets/no_internet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:provider/provider.dart';

import '../../provider/network_checker_provider.dart';

class AlertPage extends StatefulWidget {
  const AlertPage({super.key});

  @override
  State<AlertPage> createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        forceMaterialTransparency: true,
        // centerTitle: true,
        title: Text(
          'Alerts',
          style: TextStyle(
            color: Colors.black,
            fontSize: 28.sp,
            fontFamily:
                GoogleFonts.poppins(fontWeight: FontWeight.w600).fontFamily,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 8.w, right: 8.w),
          child: Consumer2<AlertProvider, NetworkCheckerProvider>(
            builder: (context, alertProvider, networkProvider, child) {
              return networkProvider.status == InternetStatus.disconnected
                  ? const NoInternetWidget()
                  : alertProvider.alerts.isEmpty
                  ? EmptyWidget()
                  : ListView.builder(
                    itemCount: alertProvider.alerts.length,
                    itemBuilder: (context, index) {
                      final alert = alertProvider.alerts[index];
                      return AlertCard(alert: alert);
                    },
                  );
            },
          ),
        ),
      ),
    );
  }
}

class AlertCard extends StatelessWidget {
  const AlertCard({super.key, required this.alert});
  final Alert alert;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.symmetric(horizontal: 10.w, vertical: 10.w),
      padding: EdgeInsetsDirectional.symmetric(horizontal: 8.h, vertical: 8.w),
      decoration: BoxDecoration(
        // color: Theme.of(context).cardColor,
        color: Color.fromARGB(57, 212, 20, 20),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFD8E7D8).withOpacity(0.07),
            blurRadius: 8,
            offset: const Offset(1, 7),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            alert.title ?? 'No Title',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4.h),
          Text(
            alert.description ?? 'No Description',
            style: TextStyle(fontSize: 14.sp),
          ),
          SizedBox(height: 8.h),
          Text(
            alert.createdOn != null
                ? 'Created on: ${alert.startedOn!.toLocal()}'
                : 'Unknown Date',
            style: TextStyle(fontSize: 12.sp, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
