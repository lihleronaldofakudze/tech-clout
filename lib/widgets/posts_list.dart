import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tech_clout/models/Post.dart';
import 'package:tech_clout/models/RegisteredUser.dart';
import 'package:tech_clout/models/Clouter.dart';
import 'package:tech_clout/services/database.dart';

class PostsList extends StatefulWidget {
  const PostsList({Key key}) : super(key: key);

  @override
  _PostsListState createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<List<Post>>(context);
    final registeredUser = Provider.of<RegisteredUser>(context);
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.all(10),
          elevation: 10,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/comments',
                  arguments: posts[index].id);
            },
            child: StreamBuilder<Clouter>(
                stream: DatabaseService(uid: posts[index].uid).user,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Clouter user = snapshot.data;
                    return Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(user.image),
                            backgroundColor: Colors.black,
                          ),
                          title: Text(
                            '${user.username}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            '${DateFormat('yyyy-MM-dd - kk:mm').format(posts[index].postedAt.toDate())}',
                          ),
                          trailing: IconButton(
                            onPressed: () async {
                              if (posts[index]
                                  .savedBy
                                  .contains(registeredUser.uid)) {
                                await DatabaseService(
                                        uid: registeredUser.uid,
                                        postId: posts[index].id)
                                    .remove();
                              } else {
                                await DatabaseService(
                                        uid: registeredUser.uid,
                                        postId: posts[index].id)
                                    .save();
                              }
                            },
                            icon: Icon(
                              posts[index].savedBy.contains(registeredUser.uid)
                                  ? Icons.done
                                  : Icons.archive_outlined,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        Container(
                          height: 300,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(posts[index].image),
                                  fit: BoxFit.cover)),
                        ),
                        Text(
                          '${posts[index].message}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              posts[index].likes.length == 0
                                  ? Text(
                                      'No Likes',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Text(
                                      '${posts[index].likes.length} Likes',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      if (posts[index]
                                          .likes
                                          .contains(registeredUser.uid)) {
                                        await DatabaseService(
                                                uid: registeredUser.uid,
                                                postId: posts[index].id)
                                            .unlike();
                                      } else {
                                        await DatabaseService(
                                                uid: registeredUser.uid,
                                                postId: posts[index].id)
                                            .like();
                                      }
                                    },
                                    icon: posts[index]
                                            .likes
                                            .contains(registeredUser.uid)
                                        ? Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                          )
                                        : Icon(Icons.favorite_outlined),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/comments',
                                          arguments: posts[index].id);
                                    },
                                    icon: Icon(
                                      Icons.message_outlined,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  } else {
                    return Container();
                  }
                }),
          ),
        );
      },
    );
  }
}
