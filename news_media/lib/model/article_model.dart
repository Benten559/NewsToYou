import 'source_model.dart';

String nullCheck(String? apiValue) {
  if (apiValue != null) {
    return apiValue;
  }
  return "N/A";
}

class Article {
  final Map<String, dynamic> jsonData;
  final Source? source;
  final String? author;
  final String? title;
  final String? description;
  final String url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  Article({
    required this.jsonData,
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





// import 'source_model.dart';

// String nullCheck(String? apiValue){
//   if (apiValue != null){
//     return apiValue;
//   }
//   return "N/A";
// }

// class Article {
//   // Map<String, dynamic> jsonData = '{"x":true}' as Map<String, dynamic>;
//   Source? source;
//   String? author = "0";
//   String? title = "0";
//   String? description = "0";
//   String url = "0";
//   String? urlToImage = "0";
//   String? publishedAt = "0";
//   String? content = "0";
 
//   Article(
//       {this.source,
//       this.author,
//       this.title,
//       this.description,
//       required this.url,
//       this.urlToImage,
//       this.publishedAt,
//       this.content,
//       // required Map<String, dynamic> jsonData 
//       });

//   // Map toJson(){ return jsonData;}

//   factory Article.fromJson(Map<String, dynamic> json) {
//     return Article(
//       // jsonData:json,
//       source: Source.fromJson(json['source']),
//       author: nullCheck(json['author']),
//       title: nullCheck(json['title']),
//       description: nullCheck(json['description']),
//       url: nullCheck(json['url']),
//       urlToImage: nullCheck(json['urlToImage']),
//       publishedAt: nullCheck(json['publishedAt']),
//       content: nullCheck(json['content']),
//     );

//   }
// }
