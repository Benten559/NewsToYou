import 'dart:convert';
import 'package:NewsToYou/services/article_click.dart';
import 'package:http/http.dart' as http;
import 'package:NewsToYou/model/article_model.dart';
import 'package:NewsToYou/auth/secrets.dart' as secrets;

class ApiService {
  final endPointUrl = "newsapi.org";
  final client = http.Client();
  Future<List<Article>> getArticle() async {
    final queryParameters = {
      'country': 'us',
      'category': 'technology',
      'apiKey': secrets.newsAPIKey
    };
    final uri = Uri.https(endPointUrl, '/v2/top-headlines', queryParameters);
    final response = await client.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    List<dynamic> body = json['articles'];
    List<Article> articles =
        body.map((dynamic item) => Article.fromJson(item)).toList();

    // Get a list of all hashes in db
    final hashesList = await getUserSavedArticles();
    if (hashesList.isNotEmpty) {
      for (int i = 0; i < articles.length; i++) {
        articles[i].saved = hashesList.contains(articles[i].hash);
      }
    }
    return articles;
  }

  Future<Map<String, List<Article>>> getCategoricalArticles() async {
    Map<String, List<Article>> articlesByCategory = {};
    try {
      final categoriesList = await getUserCategories();
      if (categoriesList.isNotEmpty) {
        print("THE CATEGORIES OF A USER: $categoriesList");
        // TODO
        // Construct map of {category: [articles]}
        for (int i = 0; i < categoriesList.length; i++) {
          articlesByCategory[categoriesList[i]] =
              await searchArticles(categoriesList[i], "");
        }
      }
      return articlesByCategory;
    } catch (e) {
      print("Error occurred during getCategoricalArticles() e: $e");
      return articlesByCategory;
    }
  }

  /// Enables News API Everything endpoint
  /// Search parameters are as follows
  Future<List<Article>> searchArticles(String q, String sortBy) async {
    try {
      const endPointUrl = "newsapi.org";
      final client = http.Client();
      final queryParameters = {
        'q': q,
        'sortBy': 'popularity',
        // 'pageSize' : 20,
        'apiKey': secrets.newsAPIKey
      };
      final uri = Uri.https(endPointUrl, '/v2/everything', queryParameters);
      final response = await client.get(uri);
      Map<String, dynamic> json = jsonDecode(response.body);
      List<dynamic> body = json['articles'];
      List<Article> articles =
          body.map((dynamic item) => Article.fromJson(item)).toList();

      // Get a list of all hashes in db
      final hashesList = await getUserSavedArticles();
      if (hashesList.isNotEmpty) {
        for (int i = 0; i < articles.length; i++) {
          articles[i].saved = hashesList.contains(articles[i].hash);
        }
      }

      return articles;
    } catch (e) {
      // ignore: avoid_print
      print("searchArticles()::Error $e");
      return <Article>[];
    }
  }
}
