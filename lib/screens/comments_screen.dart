import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tech_clout/models/Comment.dart';
import 'package:tech_clout/models/Post.dart';
import 'package:tech_clout/models/RegisteredUser.dart';
import 'package:tech_clout/services/database.dart';
import 'package:tech_clout/widgets/comments_list.dart';
import 'package:tech_clout/widgets/loading.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({Key key}) : super(key: key);

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final _commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final postId = ModalRoute.of(context).settings.arguments;
    final registeredUser = Provider.of<RegisteredUser>(context);
    return StreamBuilder<Post>(
      stream: DatabaseService(postId: postId).post,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Post post = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.black),
              elevation: 0,
              title: Text(
                'Comments',
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.white,
              actions: [
                TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                                title: Text('Tech Clout'),
                                content: TextField(
                                  controller: _commentController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Enter comment'),
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Cancel')),
                                  TextButton(
                                      onPressed: () async {
                                        if (_commentController
                                            .text.isNotEmpty) {
                                          await DatabaseService(
                                                  postId: post.id,
                                                  uid: registeredUser.uid)
                                              .addComment(
                                                  _commentController.text)
                                              .then((value) {
                                            Navigator.pop(context);
                                            setState(() {
                                              _commentController.clear();
                                            });
                                          }).catchError((onError) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(new SnackBar(
                                                    content: Text(
                                                        onError.toString())));
                                          });
                                        } else {
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(new SnackBar(
                                                  content: Text(
                                                      'Please enter comment first.')));
                                        }
                                      },
                                      child: Text('Comment')),
                                ],
                              ));
                    },
                    child: Text('Comment'))
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    margin: EdgeInsets.all(0),
                    elevation: 0,
                    child: Column(
                      children: [
                        Container(
                          height: 350,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(post.image),
                                  fit: BoxFit.cover)),
                        ),
                        Text(
                          post.message,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.sourceCodePro(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        ListTile(
                          title: post.likes.length == 0
                              ? Text(
                                  'No Likes',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              : Text(
                                  '${post.likes.length} Likes',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                          trailing: IconButton(
                            onPressed: () async {
                              if (post.likes.contains(registeredUser.uid)) {
                                await DatabaseService(
                                        uid: registeredUser.uid,
                                        postId: post.id)
                                    .like();
                              } else {
                                await DatabaseService(
                                        uid: registeredUser.uid,
                                        postId: post.id)
                                    .unlike();
                              }
                            },
                            icon: post.likes.contains(registeredUser.uid)
                                ? Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )
                                : Icon(Icons.favorite_outlined),
                          ),
                        )
                      ],
                    ),
                  ),
                  StreamProvider<List<Comment>>.value(
                    value: DatabaseService(postId: post.id).comments,
                    initialData: [],
                    child: CommentsList(),
                  ),
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
