import 'package:flutter/material.dart';
import 'package:NewsToYou/model/article_model.dart';
import 'package:NewsToYou/components/save_indicator.dart';

Widget customListTile(Article article, BuildContext context) {
  return InkWell(
    // ignore: deprecated_member_use
    child: Container(
      margin: const EdgeInsets.all(12.0),
      padding: const EdgeInsets.all(8.0),
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
            width: MediaQuery.of(context).size.width,//double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(article.urlToImage ?? "N/A"),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF56c596),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Text(
                  article.source?.name ?? "N/A",
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
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
