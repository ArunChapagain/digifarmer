import 'package:digifarmer/provider/news_provider.dart';
import 'package:digifarmer/view/news/controller/pagination_scroll_control.dart';
import 'package:digifarmer/view/news/news_detail_screen.dart';
import 'package:digifarmer/widgets/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  PaginationScrollController paginationScrollController =
      PaginationScrollController();

  @override
  void initState() {
    paginationScrollController.init(loadAction: () {
      // => context.read<RequestCubit>().getNewRequests()
    });
    super.initState();
  }

  @override
  void dispose() {
    paginationScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        // forceMaterialTransparency: true,
        centerTitle: true,
        title: Text(
          'News',
          style: TextStyle(
            color: Colors.black,
            fontSize: 35.sp,
            fontFamily: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
            ).fontFamily,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 20.h),
          child:
              Consumer<NewsProvider>(builder: (context, newsProvider, child) {
            final newsList = newsProvider.newsJson;
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              controller: paginationScrollController.scrollController,
              itemCount: newsList.length - 1,
              itemBuilder: (context, index) {
                String? title = newsList[index]['title'];
                return (title) != null
                    ? NewsCard(
                        news: newsList[index + 1],
                      )
                    : const SizedBox();
              },
            );
          }),
        ),
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  const NewsCard({super.key, this.news});
  final dynamic news;

  @override
  Widget build(BuildContext context) {
    final date =
        DateFormat('MMMM dd, yyyy').format(DateTime.parse(news['publishedAt']));
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsDetailPage(news: news),
          ),
        );
      },
      child: AnimatedPress(
        child: Container(
          // height: 120.h,
          // width: 50.h,
          margin: EdgeInsetsDirectional.symmetric(
            horizontal: 10.w,
            vertical: 10.w,
          ),
          padding:
              EdgeInsetsDirectional.symmetric(horizontal: 8.h, vertical: 8.w),
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(15.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.07),
                  blurRadius: 8,
                  offset: const Offset(1, 7),
                )
              ]),
          child: Column(
            children: [
              Row(
                children: [
                  news['urlToImage'] != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: Image.network(
                            news['urlToImage'],
                            height: 80.h,
                            width: 100.w,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const SizedBox(),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      maxLines: 3,
                      news['title'],
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 150.w,
                    child: Text(
                      news['source']['name'],
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Text(
                    date,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
