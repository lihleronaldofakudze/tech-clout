import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String uid;
  final String comment;
  final String username;
  final String image;
  final Timestamp commentedAt;

  Comment(
      {this.uid, this.comment, this.username, this.image, this.commentedAt});
}
