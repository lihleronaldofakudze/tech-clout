import 'package:flutter/material.dart';
import 'package:tech_clout/models/comment.dart';

class CommentsList extends StatelessWidget {
  const CommentsList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final comments = [
      Comment(
          uid: '1',
          comment: 'Jah neh i need data fast',
          username: 'Username',
          image: 'assets/images/guy.png'),
    ];

    return ListView.builder(
      itemCount: comments.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: AssetImage(comments[index].image),
          ),
          title: Text(comments[index].comment),
          subtitle: Text(comments[index].username),
        );
      },
    );
  }
}
