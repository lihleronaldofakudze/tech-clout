import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_clout/models/registered_user.dart';
import 'package:tech_clout/models/user.dart';
import 'package:tech_clout/services/database.dart';
import 'package:tech_clout/widgets/loading.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    final registerUser = Provider.of<RegisteredUser>(context);
    return StreamBuilder<User>(
      stream: DatabaseService(uid: registerUser.uid).user,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          User user = snapshot.data;
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
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(user.image),
                      backgroundColor: Colors.white,
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
                            initialValue: user.username,
                            decoration: InputDecoration(
                                hintText: 'Username',
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
                            initialValue: user.town,
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
                        TextFormField(
                          initialValue: user.bio,
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          decoration: InputDecoration(labelText: 'Bio'),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(onPressed: () {}, child: Text('Save'))
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
