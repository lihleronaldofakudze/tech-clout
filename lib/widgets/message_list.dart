import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_clout/models/Clouter.dart';
import 'package:tech_clout/models/Message.dart';
import 'package:tech_clout/models/RegisteredUser.dart';
import 'package:tech_clout/services/database.dart';

class MessageList extends StatelessWidget {
  const MessageList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final messages = Provider.of<List<Message>>(context);
    final registeredUser = Provider.of<RegisteredUser>(context);
    return ListView.builder(
      itemCount: messages.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return StreamBuilder<Clouter>(
          stream: DatabaseService(uid: messages[index].uid).user,
          builder: (context, snapshot) {
            Clouter clouter = snapshot.data;

            if (messages[index].uid != registeredUser.uid) {
              return Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(clouter.image),
                    backgroundColor: Colors.black,
                  ),
                  PhysicalModel(
                    color: Colors.white,
                    elevation: .8,
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Text(
                        messages[index].message,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Container(
                margin: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    PhysicalModel(
                      color: Colors.white,
                      elevation: .8,
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(color: Colors.white),
                        child: Column(
                          children: [
                            Text(
                              messages[index].message,
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        );
      },
    );
  }
}
