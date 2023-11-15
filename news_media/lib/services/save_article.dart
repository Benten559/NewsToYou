import 'dart:convert';

import 'package:NewsToYou/model/article_model.dart';
import 'package:NewsToYou/utility/hash/hash_generator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Query the database in order to retrieve a list of all
/// currently stored articles
Future<List<String>> getUserSavedArticles() async {
  try {
    final user = FirebaseAuth.instance.currentUser;
    final userHashes = await FirebaseFirestore.instance
        .collection('SavedArticles')
        .doc(user!.email)
        .get();
    if (userHashes.exists) {
      final hashList = (userHashes.data() as Map<String, dynamic>)['article'];
      return List<String>.from(hashList);
    } else {
      return <String>[];
    }
  } catch (e) {
    print(
        "getUserSavedArticles()::Error failed to retrieve all user hashes: $e");
    return <String>[];
  }
}

/// Query the database of the currently active user and verify
/// whether or not [hash] already exists under their email.
Future<bool> isSavedArticle(String hash) async {
  try {
    final user = FirebaseAuth.instance.currentUser;
    final userHashes = await FirebaseFirestore.instance
        .collection('SavedArticles')
        .doc(user!.email)
        .get();

    // List of user hashes from the database
    if (userHashes.exists) {
      final hashList = (userHashes.data() as Map<String, dynamic>)['article'];
      // print(hashList);
      if (hashList.isNotEmpty) {
        return hashList.contains(hash);
      }
    }
    return false;
  } catch (e) {
    // ignore: avoid_print
    print('isSavedArticle()::Error failed to check if article is in DB: $e');
    return false;
  }
}

/// Performs database operation, in which [hash] relates to a [jsonString]
/// within the `articlejson` field of the `Articles` collection.
Future<void> saveArticleJSON(
    String hash, Map<String, dynamic> jsonString) async {
  try {
    final userData = {'articlejson': jsonString};
    await FirebaseFirestore.instance
        .collection('Articles')
        .doc(hash)
        .set(userData);
  } catch (e) {
    // ignore: avoid_print
    print('saveArticleJSON()::Error failed to save article JSON to DB: $e');
  }
}

/// Performs 2 database operations, based on the relevant `Article` model type
/// data [hash] and [artJson]. Where [hash] is mapped to a users email in the
/// `SavedArticles` collection, and the articles json is mapped to its hash in the
///  `articlejson` collection using method `saveArticleJSON`
Future<void> saveArticleToUser(
    String hash, Map<String, dynamic> artJson) async {
  try {
    final user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('SavedArticles')
        .doc(user!.email)
        .update({
      'article': FieldValue.arrayUnion([hash])
    });

    saveArticleJSON(hash, artJson);
  } catch (e) {
    // ignore: avoid_print
    print('saveArticleToUser()::Error Saving article HASH to DB: $e');
  }
}

/// Perform a field deletion from the database
/// 
void deleteArticleHashFromUser(String hash) async
{
  try
  {
    final user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('SavedArticles')
        .doc(user!.email)
        .update({
      'article': FieldValue.arrayRemove([hash])
    });
  }
  catch (e)
  {
    // ignore: avoid_print
    print("deleteArticleHashFromUser()::Could not delete the saved article: $e");
  }
}