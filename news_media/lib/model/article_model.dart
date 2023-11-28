import 'package:NewsToYou/utility/hash/hash_generator.dart';

import 'source_model.dart';

String nullCheck(String? apiValue) {
  if (apiValue != null) {
    return apiValue;
  }
  return "N/A";
}

class Article {
  final Map<String, dynamic> jsonData;
  final String hash;
  final Source? source;
  final String? author;
  final String? title;
  final String? description;
  final String url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;
  bool saved = false;

  Article({
    required this.jsonData,
    required this.hash,
    this.source,
    this.author,
    this.title,
    this.description,
    required this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      jsonData: json, // Store the original JSON data here
      hash: generateMD5Hash(json),
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

  /// This generator constructor is used when loading an article from
  /// the database. It is not necessary to generate a hash, use the one used to 
  /// reference the database entry
  factory Article.fromDB(Map<String, dynamic> json, refHash) {
    return Article(
      jsonData: json, // Store the original JSON data here
      hash: refHash,
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
