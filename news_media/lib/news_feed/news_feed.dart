import 'package:NewsToYou/customized/ourlogo.dart';
import 'package:NewsToYou/model/article_model.dart';
import 'package:NewsToYou/services/api_service.dart';
import 'package:NewsToYou/components/customListTile.dart';
import 'package:flutter/material.dart';
// import 'package:NewsToYou/customized/commonbtn.dart';

class NewsFeedPage extends StatefulWidget {
  NewsFeedPage({Key? key}) : super(key: key);

  @override
  State<NewsFeedPage> createState() => _NewsFeedPage();
}

class _NewsFeedPage extends State<NewsFeedPage> {
  ApiService client = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 105,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Column(
            children: [
              OurLogo(),

              SizedBox(height: 5),

              //page hint
              Text(
                'News Feed',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15,
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
              // if (snapshot.error!){
              List<Article>? articles = snapshot.data;
              return ListView.builder(
                  itemCount: articles?.length,
                  itemBuilder: (context, index) =>
                      customListTile(articles![index]));
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        )
        // SingleChildScrollView(
        //   child: _buildView(context),
        // ),
        );
  }
}
