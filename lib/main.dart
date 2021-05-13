import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_clout/screens/comments.dart';
import 'package:tech_clout/screens/edit_profile.dart';
import 'package:tech_clout/screens/home.dart';
import 'package:tech_clout/screens/login.dart';
import 'package:tech_clout/screens/register.dart';
import 'package:tech_clout/screens/user_profile.dart';
import 'package:tech_clout/screens/welcome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tech Clout',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}
