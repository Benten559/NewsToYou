import 'package:flutter/material.dart';
import 'package:NewsToYou/model/article_model.dart';
import 'package:NewsToYou/components/save_indicator.dart';

Widget customListTile(Article article) {


  return InkWell(
    // ignore: deprecated_member_use
    child: Container(
      margin: const EdgeInsets.all(12.0),
      padding: const EdgeInsets. all(8.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 3.0,
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200.0,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(article.urlToImage ?? "N/A"),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Text(
                  article.source?.name ?? "N/A",
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              SaveButton(article),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            article.title ?? "N/A",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          )
        ],
      ),
    ),
  );
}
