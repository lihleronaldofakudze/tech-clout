import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tech_clout/models/Clouter.dart';
import 'package:tech_clout/models/Post.dart';
import 'package:tech_clout/models/RegisteredUser.dart';
import 'package:tech_clout/screens/add_post_screen.dart';
import 'package:tech_clout/screens/bio_screen.dart';
import 'package:tech_clout/screens/comments_screen.dart';
import 'package:tech_clout/screens/edit_profile_screen.dart';
import 'package:tech_clout/screens/forgot_password_screen.dart';
import 'package:tech_clout/screens/home_screen.dart';
import 'package:tech_clout/screens/login_screen.dart';
import 'package:tech_clout/screens/messages_screen.dart';
import 'package:tech_clout/screens/register_screen.dart';
import 'package:tech_clout/screens/saved_screen.dart';
import 'package:tech_clout/screens/user_profile_screen.dart';
import 'package:tech_clout/screens/welcome_screen.dart';
import 'package:tech_clout/services/auth.dart';
import 'package:tech_clout/services/database.dart';

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
        StreamProvider<List<Clouter>>.value(
            value: DatabaseService().users, initialData: []),
      ],
      child: MaterialApp(
        routes: {
          '/': (context) => AuthChange(),
          '/welcome': (context) => WelcomeScreen(),
          '/login': (context) => LoginScreen(),
          '/forgot_password': (context) => ForgotPasswordScreen(),
          '/register': (context) => RegisterScreen(),
          '/home': (context) => HomeScreen(),
          '/edit_profile': (context) => EditProfileScreen(),
          '/user_profile': (context) => UserProfileScreen(),
          '/add_post': (context) => AddPostScreen(),
          '/comments': (context) => CommentsScreen(),
          '/saved': (context) => SavedScreen(),
          '/bio': (context) => BioScreen(),
          '/chat': (context) => MessagesScreen(),
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
