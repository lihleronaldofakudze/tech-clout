import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_clout/models/Clouter.dart';
import 'package:tech_clout/models/Comment.dart';
import 'package:tech_clout/services/database.dart';

class CommentsList extends StatelessWidget {
  const CommentsList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final comments = Provider.of<List<Comment>>(context);

    return ListView.builder(
        itemCount: comments.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return StreamBuilder<Clouter>(
              stream: DatabaseService(uid: comments[index].uid).user,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Clouter user = snapshot.data;
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(user.image),
                    ),
                    title: Text(
                      comments[index].comment,
                      style: TextStyle(fontSize: 18),
                    ),
                    subtitle: Text(user.username),
                  );
                } else {
                  return Container();
                }
              });
        });
  }
}
