import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Comments extends StatelessWidget {
  const Comments({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Comments',
          style: GoogleFonts.sourceCodePro(
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: Container(
          color: Colors.blue,
          child: IconButton(
            onPressed: () {},
            icon: Icon(
                Icons.close,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(10),
            elevation: 10,
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                  ),
                  title: Text(
                    'Username',
                    style: GoogleFonts.sourceCodePro(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  subtitle: Text(
                    'Mahlanya',
                    style: GoogleFonts.sourceCodePro(

                    ),
                  ),
                ),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/comment.png'),
                      fit: BoxFit.cover
                    )
                  ),
                  child: Container(
                    height: 200,
                    color: Color.fromRGBO(0, 0, 0, 0.8),
                    child: Center(
                      child: Text(
                        'I am self taught software developer, living in Mbabane, doing freelancing jobs.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.sourceCodePro(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'a day ago - 1 Like',
                        style: GoogleFonts.sourceCodePro(),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
