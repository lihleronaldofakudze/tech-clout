import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatelessWidget {
  const Login({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(23),
          child: Column(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/login.png'),
                    fit: BoxFit.cover
                  )
                ),
              ),
              Text(
                'Welcome Back',
                textAlign: TextAlign.center,
                style: GoogleFonts.sourceCodePro(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Login to access your account',
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
                    'Don\'t have an account?',
                    style: TextStyle(
                        fontSize: 18
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Register',
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
