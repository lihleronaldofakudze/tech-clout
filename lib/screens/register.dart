import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:tech_clout/constants.dart';
import 'package:tech_clout/services/auth.dart';
import 'package:tech_clout/services/database.dart';

class Register extends StatefulWidget {
  const Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _usernameController;
  TextEditingController _passwordController;
  TextEditingController _emailController;
  TextEditingController _townController;
  TextEditingController _confirmPasswordController;
  ProgressDialog _progressDialog;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _emailController = TextEditingController();
    _townController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    _progressDialog = ProgressDialog(context,
        type: ProgressDialogType.Normal,
        textDirection: TextDirection.ltr,
        isDismissible: false);
    _progressDialog.style(message: 'Please wait');
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(23),
          child: Column(
            children: [
              Text(
                'Welcome to Eswatini Tech Center...',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Please enter all details.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(
                height: 10,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    PhysicalModel(
                      color: Colors.white,
                      elevation: 8,
                      child: TextFormField(
                        controller: _usernameController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter username';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: 'Username',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 18),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(top: 16),
                            prefixIcon: Icon(Icons.person_outline)),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    PhysicalModel(
                      color: Colors.white,
                      elevation: 8,
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter email address';
                          } else if (!EmailValidator.validate(value)) {
                            return 'Invalid Email Address';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: 'Email Address',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 18),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(top: 15),
                            prefixIcon: Icon(Icons.email_outlined)),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    PhysicalModel(
                      color: Colors.white,
                      elevation: 8,
                      child: TextFormField(
                        controller: _townController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter town';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: 'Town',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 18),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(top: 15),
                            prefixIcon: Icon(Icons.location_on_outlined)),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    PhysicalModel(
                      color: Colors.white,
                      elevation: 8,
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 18),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(top: 15),
                            prefixIcon: Icon(Icons.lock_outline),
                            suffixIcon: Icon(Icons.remove_red_eye_outlined)),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    PhysicalModel(
                      color: Colors.white,
                      elevation: 8,
                      child: TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please re-enter password';
                          } else if (value != _passwordController.text) {
                            return 'Password do not match.';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: 'Confirm Password',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 18),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(top: 15),
                            prefixIcon: Icon(Icons.lock_outline),
                            suffixIcon: Icon(Icons.remove_red_eye_outlined)),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  await _progressDialog.show();
                  if (_formKey.currentState.validate()) {
                    dynamic result = await AuthService().register(
                        _emailController.text, _passwordController.text);

                    if (result == null) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          'Please check your credentials.',
                        ),
                      ));
                    } else {
                      await DatabaseService(uid: result.uid)
                          .editUser(
                              Constants().guy,
                              _usernameController.text,
                              _townController.text,
                              'Hey, I\'m a proud member of Eswatini Tech Society.')
                          .then((value) => Navigator.pushNamed(context, '/'));
                    }
                  } else {
                    await _progressDialog.hide();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        'Form is not valid.',
                      ),
                    ));
                  }
                },
                child: Text(
                  'Create an account',
                  style: TextStyle(fontSize: 18),
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
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
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
