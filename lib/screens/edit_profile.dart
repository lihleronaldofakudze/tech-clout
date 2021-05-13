import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back_ios_rounded
          ),
        ),
        title: Text(
          'TechClout',
          style: GoogleFonts.sourceCodePro(
            color: Colors.black
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.save,
              color: Colors.blue,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(23),
        child: Column(
          children: [
            PhysicalModel(
              color: Colors.white,
              elevation: 10,
              borderRadius: BorderRadius.circular(60),
              child: CircleAvatar(
                radius: 60,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Form(
              child: Column(
                children: [
                  PhysicalModel(
                    color: Colors.white,
                    elevation: 8,
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 18
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 15),
                          prefixIcon: Icon(
                              Icons.person_outline
                          )
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  PhysicalModel(
                    color: Colors.white,
                    elevation: 8,
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Town',
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 18
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 15),
                          prefixIcon: Icon(
                              Icons.location_on_outlined
                          )
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Bio'
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
