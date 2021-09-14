import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_clout/models/Clouter.dart';
import 'package:tech_clout/models/RegisteredUser.dart';
import 'package:tech_clout/services/database.dart';

class UsersList extends StatelessWidget {
  const UsersList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<Clouter>>(context);
    final registeredUser = Provider.of<RegisteredUser>(context);
    return ListView.separated(
        itemBuilder: (context, index) {
          return users[index].uid == registeredUser.uid
              ? Container()
              : InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              title: Text('Chat with ${users[index].username}'),
                              content: Text(
                                  'Are you sure you want start chatting with ${users[index].username}.'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('No')),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pushNamed(context, '/bio',
                                          arguments: users[index].uid);
                                    },
                                    child: Text('View Bio')),
                                TextButton(
                                    onPressed: () async {
                                      await DatabaseService(
                                              uid: registeredUser.uid)
                                          .addChat(receiver: users[index].uid)
                                          .then((value) {
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(new SnackBar(
                                                content: Text(
                                                    '${users[index].username} added to chat list')));
                                      }).catchError((onError) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(new SnackBar(
                                                content:
                                                    Text(onError.toString())));
                                      });
                                    },
                                    child: Text('Yes'))
                              ],
                            ));
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.black,
                      backgroundImage: NetworkImage(users[index].image),
                    ),
                    title: Text(users[index].username),
                    subtitle: Text(users[index].town),
                  ),
                );
        },
        separatorBuilder: (_, __) => Divider(),
        itemCount: users.length);
  }
}
