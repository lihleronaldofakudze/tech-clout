import 'package:tech_clout/models/user.dart';

class Post {
  final User user;
  final String message;
  int likes;
  int comments;

  Post({this.user, this.message, this.likes, this.comments});
}