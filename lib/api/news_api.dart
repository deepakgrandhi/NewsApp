import 'package:cometlabs/api/models/articles.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class NewsApi {
  Dio dio = Dio(BaseOptions(
    baseUrl: "https://newsapi.org/v2",
  ));

  Future<List<Articles>> getArticles() async {
    String yesterday = DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(const Duration(days: 1)));
    Response response = await dio.get(
        "/everything?q=tesla&from=$yesterday&sortBy=publishedAt&apiKey=ba933642a9f04875890ca14b614a05bc");
    return (response.data['articles'] as List)
        .map((unitData) => Articles.fromJson(unitData))
        .toList();
  }
}
