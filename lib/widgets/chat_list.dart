import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_clout/models/Chat.dart';
import 'package:tech_clout/models/Clouter.dart';
import 'package:tech_clout/models/RegisteredUser.dart';
import 'package:tech_clout/services/database.dart';
import 'package:tech_clout/widgets/loading.dart';

class ChatList extends StatelessWidget {
  const ChatList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registeredUser = Provider.of<RegisteredUser>(context);
    final chats = Provider.of<List<Chat>>(context);
    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        return StreamBuilder<Clouter>(
          stream: DatabaseService(
                  uid: registeredUser.uid == chats[index].chatters[0]
                      ? chats[index].chatters[1]
                      : chats[index].chatters[0])
              .user,
          builder: (context, snapshot) {
            Clouter clouter = snapshot.data;
            if (snapshot.hasData) {
              return ListTile(
                onTap: () {
                  Navigator.pushNamed(context, '/chat', arguments: {
                    'userId': registeredUser.uid == chats[index].chatters[0]
                        ? chats[index].chatters[1]
                        : chats[index].chatters[0],
                    'chatId': chats[index].id
                  });
                },
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(clouter.image),
                  backgroundColor: Colors.black,
                ),
                title: Text(clouter.username),
                subtitle: Text(
                  chats[index].lastMessage,
                  style: TextStyle(
                      fontStyle: FontStyle.italic, color: Colors.blue),
                ),
              );
            } else {
              return Loading();
            }
          },
        );
      },
    );
  }
}
