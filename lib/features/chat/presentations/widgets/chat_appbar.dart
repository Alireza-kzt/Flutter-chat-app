import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

Widget ChatAppBar(BuildContext context, String chatID){
  return AppBar(
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: Colors.black54,
      ),
      onPressed: () => Navigator.pop(context),
    ),
    title: Text(
      chatID
          .replaceAll("_", "")
          .replaceAll(FirebaseAuth.instance.currentUser.displayName, ""),
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
    ),
    centerTitle: true,
    backgroundColor: Colors.white,
    elevation: 2,
    actions: [
      Container(
        child: CircleAvatar(
          backgroundColor: Colors.orange,
          child: Text(
            chatID.replaceAll("_", "").replaceAll(
                FirebaseAuth.instance.currentUser.displayName, "")[0],
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 13),
      )
    ],
  );
}
