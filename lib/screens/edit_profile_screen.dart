import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:tech_clout/models/Clouter.dart';
import 'package:tech_clout/models/RegisteredUser.dart';
import 'package:tech_clout/services/database.dart';
import 'package:tech_clout/widgets/loading.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  PickedFile _image = PickedFile('');
  final _picker = ImagePicker();
  final _usernameController = TextEditingController();
  final _townController = TextEditingController();
  final _bioController = TextEditingController();
  ProgressDialog _progressDialog;
  String _url = "";

  Future getImage({email, username, image, town, bio, uid}) async {
    await _progressDialog.show();
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        setState(() {
          _image = pickedFile;
        });
      } else {
        print('No image selected');
      }
    });
    Reference reference =
        FirebaseStorage.instance.ref().child("profile").child('$uid.png');
    UploadTask uploadTask = reference.putFile(File(_image.path));
    uploadTask.whenComplete(() {
      reference.getDownloadURL().then((url) async {
        await DatabaseService(uid: uid)
            .editUser(
                image: url,
                username: username,
                email: email,
                town: town,
                bio: bio)
            .then((value) async {
          await _progressDialog.hide();
        });
      }).catchError((onError) async {
        await _progressDialog.hide();
        ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
          content: Text(onError.toString()),
        ));
      });
    }).catchError((onError) async {
      await _progressDialog.hide();
      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
        content: Text(onError.toString()),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    final registeredUser = Provider.of<RegisteredUser>(context);
    _progressDialog = ProgressDialog(context,
        type: ProgressDialogType.Normal,
        textDirection: TextDirection.ltr,
        isDismissible: false);
    _progressDialog.style(message: 'Please wait');
    return StreamBuilder<Clouter>(
      stream: DatabaseService(uid: registeredUser.uid).user,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Clouter user = snapshot.data;
          _usernameController.text = user.username;
          _townController.text = user.town;
          _bioController.text = user.bio;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.black),
              title: Text(
                'TechClout',
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(23),
              child: Column(
                children: [
                  PhysicalModel(
                    color: Colors.white,
                    elevation: 10,
                    borderRadius: BorderRadius.circular(60),
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(user.image),
                          backgroundColor: Colors.white,
                        ),
                        Positioned(
                          top: 80,
                          left: 80,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(50)),
                            child: IconButton(
                                onPressed: () => getImage(
                                    email: registeredUser.email,
                                    username: user.username,
                                    image: user.image,
                                    town: user.town,
                                    bio: user.bio,
                                    uid: registeredUser.uid),
                                icon: Icon(
                                  Icons.add_a_photo_outlined,
                                  color: Colors.white,
                                )),
                          ),
                        )
                      ],
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
                            // initialValue: user.username,
                            decoration: InputDecoration(
                              hintText: 'Username',
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 18),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 15),
                              prefixIcon: Icon(Icons.location_on_outlined),
                            ),
                            controller: _usernameController,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        PhysicalModel(
                          color: Colors.white,
                          elevation: 8,
                          child: TextFormField(
                            // initialValue: user.town,
                            decoration: InputDecoration(
                                hintText: 'Town',
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 15),
                                prefixIcon: Icon(Icons.location_on_outlined)),
                            controller: _townController,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          // initialValue: user.bio,
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          decoration: InputDecoration(labelText: 'Bio'),
                          controller: _bioController,
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
                        await DatabaseService(uid: registeredUser.uid)
                            .editUser(
                                image: user.image,
                                username: _usernameController.text,
                                email: registeredUser.email,
                                town: _townController.text,
                                bio: _bioController.text)
                            .then((value) async {
                          await _progressDialog.hide();
                          Navigator.pushNamed(context, '/user_profile');
                        }).catchError((onError) async {
                          await _progressDialog.hide();
                          ScaffoldMessenger.of(context)
                              .showSnackBar(new SnackBar(
                            content: Text(onError.toString()),
                          ));
                        });
                      },
                      child: Text('Save'))
                ],
              ),
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
