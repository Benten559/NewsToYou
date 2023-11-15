import 'package:NewsToYou/model/article_model.dart';
import 'package:NewsToYou/services/save_article.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SaveButton extends StatefulWidget {
  Article article;

  SaveButton(this.article, {super.key});

  @override
  _SaveButton createState() => _SaveButton();
}

class _SaveButton extends State<SaveButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: ElevatedButton(
          onPressed: () => {
                setState(() {
                  if (!widget.article.saved) {
                    print(widget.article.hash);
                    saveArticleToUser(
                        widget.article.hash,
                        widget.article
                            .jsonData); //Save an individual article in firestore, for a user
                  } else {
                    deleteArticleHashFromUser(widget.article.hash);
                  } //remove it from the database
                  widget.article.saved = !widget.article.saved;
                })
              },
          style: ElevatedButton.styleFrom(
              foregroundColor:
                  widget.article.saved ? Colors.teal : Colors.black,
              backgroundColor:
                  widget.article.saved ? Colors.teal : Colors.black),
          child: Text(widget.article.saved ? "Saved" : "save",
              style: const TextStyle(color: Colors.white))),
    );
  }
}
