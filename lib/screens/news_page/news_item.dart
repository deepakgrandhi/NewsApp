import 'package:cometlabs/api/models/articles.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetails extends StatelessWidget {
  final Articles articles;
  final PageController controller;
  final VoidCallback onFinished;

  const NewsDetails({Key? key, required this.articles, required this.controller, required this.onFinished}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints){
        return Stack(fit: StackFit.passthrough, children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Image.network(
                      articles.urlToImage!,
                      height: constraints.maxHeight * 0.5,
                      fit: BoxFit.fitHeight,
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.4,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(articles.title!.toUpperCase(),
                              textAlign: TextAlign.center,
                              textScaleFactor: 1,),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, right: 8.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "Author : ${articles.author}",
                      textScaleFactor: 1,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Text(
                    articles.description!,
                    textScaleFactor: 1,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(height: 100,),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 80,
                    child: Center(
                      child: Container(
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  colors: [
                                    Color(0xff3CA55C),
                                    Color(0xffB5AC49)
                                  ]
                              ),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          height: 40,
                          margin:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            child: MaterialButton(
                              onPressed: () {
                                launchUrl(Uri.parse(articles.url!));
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                child: Center(
                                  child: Text("Know more",
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                          )),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 80,
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xff02AAB0),
                              Color(0xff56B4D3)
                            ]
                          ),
                          borderRadius: BorderRadius.circular(10)
                        ),
                          height: 40,
                          margin:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            child: MaterialButton(
                              onPressed: () {
                                onFinished();
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                child: Center(
                                  child: Text("Next",
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                          )),
                    ),
                  ),
                ),
              ],
            ),
          )
        ]);
      },
    );
  }
}
