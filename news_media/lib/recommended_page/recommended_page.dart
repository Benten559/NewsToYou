import 'package:NewsToYou/customized/ourlogo.dart';
import 'package:NewsToYou/model/article_model.dart';
import 'package:NewsToYou/services/api_service.dart';
import 'package:NewsToYou/components/customListTile.dart';
import 'package:NewsToYou/utility/callbacks/article_tile.dart';
import 'package:flutter/material.dart';

class RecommendedPage extends StatefulWidget {
  const RecommendedPage({Key? key}) : super(key: key);

  @override
  State<RecommendedPage> createState() => _RecommendedPage();
}

class _RecommendedPage extends State<RecommendedPage> {
  ApiService client = ApiService();
  late Future<Map<String, List<Article>>> categoriesFuture;
  String selectedCategory = "All"; //by default this shows all items

  @override
  void initState() {
    super.initState();
    categoriesFuture = client.getCategoricalArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 105,
          centerTitle: true,
          elevation: 0,
          title: const Column(
            children: [
              OurLogo(),
              SizedBox(height: 5),
              Text(
                'Recommended',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        body: FutureBuilder(
          future: categoriesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final Map<String, List<Article>>? categories = snapshot.data;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Toolbar
                  Container(
                    height: 20,
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        for (var category in ['All', ...categories!.keys])
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  selectedCategory = category;
                                });
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  category == selectedCategory
                                      ? Colors.blue
                                      : Colors.grey,
                                ),
                              ),
                              child: Text(category),
                            ),
                          ),
                      ],
                    ),
                  ),
                  // Main List
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories.keys.elementAt(index);
                        final items = categories[category];
                        // Filter items based on selected category
                        final filteredItems = selectedCategory == 'All'
                            ? items
                            : (category == selectedCategory ? items : null);

                        return filteredItems != null
                            ? SingleChildScrollView(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Category Title
                                    Container(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.all(8),
                                      color: Colors.grey[300],
                                      child: Text(
                                        category,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    // List of Items
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height,
                                      width: MediaQuery.of(context).size.width,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: filteredItems.length,
                                        itemBuilder: (context, itemIndex) =>
                                            InkWell(
                                                onTap: () => handleURLButtonPress(
                                                    context,
                                                    filteredItems[itemIndex].url),
                                                child: customListTile(
                                                    filteredItems[itemIndex],
                                                    context)),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                            )
                            : Container(); // Return an empty container for non-matching categories
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ));
  }
}