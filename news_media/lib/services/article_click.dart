import 'package:NewsToYou/model/article_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Query the database in order to retrieve a list of all
/// currently stored articles as hashes
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

/// Query the database and retrieve the JSON associated with
/// all a user's saved articles
Future<List<Article>> getUserSavedArticlesJSON() async {
  try {
    final userHashes = await getUserSavedArticles();
    List<Article> articlesJson = [];
    if (userHashes.isNotEmpty) {
      for (final hash in userHashes) {
        final articleSnapshot = await FirebaseFirestore.instance
            .collection("Articles")
            .doc(hash)
            .get();
        if (articleSnapshot.exists) {
          articlesJson.add(
              Article.fromDB(articleSnapshot.data()!['articlejson'], hash));
        } else {
          print("SNAPSHOT DOES NOT EXIST $articleSnapshot");
        }
      }
    } else {
      print("No Articles to load");
    }
    for (int i = 0; i < articlesJson.length; i++) {
      // Initialize all these to true since we just retrieved them from the DB
      articlesJson[i].saved = true;
    }
    return articlesJson;
  } catch (e) {
    print(
        "getUserSavedArticlesJSON()::Error failed to retrieve all user articles");
    final List<Article> defaultRet = [];
    return defaultRet;
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

/// Checks whether a certain collection contains a user's email as a document.
/// This is necessary when attempting to save/load data listed under a user.
/// Should an email not be within an collections document id's then single one will be added.
/// The document is added along with a stub field entry denoted by `fieldKey` and given an empty array value
/// `collection` : The collection table to look reference
/// `email` : The field to search for
/// `fieldKey : (Optional) The field name to add under a users document `email`
Future<void> addUserEmailInCollection(String collection, String? email,
    [String fieldKey = 'article']) async {
  final userDoc = FirebaseFirestore.instance.collection(collection).doc(email);
  final user = await userDoc.get();
  if (!user.exists) {
    userDoc.set({fieldKey: []});
  }
}

/// Performs 2 database op erations, based on the relevant `Article` model type
/// data [hash] and [artJson]. Where [hash] is mapped to a users email in the
/// `SavedArticles` collection, and the articles json is mapped to its hash in the
///  `articlejson` collection using method `saveArticleJSON`
Future<void> saveArticleToUser(
    String hash, Map<String, dynamic> artJson) async {
  try {
    final user = FirebaseAuth.instance.currentUser;
    await addUserEmailInCollection("SavedArticles", user!.email, 'article');
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
void deleteArticleHashFromUser(String hash) async {
  try {
    final user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('SavedArticles')
        .doc(user!.email)
        .update({
      'article': FieldValue.arrayRemove([hash])
    });
    print("removed: $hash from : " + user!.email.toString());
  } catch (e) {
    // ignore: avoid_print
    print(
        "deleteArticleHashFromUser()::Could not delete the saved article: $e");
  }
}

Future<List<String>> getUserCategories() async {
  try {
    List<String> categoriesList = [];
    final user = FirebaseAuth.instance.currentUser;
    final userCategories = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.email)
        .get();
    if (userCategories.exists) {
      print("FOUND SOME CATEGORIES");
      if (userCategories.data()!.isNotEmpty) {
        print("THE CATEGORIES: ");
        categoriesList = (userCategories.data()?['categories'] as List).map((item) => item as String).toList();
        // print(userCategories.data()!['categories']);
        // return userCategories.data()!['categories'];
        return categoriesList;
      } else {
        //default return
        return categoriesList;
      }
    } else {
      //default return
      return categoriesList;
    }
  } catch (e) {
    print("No categories found under user, $e");
    return <String>[];
  }
}
