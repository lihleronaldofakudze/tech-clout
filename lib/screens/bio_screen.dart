import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tech_clout/models/Clouter.dart';
import 'package:tech_clout/services/database.dart';
import 'package:tech_clout/widgets/loading.dart';
import 'package:tech_clout/widgets/user_posts_list.dart';

class BioScreen extends StatelessWidget {
  const BioScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userId = ModalRoute.of(context).settings.arguments;
    return StreamBuilder<Clouter>(
      stream: DatabaseService(uid: userId).user,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Clouter user = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black),
              title: Text(
                user.username,
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(user.image),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    user.bio,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(child: UserPostsList(userId: userId)),
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
