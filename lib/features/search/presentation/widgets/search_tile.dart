import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/repositories/remote_data_source.dart';
import 'package:flutter_chat_app/features/chat/presentations/pages/chat_page.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SearchTile extends StatelessWidget {
  final String username, email;
  DatabaseMethods databaseMethod = DatabaseMethods();

  SearchTile({this.username, this.email});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        String myName = FirebaseAuth.instance.currentUser.displayName;
        String chatRoomId = getChatRoomId(myName, username);
        Map<String, dynamic> chatRoom = {
          "users": [myName, username],
          "chatRoomId": chatRoomId
        };
        databaseMethod.addChatRoom(chatRoom, chatRoomId);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChatRoom(
                    chatRoomID: chatRoomId,
                  )),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Material(
          elevation: 5,
          shadowColor: Colors.black54,
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              radius: 25.0,
              child: Container(child: Icon(LineAwesomeIcons.user, color: Colors.white,),height: 60, width: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 84, 215, 172),
                      Colors.teal[300],
                      Colors.teal[400]
                    ],
                  ),
                ),),
            ),
            title: Text(username),
            subtitle: Text(email),
          ),
        ),
      ),
    );
  }
}

getChatRoomId(String a, String b) {
  if (a[0].codeUnitAt(0) > b[0].codeUnitAt(0))
    return "$b\_$a";
  else
    return "$a\_$b";
}
