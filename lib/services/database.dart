import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tech_clout/models/Chat.dart';
import 'package:tech_clout/models/Clouter.dart';
import 'package:tech_clout/models/Comment.dart';
import 'package:tech_clout/models/Message.dart';
import 'package:tech_clout/models/Post.dart';

class DatabaseService {
  final String uid;
  final String postId;
  final String chatId;
  final CollectionReference postsCollection =
      FirebaseFirestore.instance.collection('posts');
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference commentsCollection =
      FirebaseFirestore.instance.collection('comments');
  final CollectionReference chatsCollection =
      FirebaseFirestore.instance.collection('chats');

  DatabaseService({this.uid, this.postId, this.chatId});

  //edit user
  Future editUser(
      {String image,
      String username,
      String town,
      String bio,
      String email}) async {
    return usersCollection.doc(uid).set({
      'uid': uid,
      'image': image,
      'username': username,
      'email': email,
      'town': town,
      'bio': bio
    });
  }

  //get user
  Clouter _userFromSnapshot(DocumentSnapshot snapshot) {
    return Clouter(
        image: snapshot['image'] ?? '',
        username: snapshot['username'] ?? '',
        town: snapshot['town'] ?? '',
        bio: snapshot['bio'] ?? '');
  }

  //user stream
  Stream<Clouter> get user {
    return usersCollection.doc(uid).snapshots().map(_userFromSnapshot);
  }

  //Users List Snapshot
  List<Clouter> _usersListSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Clouter(
          uid: doc.get('uid'),
          username: doc.get('username'),
          image: doc.get('image'),
          town: doc.get('town'),
          bio: doc.get('bio'));
    }).toList();
  }

  //Users Stream
  Stream<List<Clouter>> get users {
    return usersCollection.snapshots().map(_usersListSnapshot);
  }

  //Add Post
  Future addPost(String message, image) async {
    return await postsCollection.add({
      'uid': uid,
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
          uid: doc.get('uid'),
          image: doc.get('image'),
          message: doc.get('message'),
          likes: doc.get('likes'),
          savedBy: doc.get('savedBy'),
          postedAt: doc.get('postedAt'));
    }).toList();
  }

//Posts List Stream
  Stream<List<Post>> get posts {
    return postsCollection
        .orderBy('postedAt', descending: true)
        .snapshots()
        .map(_postsListSnapshot);
  }

  //Post Snapshot
  Post _postFromSnapshot(DocumentSnapshot snapshot) {
    return Post(
        uid: snapshot.get('uid'),
        id: snapshot.id,
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
  Future addComment(comment) async {
    return postsCollection
        .doc(postId)
        .collection('comments')
        .add({'uid': uid, 'comment': comment, 'commentedAt': DateTime.now()});
  }

  //Comment List Snapshot
  List<Comment> _commentsListSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Comment(
          uid: doc.get('uid'),
          comment: doc.get('comment'),
          commentedAt: doc.get('commentedAt'));
    }).toList();
  }

  Stream<List<Comment>> get comments {
    return postsCollection
        .doc(postId)
        .collection('comments')
        .snapshots()
        .map(_commentsListSnapshot);
  }

  //Add Chat
  Future addChat({String receiver}) async {
    DocumentSnapshot documentSnapshotOne =
        await chatsCollection.doc('${uid}_$receiver').get();
    DocumentSnapshot documentSnapshotTwo =
        await chatsCollection.doc('${receiver}_$uid').get();

    if (documentSnapshotOne.exists || documentSnapshotTwo.exists) {
      return null;
    } else {
      return chatsCollection.doc('${uid}_$receiver').set({
        'chatters': [uid, receiver],
        'lastMessage': 'Tech Clouter last said'
      });
    }
  }

  List<Chat> _chatsListSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Chat(
          id: doc.id,
          chatters: doc.get('chatters'),
          lastMessage: doc.get('lastMessage'));
    }).toList();
  }

  Stream<List<Chat>> get chats {
    return chatsCollection
        .where('chatters', arrayContains: uid)
        .snapshots()
        .map(_chatsListSnapshot);
  }

  Future addMessage({message}) {
    return chatsCollection
        .doc(chatId)
        .update({'lastMessage': message}).then((value) {
      chatsCollection
          .doc(chatId)
          .collection('messages')
          .add({'message': message, 'uid': uid, 'createdAt': DateTime.now()});
    });
  }

  List<Message> _messagesListSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Message(
          uid: doc.get('uid'),
          message: doc.get('message'),
          createdAt: doc.get('createdAt'));
    }).toList();
  }

  Stream<List<Message>> get messages {
    return chatsCollection
        .doc(chatId)
        .collection('messages')
        .snapshots()
        .map(_messagesListSnapshot);
  }
}
