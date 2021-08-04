import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tech_clout/models/post.dart';
import 'package:tech_clout/models/registered_user.dart';
import 'package:tech_clout/models/user.dart';
import 'package:tech_clout/screens/add_post.dart';
import 'package:tech_clout/screens/comments.dart';
import 'package:tech_clout/screens/edit_profile.dart';
import 'package:tech_clout/screens/forgot_password.dart';
import 'package:tech_clout/screens/home.dart';
import 'package:tech_clout/screens/login.dart';
import 'package:tech_clout/screens/register.dart';
import 'package:tech_clout/screens/user_profile.dart';
import 'package:tech_clout/screens/welcome.dart';
import 'package:tech_clout/services/auth.dart';
import 'package:tech_clout/services/database.dart';
import 'package:tech_clout/models/comment.dart';

import 'auth_change.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<RegisteredUser>.value(
            value: AuthService().user, initialData: RegisteredUser()),
        StreamProvider<List<Post>>.value(
            value: DatabaseService().posts, initialData: []),
        StreamProvider<List<User>>.value(
            value: DatabaseService().users, initialData: []),
        StreamProvider<List<Comment>>.value(
          value: DatabaseService().comments, initialData: []
        )
      ],
      child: MaterialApp(
        routes: {
          '/': (context) => AuthChange(),
          '/welcome': (context) => Welcome(),
          '/login': (context) => Login(),
          '/forgot_password': (context) => ForgotPassword(),
          '/register': (context) => Register(),
          '/home': (context) => Home(),
          '/edit_profile': (context) => EditProfile(),
          '/user_profile': (context) => UserProfile(),
          '/add_post': (context) => AddPost(),
          '/comments': (context) => Comments()
        },
        title: 'Tech Clout',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            primarySwatch: Colors.blue,
            textTheme: GoogleFonts.sourceCodeProTextTheme(
                Theme.of(context).textTheme)),
      ),
    );
  }
}
