import 'package:NewsToYou/customized/ourlogo.dart';
import 'package:NewsToYou/model/article_model.dart';
import 'package:NewsToYou/services/api_service.dart';
import 'package:NewsToYou/components/customListTile.dart';
import 'package:flutter/material.dart';
import 'package:NewsToYou/WebView/webview.dart';
import '../customized/commonbtn.dart';


class TrendingPage extends StatefulWidget {
  TrendingPage({Key? key}) : super(key: key);

  @override
  State<TrendingPage> createState() => _TrendingPage();
}

class _TrendingPage extends State<TrendingPage> {
  ApiService client = ApiService();
  static final links = ['flutter'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 105,
        centerTitle: true,
        //backgroundColor: Colors.transparent,
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
        body: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: links.map((link) => _urlButton(context, link)).toList(),
                )));
  }

      Widget _urlButton(BuildContext context, String url) {
      return Container(
          padding: EdgeInsets.all(20.0),
          child: ElevatedButton(
            child: Text(url),
            onPressed: () => _handleURLButtonPress(context, url),
          ));
    }

    void _handleURLButtonPress(BuildContext context, String url) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => WebViewPage()));
    }
  }