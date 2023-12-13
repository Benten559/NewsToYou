import 'package:NewsToYou/components/customListTile.dart';
import 'package:NewsToYou/model/article_model.dart';
import 'package:NewsToYou/profilepage/setting.dart';
import 'package:NewsToYou/services/api_service.dart';
import 'package:NewsToYou/services/article_click.dart';
import 'package:NewsToYou/utility/callbacks/article_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser!;
  final usercollection = FirebaseFirestore.instance.collection('Users');
  List<Article> _savedArticles = [];
  List<String> selectedCategories = [];
  List<String> allCategories = [
    'AutoMobiles',
    'Airplanes',
    'Finance',
    'Politics',
    'War',
    'Technology',
    'Music',
    'Movies',
    'Games',
    'Academics',
  ];
  bool _articleRefresh = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
        ],
        title: const Text('Profile'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(user.email!)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userData = snapshot.data?.data() as Map<String, dynamic>?;

            return ListView(
              children: [
                const SizedBox(height: 25),
                const Icon(
                  Icons.person,
                  size: 72,
                ),
                Text(
                  user.email!,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[700]),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Nickname",
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                          IconButton(
                            onPressed: () async {
                              String newvalue = "";
                              await showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.white,
                                builder: (context) => Container(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(context),
                                            child: const Text(
                                              'Cancel',
                                            ),
                                          ),
                                          const Text(
                                            "Edit Nickname",
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              Navigator.pop(context, newvalue);
                                            },
                                            child: const Text(
                                              'Save',
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        height: 55,
                                        padding: const EdgeInsets.only(top: 3, left: 15),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(6),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.1),
                                              blurRadius: 7,
                                            ),
                                          ],
                                        ),
                                        child: TextField(
                                          decoration: const InputDecoration(
                                            hintText: "New Nickname",
                                            border: InputBorder.none,
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              newvalue = value.trim();
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                              if (newvalue.trim().isNotEmpty) {
                                usercollection.doc(user.email!).update({"nickname": newvalue});
                              }
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      Text(userData?['nickname']),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Favorite Categories",
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                          IconButton(
                            onPressed: () async {
                              selectedCategories = List<String>.from(userData?['categories']);
                              List<String> newvalue = [];
                              newvalue = selectedCategories;
                              await showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.white,
                                builder: (context) => StatefulBuilder(
                                  builder: (BuildContext context, StateSetter setState) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(context),
                                              child: const Text(
                                                'Cancel',
                                              ),
                                            ),
                                            const Text(
                                              "Edit Favorite Categories",
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context, newvalue);
                                                if (newvalue.isNotEmpty) {
                                                  usercollection.doc(user.email!).update({"categories": newvalue});
                                                }
                                              },
                                              child: const Text(
                                                "Save",
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Divider(),
                                        Expanded(
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: allCategories.map((category) {
                                                return CheckboxListTile(
                                                  title: Text(category),
                                                  value: newvalue.contains(category),
                                                  onChanged: (bool? value) {
                                                    setState(() {
                                                      if (value != null) {
                                                        if (value) {
                                                          newvalue.add(category);
                                                        } else {
                                                          newvalue.remove(category);
                                                        }
                                                      }
                                                    });
                                                  },
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      Text(userData?['categories'].join(', ')),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Archived Articles"),
                    FutureBuilder(
                      future: _fetchArticles(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting &&
                            _savedArticles.isEmpty) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _savedArticles.length,
                            itemBuilder: (context, index) => InkWell(
                              onTap: () => handleURLButtonPress(
                                  context, _savedArticles[index].url),
                              child: customListTile(_savedArticles[index], context)),
                        );
                      }
                    },
                  )],
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error${snapshot.error}'),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Future<void> _fetchArticles() async {
    if (_articleRefresh) return;
    _savedArticles = await getUserSavedArticlesJSON();
    _articleRefresh = !_articleRefresh;
  }
}
