import 'package:NewsToYou/customized/app_colors.dart';
import 'package:NewsToYou/customized/ourlogo.dart';
import 'package:NewsToYou/model/article_model.dart';
import 'package:NewsToYou/services/api_service.dart';
import 'package:NewsToYou/components/customListTile.dart';
import 'package:NewsToYou/utility/callbacks/article_tile.dart';
import 'package:flutter/material.dart';

class NewsFeedPage extends StatefulWidget {
  const NewsFeedPage({Key? key}) : super(key: key);

  @override
  State<NewsFeedPage> createState() => _NewsFeedPage();
}

class _NewsFeedPage extends State<NewsFeedPage> {
  ApiService client = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 100,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Column(
            children: [
              Text(
                "Trending",
                style: TextStyle(
                  fontSize: 80,
                  color: AppColors.defaulttextcolor,
                ),
              ),
            ],
          ),
        ),
        body: FutureBuilder(
          future: client.getArticle(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Article>?> snapshot) {
            if (snapshot.hasData) {
              List<Article>? articles = snapshot.data;
              return ListView.builder(
                  itemCount: articles?.length,
                  itemBuilder: (context, index) => InkWell(
                        onTap: () =>
                            handleURLButtonPress(context, articles[index].url),
                        child: customListTile(articles![index], context),
                      ));
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
