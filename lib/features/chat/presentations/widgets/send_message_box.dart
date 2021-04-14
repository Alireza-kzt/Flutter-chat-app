import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/repositories/remote_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SendMessageBox extends StatefulWidget {
  final String chatRoomID;
  const SendMessageBox({this.chatRoomID});

  @override
  _SendMessageBoxState createState() => _SendMessageBoxState();
}

class _SendMessageBoxState extends State<SendMessageBox> {
  TextEditingController messageEditingController = new TextEditingController();
  addMessage() {
    if (messageEditingController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "sendBy": FirebaseAuth.instance.currentUser.displayName,
        "message": messageEditingController.text,
        'time': DateTime.now().millisecondsSinceEpoch,
      };

      DatabaseMethods().addMessage(widget.chatRoomID, chatMessageMap);

      setState(() {
        messageEditingController.text = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.orangeAccent,
                Colors.orange,
                Colors.pinkAccent
              ])),
              child: TextField(
                style: TextStyle(color: Colors.white,),
                controller: messageEditingController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 15, left: 20, bottom: 15, right: 20),
                  border: InputBorder.none,
                  hintText: "Send Message",
                  hintStyle: TextStyle(color: Colors.white, fontSize: 12,),
                  suffixIcon: IconButton(
                      onPressed: addMessage,
                      icon: Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 20,
                      )),
                ),
              )),
        ));
  }
}
