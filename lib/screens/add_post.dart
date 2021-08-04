import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:tech_clout/models/registered_user.dart';
import 'package:tech_clout/models/user.dart';
import 'package:tech_clout/services/database.dart';
import 'package:tech_clout/widgets/loading.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key key}) : super(key: key);

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  PickedFile _image = PickedFile('');
  final _picker = ImagePicker();
  final _messageController = TextEditingController();
  ProgressDialog _progressDialog;

  Future getImage() async {
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
  }

  @override
  Widget build(BuildContext context) {
    final registeredUser = Provider.of<RegisteredUser>(context);
    _progressDialog = ProgressDialog(context,
        type: ProgressDialogType.Normal,
        textDirection: TextDirection.ltr,
        isDismissible: false);
    _progressDialog.style(message: 'Please wait');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Share post',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: StreamBuilder<User>(
        stream: DatabaseService(uid: registeredUser.uid).user,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User user = snapshot.data;

            return SingleChildScrollView(
              padding: EdgeInsets.all(23),
              child: Column(
                children: [
                  Text(
                    'Please enter all details',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Choose Image',
                        style: TextStyle(fontSize: 18),
                      ),
                      IconButton(
                          onPressed: () => getImage(), icon: Icon(Icons.edit))
                    ],
                  ),
                  _image.path == ''
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.grey)),
                          child: Center(
                            child: PhysicalModel(
                              color: Colors.white,
                              elevation: 10,
                              borderRadius: BorderRadius.circular(60),
                              child: IconButton(
                                onPressed: () => getImage(),
                                icon: Icon(Icons.camera_alt_outlined),
                              ),
                            ),
                          ),
                        )
                      : Container(
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: FileImage(File(_image.path)),
                                  fit: BoxFit.cover),
                              border: Border.all(color: Colors.grey)),
                        ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _messageController,
                    decoration: InputDecoration(
                        hintText: 'Enter post details...',
                        hintStyle: TextStyle(color: Colors.grey)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        await _progressDialog.show();
                        if (_messageController.text == '' &&
                            _image.path == '') {
                          await _progressDialog.hide();
                          ScaffoldMessenger.of(context).showSnackBar(
                              new SnackBar(
                                  content: Text(
                                      'Please add image and message first')));
                        } else {
                          Reference reference = FirebaseStorage.instance
                              .ref()
                              .child("posts")
                              .child(basename(_image.path));
                          UploadTask uploadTask =
                              reference.putFile(File(_image.path));
                          uploadTask.whenComplete(() {
                            reference.getDownloadURL().then((url) async {
                              await DatabaseService(uid: registeredUser.uid)
                                  .addPost(user.image, user.username, user.town,
                                      _messageController.text, url)
                                  .then((value) async {
                                await _progressDialog.hide();
                                Navigator.pushNamed(context, '/');
                              }).catchError((onError) async {
                                await _progressDialog.hide();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(new SnackBar(
                                  content: Text(onError.toString()),
                                ));
                              });
                            }).catchError((onError) async {
                              await _progressDialog.hide();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(new SnackBar(
                                content: Text(onError.toString()),
                              ));
                            });
                          }).catchError((onError) async {
                            await _progressDialog.hide();
                            ScaffoldMessenger.of(context)
                                .showSnackBar(new SnackBar(
                              content: Text(onError.toString()),
                            ));
                          });
                        }
                      },
                      child: Text(
                        'Post',
                        style: GoogleFonts.sourceCodePro(
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            return Loading();
          }
        },
      ),
    );
  }
}
