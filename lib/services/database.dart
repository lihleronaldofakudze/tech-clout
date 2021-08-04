import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tech_clout/models/comment.dart';
import 'package:tech_clout/models/post.dart';
import 'package:tech_clout/models/user.dart';

class DatabaseService {
  final String uid;
  final String postId;
  final CollectionReference postsCollection =
      FirebaseFirestore.instance.collection('posts');
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference commentsCollection =
      FirebaseFirestore.instance.collection('comments');

  DatabaseService({this.uid, this.postId});

  //edit user
  Future editUser(
      String image, String username, String town, String bio) async {
    return usersCollection.doc(uid).set({
      'uid': uid,
      'image': image,
      'username': username,
      'town': town,
      'bio': bio
    });
  }

  //get user
  User _userFromSnapshot(DocumentSnapshot snapshot) {
    return User(
        image: snapshot['image'] ?? '',
        username: snapshot['username'] ?? '',
        town: snapshot['town'] ?? '',
        bio: snapshot['bio'] ?? '');
  }

  //user stream
  Stream<User> get user {
    return usersCollection.doc(uid).snapshots().map(_userFromSnapshot);
  }

  //Users List Snapshot
  List<User> _usersListSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return User(
          uid: doc.get('uid'),
          username: doc.get('username'),
          image: doc.get('image'),
          town: doc.get('town'),
          bio: doc.get('bio'));
    }).toList();
  }

  //Users Stream
  Stream<List<User>> get users {
    return usersCollection.snapshots().map(_usersListSnapshot);
  }

  //Add Post
  Future addPost(String userImage, String username, String town, String message,
      image) async {
    return await postsCollection.add({
      'uid': uid,
      'userImage': userImage,
      'username': username,
      'town': town,
      'image': image,
      'message': message,
      'likes': [],
      'savedBy': [],
      'postedAt': DateTime.now(),
    });
  }

  //Posts Lists Snapshot
  List<Post> _postsListSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Post(
          id: doc.id,
          userImage: doc.get('userImage'),
          username: doc.get('username'),
          town: doc.get('town'),
          image: doc.get('image'),
          message: doc.get('message'),
          likes: doc.get('likes'),
          savedBy: doc.get('savedBy'),
          postedAt: doc.get('postedAt'));
    }).toList();
  }

//Posts List Stream
  Stream<List<Post>> get posts {
    return postsCollection.snapshots().map(_postsListSnapshot);
  }

  //Post Snapshot
  Post _postFromSnapshot(DocumentSnapshot snapshot) {
    return Post(
        uid: snapshot.get('uid'),
        id: snapshot.id,
        userImage: snapshot.get('userImage'),
        username: snapshot.get('username'),
        town: snapshot.get('town'),
        image: snapshot.get('image'),
        message: snapshot.get('message'),
        likes: snapshot.get('likes'),
        savedBy: snapshot.get('savedBy'),
        postedAt: snapshot.get('postedAt'));
  }

  //Post Stream
  Stream<Post> get post {
    return postsCollection.doc(postId).snapshots().map(_postFromSnapshot);
  }

  //Like
  Future like() async {
    return postsCollection.doc(postId).update({
      'likes': FieldValue.arrayUnion([uid]),
    });
  }

  //Unlike
  Future unlike() async {
    return postsCollection.doc(postId).update({
      'likes': FieldValue.arrayRemove([uid]),
    });
  }

  //Save
  Future save() async {
    return postsCollection.doc(postId).update({
      'savedBy': FieldValue.arrayUnion([uid]),
    });
  }

  //Remove
  Future remove() async {
    return postsCollection.doc(postId).update({
      'savedBy': FieldValue.arrayRemove([uid]),
    });
  }

  //Add Comment
  Future addComment(String image, comment, username) async {
    return postsCollection.doc(postId).collection('comments').add({
      'uid': uid,
      'image': image,
      'comment': comment,
      'username': username,
      'commentedAt': DateTime.now()
    });
  }

  //Comment List Snapshot
  List<Comment> _commentsListSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Comment(
          uid: doc.get('uid'),
          username: doc.get('username'),
          image: doc.get('image'),
          comment: doc.get('comment'),
          commentedAt: doc.get('commentedAt'));
    }).toList();
  }

  Stream<List<Comment>> get comments {
    return postsCollection.doc(postId).collection('comments').snapshots().map(_commentsListSnapshot);
  }

}
