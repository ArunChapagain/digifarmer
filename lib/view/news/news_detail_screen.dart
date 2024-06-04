import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:remixicon/remixicon.dart';

class NewsDetailPage extends StatelessWidget {
  const NewsDetailPage({super.key, this.news});
  final dynamic news;
  @override
  Widget build(BuildContext context) {
    print(news);
    String content = news['content'];
    content = content.replaceAll(RegExp(r'\[\+\d+ chars\]$'), '');
    final date =
        DateFormat('MMMM dd, yyyy').format(DateTime.parse(news['publishedAt']));
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: IconButton(
          icon: Icon(
            Remix.arrow_left_s_line,
            size: 36.sp,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  news['title'],
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontFamily: GoogleFonts.righteous().fontFamily,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    SizedBox(
                      width: 200.w,
                      child: dotText(news['source']['name']),
                    ),
                    dotText(date),
                  ],
                ),
                SizedBox(height: 5.h),
                news['author'] != null
                    ? dotText(news['author'])
                    : const SizedBox(),
                SizedBox(height: 10.h),
                const Divider(
                  color: Colors.black54,
                  thickness: 0.8,
                ),
                SizedBox(height: 10.h),
                news['urlToImage'] != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          news['urlToImage'],
                          height: 200.h,
                          width: 400.w,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const SizedBox(),
                SizedBox(height: 10.h),
                Text(
                  content,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dotText(String text) {
    return Row(
      children: [
        Icon(
          Remix.circle_fill,
          size: 10.sp,
        ),
        SizedBox(width: 5.w),
        Text(
          text,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
