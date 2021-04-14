import 'package:flutter/material.dart';
import 'package:flutter_chat_app/features/chat/presentations/pages/chat_page.dart';

class ChatTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;

  ChatTile({this.userName, this.chatRoomId});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Material(
        elevation: 5,
        shadowColor: Colors.black54,
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ChatRoom(chatRoomID: chatRoomId,)),),
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Color.fromARGB(255, 84, 215, 172),
            child: Container(
              child: Center(
                child: Text(userName[0],
                  style: TextStyle(color: Colors.white, fontSize: 25)),
              ),height: 60, width: 60,
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
          title: Text(userName, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500,)),
        ),
      ),
    );
  }
}


