import 'package:cometlabs/api/models/articles.dart';
import 'package:cometlabs/api/news_api.dart';
import 'package:cometlabs/screens/home/widgets/latest_news.dart';
import 'package:cometlabs/screens/home/widgets/welcome_widget.dart';
import 'package:cometlabs/widgets/shimmer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Articles> articles = [];
  int displayedItemCount = 10; // Number of items initially displayed

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getArticles();
    _scrollController.addListener(_scrollListener);
  }

  void getArticles() async {
    List<Articles> value = await NewsApi().getArticles();
    setState(() {
      articles = value;
    });
  }

  Future<void> _refreshData() async {
    getArticles();
    setState(() {
      displayedItemCount = 10;
    });
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      // Load more items when the user reaches the end of the list
      setState(() {
        displayedItemCount += 10;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RefreshIndicator(
            onRefresh: _refreshData,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Hero(
                    tag: 'news_app_title',
                    child: Text(
                      'News App',
                      textScaleFactor: 1,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ),
                  const WelcomeWidget(),
                  articles.isNotEmpty ? LatestNewsItem(article: articles[0]) : const ShimmerEffect(),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Divider(color: Colors.grey,),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (index >= displayedItemCount) return const SizedBox.shrink();
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "/news_item_details",
                              arguments: {"articles": articles, "index": index + 1});
                        },
                        child: Row(
                          children: [
                            Expanded(child: Text(articles[index + 1].title!)),
                            const Icon(Icons.arrow_circle_right)
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      if (index >= displayedItemCount - 1) return const SizedBox.shrink();
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Divider(
                          color: Colors.grey,
                        ),
                      );
                    },
                    itemCount: displayedItemCount > articles.length ? articles.length : displayedItemCount,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
