import 'package:flutter/material.dart';
import 'package:netflix_api/screens/home_screen.dart';
import 'package:netflix_api/screens/more_screen.dart';
import 'package:netflix_api/screens/search_screen.dart';

class BottamNavBar extends StatelessWidget {
  const BottamNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: Container(
          color: Colors.black,
          height: 70,
          child: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.home),
                text: 'Home',
              ),
              Tab(
                icon: Icon(Icons.search),
                text: 'Search',
              ),
              Tab(
                icon: Icon(Icons.photo_library_outlined),
                text: 'New & Hot',
              ),
            ],
            indicatorColor: Colors.transparent,
            labelColor: Colors.white,
            unselectedLabelColor: Color(0xff999999),
          ),
        ),
        body: const TabBarView(children: [
          HomeScreen(),
          SearchScreen(),
          MoreScreen(),
        ]),
      ),
    );
  }
}
