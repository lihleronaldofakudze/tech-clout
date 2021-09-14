import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_clout/models/RegisteredUser.dart';
import 'package:tech_clout/screens/home_screen.dart';
import 'package:tech_clout/screens/welcome_screen.dart';

class AuthChange extends StatelessWidget {
  const AuthChange({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<RegisteredUser>(context);
    return user == null ? WelcomeScreen() : HomeScreen();
  }
}
