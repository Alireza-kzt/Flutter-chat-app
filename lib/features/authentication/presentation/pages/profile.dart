import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/repositories/remote_data_source.dart';
import 'package:flutter_chat_app/features/authentication/presentation/widget/submit_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List profiles = [
    AssetImage("assets/images/1.png"),
    AssetImage("assets/images/2.png"),
    AssetImage("assets/images/3.png"),
    AssetImage("assets/images/4.png"),
    AssetImage("assets/images/5.png"),
  ];
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.lightBlueAccent,
              child: Image(image: profiles[0]),
              radius: 50,
            ),
            SizedBox(height: 5),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 100),
              child: TextField(
                controller: nameController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: FirebaseAuth.instance.currentUser.displayName,
                  hintStyle: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w300),
                ),
              ),
            ),
            SizedBox(height: 23),
            Container(
              height: 100,
              color: Colors.black12,
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      child: Image(image: profiles[1]),
                      radius: 32,
                    ),
                    SizedBox(width: 12),
                    CircleAvatar(
                      backgroundColor: Colors.lime,
                      child: Image(image: profiles[2]),
                      radius: 32,
                    ),
                    SizedBox(width: 12),
                    CircleAvatar(
                      backgroundColor: Colors.amber,
                      child: Image(image: profiles[3]),
                      radius: 32,
                    ),
                    SizedBox(width: 12),
                    CircleAvatar(
                      backgroundColor: Colors.teal,
                      child: Image(image: profiles[4]),
                      radius: 32,
                    ),
                  ]),
            ),
            SizedBox(height: 70),
            SubmitButton(
              onPressed: () {
                nameController.text != null ?? DatabaseMethods().updateName(nameController.text);
              },
              text: "Save Profile",
            )
          ],
        ),
      ),
    );
  }
}
