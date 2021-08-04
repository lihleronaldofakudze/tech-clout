import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tech_clout/models/registered_user.dart';
import 'package:tech_clout/models/user.dart';
import 'package:tech_clout/services/auth.dart';
import 'package:tech_clout/services/database.dart';
import 'package:tech_clout/widgets/loading.dart';
import 'package:tech_clout/widgets/posts_list.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registeredUser = Provider.of<RegisteredUser>(context);
    return StreamBuilder<User>(
      stream: DatabaseService(uid: registeredUser.uid).user,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          User user = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black),
              title: Text(
                user.username,
                style: GoogleFonts.sourceCodePro(color: Colors.black),
              ),
              actions: [
                user.uid != registeredUser.uid
                    ? IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.save,
                        ),
                      )
                    : Container(),
                user.uid != registeredUser.uid
                    ? IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/edit_profile');
                        },
                        icon: Icon(Icons.edit))
                    : Container(),
                user.uid != registeredUser.uid
                    ? IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(
                                'TechClout',
                                style: GoogleFonts.sourceCodePro(),
                              ),
                              content: Text('Are you sure you want to exit?'),
                              actions: [
                                TextButton(
                                  onPressed: () {},
                                  child: Text('No'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    await AuthService().logOut().then((value) =>
                                        Navigator.pushNamed(context, '/'));
                                  },
                                  child: Text('Yes'),
                                )
                              ],
                            ),
                          );
                        },
                        icon: Icon(Icons.logout))
                    : Container(),
              ],
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
                    registeredUser.email,
                    style: GoogleFonts.sourceCodePro(color: Colors.grey),
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
                  Expanded(child: PostsList()),
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
