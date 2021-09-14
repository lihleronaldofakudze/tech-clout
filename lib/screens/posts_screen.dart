import 'package:flutter/material.dart';
import 'package:tech_clout/widgets/posts_list.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PostsList();
  }
}
