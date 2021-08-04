import 'package:flutter/material.dart';
import 'package:tech_clout/screens/chats.dart';
import 'package:tech_clout/screens/posts.dart';
import 'package:tech_clout/screens/users.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
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
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            Navigator.pushNamed(context, '/add_post');
          },
          child: Icon(Icons.add),
        ),
        body: TabBarView(
          children: [Posts(), Chats(), Users()],
        ),
      ),
    );
  }
}
