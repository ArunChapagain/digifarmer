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
  void initState() {
    super.initState();
    // Refresh alerts when page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AlertProvider>().getAlerts();
    });
  }

  Widget _buildSummaryHeader(List<Alert> alerts) {
    int activeAlerts = 0;
    int expiredAlerts = 0;
    int verifiedAlerts = 0;

    for (final alert in alerts) {
      final now = DateTime.now();
      if (alert.expireOn != null && now.isAfter(alert.expireOn!)) {
        expiredAlerts++;
      } else {
        activeAlerts++;
      }
      if (alert.verified == true) {
        verifiedAlerts++;
      }
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade50, Colors.blue.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.dashboard, color: Colors.blue.shade700, size: 24.sp),
              SizedBox(width: 8.w),
              Text(
                'Alert Summary',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade700,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: _buildSummaryItem(
                  'Total',
                  alerts.length.toString(),
                  Colors.blue,
                  Icons.list_alt,
                ),
              ),
              Expanded(
                child: _buildSummaryItem(
                  'Active',
                  activeAlerts.toString(),
                  Colors.red,
                  Icons.warning,
                ),
              ),
              Expanded(
                child: _buildSummaryItem(
                  'Expired',
                  expiredAlerts.toString(),
                  Colors.grey,
                  Icons.schedule,
                ),
              ),
              Expanded(
                child: _buildSummaryItem(
                  'Verified',
                  verifiedAlerts.toString(),
                  Colors.green,
                  Icons.verified,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(
    String label,
    String count,
    Color color,
    IconData icon,
  ) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(icon, color: color, size: 20.sp),
        ),
        SizedBox(height: 4.h),
        Text(
          count,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        forceMaterialTransparency: true,
        title: Text(
          'Alerts',
          style: TextStyle(
            color: Colors.black,
            fontSize: 28.sp,
            fontFamily:
                GoogleFonts.poppins(fontWeight: FontWeight.w600).fontFamily,
          ),
        ),
        actions: [
          // Consumer<AlertProvider>(
          //   builder: (context, alertProvider, child) {
          //     if (alertProvider.isLoading) {
          //       return Padding(
          //         padding: EdgeInsets.all(16.w),
          //         child: SizedBox(
          //           width: 20.w,
          //           height: 20.h,
          //           child: const CircularProgressIndicator(strokeWidth: 2),
          //         ),
          //       );
          //     }
          //     return IconButton(
          //       icon: const Icon(Icons.refresh),
          //       onPressed: () => alertProvider.getAlerts(),
          //     );
          //   },
          // ),
        ],
      ),
      body: SafeArea(
        child: Consumer2<AlertProvider, NetworkCheckerProvider>(
          builder: (context, alertProvider, networkProvider, child) {
            return networkProvider.status == InternetStatus.disconnected
                ? const NoInternetWidget()
                : alertProvider.alerts.isEmpty
                ? Center(child: const EmptyWidget())
                : RefreshIndicator(
                  onRefresh: () async {
                    await alertProvider.getAlerts();
                  },
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    itemCount: alertProvider.alerts.length + 1, // +1 for header
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        // Summary header
                        return _buildSummaryHeader(alertProvider.alerts);
                      }
                      final alert = alertProvider.alerts[index - 1];
                      return AnimatedContainer(
                        duration: Duration(milliseconds: 300 + (index * 100)),
                        curve: Curves.easeInOut,
                        child: AlertCard(alert: alert),
                      );
                    },
                  ),
                );
          },
        ),
      ),
    );
  }
}

