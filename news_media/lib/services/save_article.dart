import 'dart:convert';

import 'package:NewsToYou/model/article_model.dart';
import 'package:NewsToYou/utility/hash/hash_generator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> saveArticleJSON(String hash, Map<String, dynamic> jsonString) async {

  try {
    final userData = {'articlejson': jsonString};
    await FirebaseFirestore.instance
        .collection('Articles')
        .doc(hash)
        .set(userData);
  }
  catch (e) {
    // ignore: avoid_print
    print('Error failed to save article JSON to DB: $e');
  }
}


Future<void> saveArticleToUser(Article art) async {

  try {
    final jsonString = art.jsonData;
    final hash = generateMD5Hash(jsonString);

    final user = FirebaseAuth.instance.currentUser;
    
    await FirebaseFirestore.instance
        .collection('SavedArticles')
        .doc(user!.email)
        .update({'article': FieldValue.arrayUnion([hash])});

    saveArticleJSON(hash, jsonString);
  }
  catch (e) {
    // ignore: avoid_print
    print('Error Saving article HASH to DB: $e');
  }
}

