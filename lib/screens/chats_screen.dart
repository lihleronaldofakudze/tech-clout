import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_clout/models/Chat.dart';
import 'package:tech_clout/models/RegisteredUser.dart';
import 'package:tech_clout/services/database.dart';
import 'package:tech_clout/widgets/chat_list.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registeredUser = Provider.of<RegisteredUser>(context);
    return StreamProvider<List<Chat>>.value(
      value: DatabaseService(uid: registeredUser.uid).chats,
      initialData: [],
      child: ChatList(),
    );
  }
}
