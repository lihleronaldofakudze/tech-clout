import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_clout/models/registered_user.dart';
import 'package:tech_clout/models/user.dart';

class UsersList extends StatelessWidget {
  const UsersList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<User>>(context);
    final registeredUser = Provider.of<RegisteredUser>(context);
    return ListView.separated(
        itemBuilder: (context, index) {
          return users[index].uid == registeredUser.uid
              ? Container()
              : ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.black,
                    backgroundImage: NetworkImage(users[index].image),
                  ),
                  title: Text(users[index].username),
                  subtitle: Text(users[index].town),
                );
        },
        separatorBuilder: (_, __) => Divider(),
        itemCount: users.length);
  }
}
