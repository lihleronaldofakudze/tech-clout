import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Search extends StatelessWidget {
  const Search({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Search',
        style: GoogleFonts.sourceCodePro(
            fontSize: 18
        ),
      ),
    );
  }
}
