import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_clout/models/registered_user.dart';
import 'package:tech_clout/screens/home.dart';
import 'package:tech_clout/screens/welcome.dart';

class AuthChange extends StatelessWidget {
  const AuthChange({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<RegisteredUser>(context);
    return user == null ? Welcome() : Home();
  }
}
