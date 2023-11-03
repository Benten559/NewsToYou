import 'source_model.dart';

String nullCheck(String? apiValue){
  if (apiValue != null){
    return apiValue;
  }
  return "N/A";
}

class Article {
  Source? source;
  String? author = "0";
  String? title = "0";
  String? description = "0";
  String url = "0";
  String? urlToImage = "0";
  String? publishedAt = "0";
  String? content = "0";
 
  Article(
      {this.source,
      this.author,
      this.title,
      this.description,
      required this.url,
      this.urlToImage,
      this.publishedAt,
      this.content});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: Source.fromJson(json['source']),
      author: nullCheck(json['author']),
      title: nullCheck(json['title']),
      description: nullCheck(json['description']),
      url: nullCheck(json['url']),
      urlToImage: nullCheck(json['urlToImage']),
      publishedAt: nullCheck(json['publishedAt']),
      content: nullCheck(json['content']),
    );
  }
}
