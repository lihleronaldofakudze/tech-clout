import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Clout Developers',
              style: TextStyle(
                color: Colors.grey
              ),
            ),
            Container(
              child: Column(
                children: [
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/logo.png')
                        )
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Tech Clout',
                    style: GoogleFonts.roboto(
                        fontSize: 23
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Login'
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                      'Register'
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
