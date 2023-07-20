import 'package:cometlabs/api/models/articles.dart';
import 'package:cometlabs/screens/news_page/news_item.dart';
import 'package:flutter/material.dart';

class NewsItemDetailsScreen extends StatefulWidget {
  const NewsItemDetailsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewsItemDetailsScreen();
}

class _NewsItemDetailsScreen extends State<NewsItemDetailsScreen> {
  dynamic args;
  List<Articles> articles = [];
  int currentIndex = 0;
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        args = ModalRoute.of(context)?.settings.arguments;
        currentIndex = args["index"];
        articles = args["articles"];
        pageController.jumpToPage(currentIndex);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
          controller: pageController,
          itemCount: articles.length,
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return NewsDetails(
              articles: articles[currentIndex],
              controller: pageController,
              onFinished: () {
                setState(() {
                  currentIndex = currentIndex +1;
                });
                if (currentIndex + 1 == articles.length) {
                  Navigator.pop(context);
                } else {
                  pageController.animateToPage(currentIndex,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn);
                }
              },
            );
          },
        ),
      ),
    );
  }
}
