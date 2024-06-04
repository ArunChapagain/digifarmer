import 'package:digifarmer/view/news/controller/pagination_scroll_control.dart';
import 'package:flutter/material.dart';

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
    paginationScrollController.init(
      loadAction: () {
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
      body: SafeArea(
        child: ListView.builder(
          controller: paginationScrollController.scrollController,
          itemCount: 1,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('News $index'),
            );
          },
        ),
      ),
    );
  }
}
