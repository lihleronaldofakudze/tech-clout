import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        centerTitle: true,
        title: Text(
          'TechClout',
          style: GoogleFonts.sourceCodePro(
            color: Colors.black
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                ),
                SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text(
                    'Lihle Fakudze',
                    style: GoogleFonts.sourceCodePro(
                        color: Colors.black,
                        fontSize: 18
                    ),
                  ),
                    Text(
                        'lihleronaldofakudze@gmail.com',
                        style: GoogleFonts.sourceCodePro(
                          color: Colors.grey
                        ),
                    ),
                  ]
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Text(
                        '0',
                        style: GoogleFonts.sourceCodePro(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                          'Posts',
                        style: GoogleFonts.sourceCodePro(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Text(
                          '0',
                        style: GoogleFonts.sourceCodePro(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                          'Followers',
                        style: GoogleFonts.sourceCodePro(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Text(
                          '0',
                        style: GoogleFonts.sourceCodePro(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                          'Following',
                        style: GoogleFonts.sourceCodePro(
                            fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                'Edit Profile',
                style: GoogleFonts.sourceCodePro(
                  fontSize: 18
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'All Posts',
                  style: GoogleFonts.sourceCodePro(),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.list_outlined
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'No Posts',
              style: GoogleFonts.sourceCodePro(
                fontSize: 18,
                color: Colors.grey
              ),
            ),
            Spacer(),
            PhysicalModel(
              color: Colors.white,
              elevation: 10,
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(15),
                width: double.infinity,
                child: Center(
                  child: Text(
                    'Log Out',
                    style: GoogleFonts.sourceCodePro(
                      fontSize: 18
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
