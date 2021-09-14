import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_clout/models/Clouter.dart';
import 'package:tech_clout/models/Message.dart';
import 'package:tech_clout/models/RegisteredUser.dart';
import 'package:tech_clout/services/database.dart';
import 'package:tech_clout/widgets/loading.dart';
import 'package:tech_clout/widgets/message_list.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key key}) : super(key: key);

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final _messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as Map;
    final registeredUser = Provider.of<RegisteredUser>(context);
    return StreamBuilder(
      stream: DatabaseService(uid: args['userId']).user,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Clouter user = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.black),
              backgroundColor: Colors.white,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(user.image),
                    backgroundColor: Colors.black,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    user.username,
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/background.jpg'),
                      fit: BoxFit.cover)),
              child: Column(
                children: [
                  Expanded(
                      child: StreamProvider<List<Message>>.value(
                    value: DatabaseService(chatId: args['chatId']).messages,
                    initialData: [],
                    child: MessageList(),
                  )),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Expanded(
                          child: PhysicalModel(
                            color: Colors.white,
                            child: TextField(
                              controller: _messageController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Enter message'),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50)),
                          child: IconButton(
                              onPressed: () async {
                                if (_messageController.text.isNotEmpty) {
                                  await DatabaseService(
                                          uid: registeredUser.uid,
                                          chatId: args['chatId'])
                                      .addMessage(
                                          message: _messageController.text)
                                      .then((value) {
                                    setState(() {
                                      _messageController.clear();
                                    });
                                  }).catchError((onError) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        new SnackBar(
                                            content: Text(onError.toString())));
                                  });
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      new SnackBar(
                                          content: Text(
                                              'Please enter comment first.')));
                                }
                              },
                              icon: Icon(
                                Icons.send,
                                color: Colors.blue,
                                size: 34,
                              )),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
