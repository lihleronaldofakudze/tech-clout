import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String message;
  final String uid;
  final Timestamp createdAt;

  Message({this.message, this.uid, this.createdAt});
}
