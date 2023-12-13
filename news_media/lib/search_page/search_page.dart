import 'package:NewsToYou/components/customListTile.dart';
import 'package:NewsToYou/model/article_model.dart';
import 'package:NewsToYou/services/api_service.dart';
import 'package:NewsToYou/utility/callbacks/article_tile.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  ApiService client = ApiService();
  List<Article> _searchResults = [];
  final bool _matchCase = false;
  final bool _exactMatch = false;
  bool _searchPrompted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: const Text('Search Page'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Search',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          _searchPrompted = true;
                          // Trigger search when search is pressed.
                          _performSearch();
                        },
                      ),
                    ),
                    onSubmitted: (value) {
                      _searchPrompted = true;
                      // Trigger search when Enter key is pressed.
                      _performSearch();
                    },
                  ),
                ),
                /**IGNORING SPECIFIC SEARCH PARAMETERS FOR NOW */
                // IconButton(
                //   icon: Icon(_matchCase
                //       ? Icons.check_box
                //       : Icons.check_box_outline_blank),
                //   onPressed: () {
                //     setState(() {
                //       _matchCase = !_matchCase;
                //     });
                //   },
                // ),
                // const Text('Match Case'),
                // IconButton(
                //   icon: Icon(_exactMatch
                //       ? Icons.check_box
                //       : Icons.check_box_outline_blank),
                //   onPressed: () {
                //     setState(() {
                //       _exactMatch = !_exactMatch;
                //     });
                //   },
                // ),
                // const Text('Exact Match'),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: _fetchData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting &&
                    _searchResults.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return ListView.builder(
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () => handleURLButtonPress(
                        context,
                        _searchResults[index]
                            .url, // Assuming _searchResults is a list of objects with a 'url' property
                      ),
                      child: customListTile(_searchResults[index], context),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _fetchData() async {
    // Simulating search results. Replace this with your actual search logic.
    if (!_searchPrompted) return;
    final articles =
        await client.searchArticles(_searchController.text, "popularity");

    setState(() {
      _searchPrompted = false;
      _searchResults = articles;
    });
  }

  void _performSearch() {
    // ignore: avoid_print
    print('Search query: ${_searchController.text}');
    // ignore: avoid_print
    print('Match Case: $_matchCase');
    // ignore: avoid_print
    print('Exact Match: $_exactMatch');

    // Call your async function to fetch data
    _fetchData();
  }
}
