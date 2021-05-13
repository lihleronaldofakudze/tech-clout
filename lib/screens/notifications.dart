import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Notifications',
        style: GoogleFonts.sourceCodePro(
            fontSize: 18
        ),
      ),
    );
  }
}
