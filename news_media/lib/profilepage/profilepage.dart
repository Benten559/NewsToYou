import 'package:NewsToYou/components/customListTile.dart';
import 'package:NewsToYou/model/article_model.dart';
import 'package:NewsToYou/services/api_service.dart';
import 'package:NewsToYou/services/article_click.dart';
import 'package:NewsToYou/utility/callbacks/article_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:NewsToYou/customized/commonbtn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import '../login/login.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  // ApiService client = ApiService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser!;
  final usercollection = FirebaseFirestore.instance.collection('Users');
  List<Article> _savedArticles = [];
  bool _articleRefresh = false;

  Future<void> _signOut() async {
    await _auth.signOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

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
            onPressed: () {},
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
            final userData = snapshot.data!.data() as Map<String, dynamic>;
            return Container(
                child: Column(
              children: [
                const SizedBox(height: 50),

                ///Avatar
                const Icon(
                  Icons.person,
                  size: 72,
                ),

                Text(
                  user.email!,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[700]),
                ),

                ///nickname
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///Section name
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
                                await showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          backgroundColor: Colors.grey[900],
                                          title: const Text(
                                            "Edit Nickname",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          content: TextField(
                                            autofocus: true,
                                            style: const TextStyle(
                                                color: Colors.white),
                                            decoration: const InputDecoration(
                                              labelText: "Enter new Nickname",
                                            ),
                                            onChanged: (value) {
                                              newvalue = value;
                                            },
                                          ),
                                          actions: [
                                            TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                            TextButton(
                                                onPressed: () =>
                                                    Navigator.of(context)
                                                        .pop(newvalue),
                                                child: const Text(
                                                  "save",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ))
                                          ],
                                        ));

                                if (newvalue.trim().isNotEmpty) {
                                  usercollection
                                      .doc(user.email!)
                                      .update({"nickname": newvalue});
                                }
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.grey[600],
                              )),
                        ],
                      ),

                      ///Text Content
                      Text(userData['nickname']),
                    ],
                  ),
                ),

                ///age
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///Section name
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Age",
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                          IconButton(
                              onPressed: () async {
                                String newvalue = "";
                                await showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          backgroundColor: Colors.grey[900],
                                          title: const Text(
                                            "Edit Age",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          content: TextField(
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                            ],
                                            autofocus: true,
                                            style: const TextStyle(
                                                color: Colors.white),
                                            decoration: const InputDecoration(
                                              labelText: "Enter new Age",
                                            ),
                                            onChanged: (value) {
                                              newvalue = value;
                                            },
                                          ),
                                          actions: [
                                            TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                            TextButton(
                                                onPressed: () =>
                                                    Navigator.of(context)
                                                        .pop(newvalue),
                                                child: const Text(
                                                  "save",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ))
                                          ],
                                        ));

                                if (newvalue.trim().isNotEmpty) {
                                  usercollection
                                      .doc(user.email!)
                                      .update({"age": newvalue});
                                }
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.grey[600],
                              )),
                        ],
                      ),

                      ///Text Content
                      Text(userData['age']),
                    ],
                  ),
                ),

                ///gender
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///Section name
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Gender",
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                          IconButton(
                              onPressed: () async {
                                String? selectedGender = "Male";
                                await showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    backgroundColor: Colors.grey[900],
                                    title: const Text(
                                      "Edit Gender",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    content: DropdownButton<String>(
                                      value: selectedGender,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedGender = newValue!;
                                        });
                                      },
                                      padding: const EdgeInsets.only(
                                          top: 3, left: 15),
                                      items: <String>['Male', 'Female', 'Other']
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          Navigator.of(context)
                                              .pop(selectedGender);
                                          await usercollection
                                              .doc(user.email!)
                                              .update(
                                                  {"gender": selectedGender});
                                        },
                                        child: const Text(
                                          "Save",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.grey[600],
                              )),
                        ],
                      ),

                      ///Text Content
                      Text(userData['gender']),
                    ],
                  ),
                ),
                const Text("Archived Articles"),
                Expanded(
                  child: FutureBuilder(
                    future: _fetchArticles(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting &&
                          _savedArticles.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        // Display your data using a ListView
                        return ListView.builder(
                          itemCount: _savedArticles.length,
                          itemBuilder: (context, index) => InkWell(
                              onTap: () => handleURLButtonPress(
                                  context, _savedArticles[index].url),
                              child: customListTile(_savedArticles[index])),
                        );
                      }
                    },
                  ),
                ),

                CommonBtn(
                  text: 'Logout',
                  onPressed: () async {
                    await _signOut();
                  },
                  height: 60,
                  width: double.infinity,
                  radius: 6,
                ),
              ],
            ));
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
      // SingleChildScrollView(
      //   child: _buildView(context),
      // ),
    );
  }

  /// Helper method to populate widgets `_savedArticles` property.
  /// Will update the page with results if/when the user prompts for a refresh
  /// TODO add the refresh functionality
  Future<void> _fetchArticles() async {
    if (_articleRefresh) return;
    _savedArticles = await getUserSavedArticlesJSON();
    _articleRefresh = !_articleRefresh;
  }
}
