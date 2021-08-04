import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Chats extends StatelessWidget {
  const Chats({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Chats',
        style: GoogleFonts.sourceCodePro(fontSize: 18),
      ),
    );
  }
}
