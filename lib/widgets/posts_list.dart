import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_clout/models/post.dart';
import 'package:tech_clout/models/user.dart';

class PostsList extends StatefulWidget {
  const PostsList({Key key}) : super(key: key);

  @override
  _PostsListState createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  final posts = [
    Post(user: User(image: 'assets/images/guy.png', username: 'Username', town: 'Town'), message: 'I am self taught software developer, living in Mbabane, doing freelancing jobs.', likes: 0, comments: 0),
    Post(user: User(image: 'assets/images/guy.png', username: 'Username', town: 'Town'), message: 'I am self taught software developer, living in Mbabane, doing freelancing jobs.', likes: 0, comments: 0),
    Post(user: User(image: 'assets/images/guy.png', username: 'Username', town: 'Town'), message: 'I am self taught software developer, living in Mbabane, doing freelancing jobs.', likes: 0, comments: 0),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.all(10),
          elevation: 10,
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(posts[index].user.image),
                  backgroundColor: Colors.black,
                ),
                title: Text(
                  '${posts[index].user.username}',
                  style: GoogleFonts.sourceCodePro(
                      fontWeight: FontWeight.bold
                  ),
                ),
                subtitle: Text(
                  '${posts[index].user.town}',
                  style: GoogleFonts.sourceCodePro(

                  ),
                ),
                trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.archive_outlined
                  ),
                ),
              ),
              Container(
                height: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/comment.png'),
                        fit: BoxFit.cover
                    )
                ),
                child: Container(
                  height: 200,
                  color: Color.fromRGBO(0, 0, 0, 0.8),
                  child: Center(
                    child: Text(
                      '${posts[index].message}',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.sourceCodePro(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'a day ago - ${posts[index].likes} Like',
                      style: GoogleFonts.sourceCodePro(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
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
          ),
        );
      },
    );
  }
}
