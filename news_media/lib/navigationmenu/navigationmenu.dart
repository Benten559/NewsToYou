import 'package:NewsToYou/news_feed/news_feed.dart';
import 'package:NewsToYou/profilepage/profilepage.dart';
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
        indicatorColor: Colors.amber[800],
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.newspaper),
            icon: Icon(Icons.newspaper_outlined),
            label: 'News',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.trending_down),
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
          color: Colors.red,
          alignment: Alignment.center,
          child: NewsFeedPage(),
        ),
        Container(
          color: Colors.green,
          alignment: Alignment.center,
          child: const Text('Trending Page'), ///trending page here!
        ),
        Container(
          color: Colors.blue,
          alignment: Alignment.center,
          child: const Text('Recommend Page'), ///recommend page here!
        ),
        Container(
          color: Colors.blue,
          alignment: Alignment.center,
          child: const Text('Search Page'), ///search page here!
        ),
        Container(
          color: Colors.blue,
          alignment: Alignment.center,
          child: ProfilePage(),
        ),
      ][currentPageIndex],
    );
  }
}