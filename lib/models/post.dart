import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String uid;
  final String userImage;
  final String username;
  final String town;
  final String image;
  final String message;
  final likes;
  final savedBy;
  final Timestamp postedAt;

  Post(
      {this.id,
      this.uid,
      this.userImage,
      this.username,
      this.town,
      this.image,
      this.message,
      this.likes,
      this.savedBy,
      this.postedAt});
}
