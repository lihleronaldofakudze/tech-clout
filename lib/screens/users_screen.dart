import 'package:flutter/material.dart';
import 'package:tech_clout/widgets/users_list.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UsersList();
  }
}
