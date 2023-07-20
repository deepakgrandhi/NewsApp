import 'package:cometlabs/api/models/articles.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LatestNewsItem extends StatelessWidget {
  final Articles article;

  const LatestNewsItem({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Hot Topic 🔥",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Image.network(
              article.urlToImage!,
              height: 200,
              width: 150,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      article.description!,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text("Author : ${article.author ?? ""}", maxLines: 1,style: const TextStyle(fontSize: 12),),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black12),
                          gradient: const LinearGradient(
                              colors: [Colors.blue, Colors.red])),
                      child: InkWell(
                        onTap: (){
                          launchUrl(Uri.parse(article.url!));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: const Text(
                            "Know more",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
