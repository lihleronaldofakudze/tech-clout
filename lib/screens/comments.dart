import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tech_clout/models/post.dart';
import 'package:tech_clout/models/registered_user.dart';
import 'package:tech_clout/services/database.dart';
import 'package:tech_clout/widgets/comments_list.dart';
import 'package:tech_clout/widgets/loading.dart';

class Comments extends StatelessWidget {
  const Comments({Key key}) : super(key: key);

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
              centerTitle: true,
              backgroundColor: Colors.white,
            ),
            body: Column(
              children: [
                Card(
                  margin: EdgeInsets.all(0),
                  elevation: 0,
                  child: Column(
                    children: [
                      Container(
                        height: 250,
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
                                      uid: registeredUser.uid, postId: post.id)
                                  .like();
                            } else {
                              await DatabaseService(
                                      uid: registeredUser.uid, postId: post.id)
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
                Expanded(
                  child: CommentsList(),
                ),
                PhysicalModel(
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(),
                      ),
                      IconButton(onPressed: () {}, icon: Icon(Icons.send))
                    ],
                  ),
                )
              ],
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
