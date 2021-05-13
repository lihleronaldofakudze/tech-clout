import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddPost extends StatelessWidget {
  const AddPost({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'AddPost',
        style: GoogleFonts.sourceCodePro(
            fontSize: 18
        ),
      ),
    );
  }
}
