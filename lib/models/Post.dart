import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String uid;
  final String image;
  final String message;
  final likes;
  final savedBy;
  final Timestamp postedAt;

  Post(
      {this.id,
      this.uid,
      this.image,
      this.message,
      this.likes,
      this.savedBy,
      this.postedAt});
}
