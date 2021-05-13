import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Register extends StatelessWidget {
  const Register({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(23),
          child: Column(
            children: [
              Text(
                'Welcome to Eswatini Tech Center...',
                style: GoogleFonts.sourceCodePro(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Create an account',
                textAlign: TextAlign.center,
                style: GoogleFonts.sourceCodePro(
                  fontSize: 18,
                  color: Colors.grey
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Form(
                child: Column(
                  children: [
                    PhysicalModel(
                      color: Colors.white,
                      elevation: 8,
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Username',
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 18
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(top: 16),
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
                            hintText: 'Email',
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 18
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(top: 15),
                            prefixIcon: Icon(
                              Icons.email_outlined
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
                    PhysicalModel(
                      color: Colors.white,
                      elevation: 8,
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 18
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(top: 15),
                            prefixIcon: Icon(
                                Icons.lock_outline
                            ),
                            suffixIcon: Icon(
                                Icons.remove_red_eye_outlined
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
                            hintText: 'Confirm Password',
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 18
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(top: 15),
                            prefixIcon: Icon(
                                Icons.lock_outline
                            ),
                            suffixIcon: Icon(
                              Icons.remove_red_eye_outlined
                            )
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 18
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(
                      fontSize: 18
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
