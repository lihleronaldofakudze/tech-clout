import 'package:firebase_auth/firebase_auth.dart';
import 'package:tech_clout/models/registered_user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //register user details
  RegisteredUser _userFromFirebase (User user) {
    return user != null ? RegisteredUser(uid: user.uid, email: user.email) : null;
  }

  //user auth change
  Stream<RegisteredUser> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  //register with email and password
  Future register (String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = credential.user;
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return e;
    }
  }

  //login with email and password
  Future login (String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = credential.user;
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return e;
    }
  }

  //log out
  Future logOut () async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return e;
    }
  }
}