class AlertCard extends StatelessWidget {
  const AlertCard({super.key, required this.alert});
  final Alert alert;

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return 'Unknown';
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }

  String _getAlertStatus() {
    final now = DateTime.now();
    if (alert.expireOn != null && now.isAfter(alert.expireOn!)) {
      return 'Expired';
    } else if (alert.startedOn != null && now.isBefore(alert.startedOn!)) {
      return 'Scheduled';
    } else {
      return 'Active';
    }
  }

  Color _getStatusColor() {
    final status = _getAlertStatus();
    switch (status) {
      case 'Expired':
        return Colors.grey;
      case 'Scheduled':
        return Colors.orange;
      case 'Active':
      default:
        return Colors.red;
    }
  }

  Color _getBackgroundColor() {
    final status = _getAlertStatus();
    switch (status) {
      case 'Expired':
        return Colors.grey.withOpacity(0.1);
      case 'Scheduled':
        return Colors.orange.withOpacity(0.1);
      case 'Active':
      default:
        return Colors.red.withOpacity(0.1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Show detailed alert information in a bottom sheet
        _showAlertDetails(context);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: _getBackgroundColor(),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: _getStatusColor().withOpacity(0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: _getStatusColor().withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with status and verification
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor(),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      _getAlertStatus().toUpperCase(),
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  if (alert.verified == true)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.verified,
                            size: 12.sp,
                            color: Colors.white,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            'VERIFIED',
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  const Spacer(),
                  Icon(
                    Icons.warning_amber_rounded,
                    color: _getStatusColor(),
                    size: 24.sp,
                  ),
                ],
              ),
              SizedBox(height: 12.h),

              // Title
              Text(
                alert.title ?? 'Alert Notification',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                ),
              ),
              SizedBox(height: 8.h),

              // Description
              if (alert.description != null && alert.description!.isNotEmpty)
                Text(
                  alert.description!,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              SizedBox(height: 12.h),

              // Source and timing info
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  children: [
                    if (alert.source != null)
                      Row(
                        children: [
                          Icon(
                            Icons.source,
                            size: 16.sp,
                            color: Colors.black54,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            'Source: ${alert.source}',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 16.sp,
                          color: Colors.black54,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          alert.startedOn != null
                              ? 'Started: ${_formatDateTime(alert.startedOn)}'
                              : 'Created: ${_formatDateTime(alert.createdOn)}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                    if (alert.expireOn != null) ...[
                      SizedBox(height: 6.h),
                      Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            size: 16.sp,
                            color: Colors.black54,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            'Expires: ${_formatDateTime(alert.expireOn)}',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),

              // Additional info row
              if (alert.public == true || alert.point != null) ...[
                SizedBox(height: 8.h),
                Row(
                  children: [
                    if (alert.public == true) ...[
                      Icon(Icons.public, size: 14.sp, color: Colors.blue),
                      SizedBox(width: 4.w),
                      Text(
                        'Public Alert',
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                    if (alert.public == true && alert.point != null)
                      SizedBox(width: 12.w),
                    if (alert.point != null) ...[
                      Icon(Icons.location_on, size: 14.sp, color: Colors.green),
                      SizedBox(width: 4.w),
                      Text(
                        'Location Available',
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                    const Spacer(),
                    Icon(Icons.touch_app, size: 14.sp, color: Colors.grey),
                    SizedBox(width: 2.w),
                    Text(
                      'Tap for details',
                      style: TextStyle(fontSize: 10.sp, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _showAlertDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Handle bar
                  Center(
                    child: Container(
                      width: 40.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Title with status
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          alert.title ?? 'Alert Details',
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          _getAlertStatus(),
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),

                  // Full description
                  if (alert.description != null)
                    Text(
                      alert.description!,
                      style: TextStyle(
                        fontSize: 16.sp,
                        height: 1.5,
                        color: Colors.black87,
                      ),
                    ),
                  SizedBox(height: 20.h),

                  // Detailed information
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDetailRow('ID', alert.id?.toString() ?? 'N/A'),
                          _buildDetailRow('Source', alert.source ?? 'Unknown'),
                          _buildDetailRow(
                            'Verified',
                            alert.verified == true ? 'Yes' : 'No',
                          ),
                          _buildDetailRow(
                            'Public',
                            alert.public == true ? 'Yes' : 'No',
                          ),
                          if (alert.startedOn != null)
                            _buildDetailRow(
                              'Started',
                              alert.startedOn!.toLocal().toString(),
                            ),
                          if (alert.expireOn != null)
                            _buildDetailRow(
                              'Expires',
                              alert.expireOn!.toLocal().toString(),
                            ),
                          if (alert.createdOn != null)
                            _buildDetailRow(
                              'Created',
                              alert.createdOn!.toLocal().toString(),
                            ),
                          if (alert.hazard != null)
                            _buildDetailRow(
                              'Hazard Code',
                              alert.hazard.toString(),
                            ),
                          if (alert.event != null)
                            _buildDetailRow(
                              'Event Code',
                              alert.event.toString(),
                            ),
                          if (alert.point?.coordinates != null &&
                              alert.point!.coordinates!.isNotEmpty)
                            _buildDetailRow(
                              'Coordinates',
                              '${alert.point!.coordinates![1].toStringAsFixed(4)}, ${alert.point!.coordinates![0].toStringAsFixed(4)}',
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100.w,
            child: Text(
              '$label:',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 14.sp, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
