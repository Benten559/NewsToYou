import 'package:NewsToYou/globals/user_session.dart';
import 'package:NewsToYou/model/article_model.dart';
import 'package:NewsToYou/services/save_article.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SaveButton extends StatefulWidget {
  Article article;

  // const SaveButton({super.key});
  SaveButton(this.article, {super.key});
  @override
  _SaveButton createState() => _SaveButton();
}

class _SaveButton extends State<SaveButton> {
  bool _savePressed = false;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: ElevatedButton(
          onPressed: () => {
                setState(() {
                  var s = Singleton();
                  // ignore: avoid_print
                  print(s.userName);
                  print("CLICKED SAVE");
                  saveArticleToUser(widget.article); //Save an individual article in firestore, for a user
                  _savePressed = !_savePressed;
                })
              },
          style: ElevatedButton.styleFrom(
              foregroundColor: _savePressed ? Colors.teal : Colors.black,
              backgroundColor: _savePressed ? Colors.teal : Colors.black),
          child: Text(_savePressed ? "Saved" : "save",
              style: const TextStyle(color: Colors.white))),
    );

  }
}
