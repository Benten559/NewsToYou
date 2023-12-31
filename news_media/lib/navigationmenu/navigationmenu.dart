import 'package:NewsToYou/Trending/trendingpage.dart';
import 'package:NewsToYou/news_feed/news_feed.dart';
import 'package:NewsToYou/profilepage/profilepage.dart';
import 'package:NewsToYou/recommended_page/recommended_page.dart';
import 'package:NewsToYou/search_page/search_page.dart';
import 'package:flutter/material.dart';


class NavigationMenu extends StatefulWidget{
  const NavigationMenu ({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int currentPageIndex=0;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: const Color(0xFF56C596),
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.trending_up),
            icon: Icon(Icons.trending_down_outlined),
            label: 'Trending',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.recommend),
            icon: Icon(Icons.recommend_outlined),
            label: 'Recommend',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.search),
            icon: Icon(Icons.search_outlined),
            label: 'Search',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outlined),
            label: 'Profile',
          ),
        ],
      ),
      body: <Widget>[
        Container(
          color: Colors.green,
          alignment: Alignment.center,
          child: const NewsFeedPage(), ///NewsFeedPage here! const Text('Trending Page')
        ),
        Container(
          color: Colors.blue,
          alignment: Alignment.center,
          child: const RecommendedPage(),///recommend page here!
        ),
        Container(
          color: Colors.blue,
          alignment: Alignment.center,
          child: const SearchPage(), ///search page here!
        ),
        Container(
          color: Colors.blue,
          alignment: Alignment.center,
          child: const ProfilePage(),
        ),
      ][currentPageIndex],
    );
  }
}