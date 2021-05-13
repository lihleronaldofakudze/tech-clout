import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_clout/screens/add_post.dart';
import 'package:tech_clout/screens/notifications.dart';
import 'package:tech_clout/screens/posts.dart';
import 'package:tech_clout/screens/search.dart';
import 'package:tech_clout/screens/users.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final tabs = [
    Posts(),
    Search(),
    AddPost(),
    Notifications(),
    Users()
  ];

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'TechClout',
          style: GoogleFonts.sourceCodePro(
            color: Colors.black
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.person_outline
            ),
          )
        ],
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        showSelectedLabels: false,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.blue,
        elevation: 0,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined
            ),
            label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search
            ),
            label: 'Search'
          ),
          BottomNavigationBarItem(
            icon: PhysicalModel(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: Icon(
                    Icons.add
                ),
              ),
            ),
            label: 'Add'
          ),
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.notifications_active_outlined
              ),
              label: 'Notifications'
          ),
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.article_outlined
              ),
              label: 'Chats'
          ),
        ],
      ),
    );
  }
}
