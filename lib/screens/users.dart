import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Users extends StatelessWidget {
  const Users({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Users',
        style: GoogleFonts.sourceCodePro(
          fontSize: 18
        ),
      ),
    );
  }
}
