import 'package:flutter/material.dart';
import 'package:tech_clout/screens/chats_screen.dart';
import 'package:tech_clout/screens/posts_screen.dart';
import 'package:tech_clout/screens/users_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          leading: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/logo.png'),
                    fit: BoxFit.cover)),
          ),
          elevation: 0,
          title: Text(
            'TechClout',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
              onPressed: () {
                // Navigator.pushNamed(context, '/user_profile');
              },
              icon: Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/user_profile');
              },
              icon: Icon(Icons.person_outline),
            ),
          ],
          bottom: TabBar(
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.black,
              tabs: [
                Tab(
                  text: 'POSTS',
                ),
                Tab(
                  text: 'CHATS',
                ),
                Tab(
                  text: 'USERS',
                ),
              ]),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            Navigator.pushNamed(context, '/add_post');
          },
          child: Icon(Icons.add),
        ),
        body: TabBarView(
          children: [PostsScreen(), ChatsScreen(), UsersScreen()],
        ),
      ),
    );
  }
}
