import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_app/features/chat/presentations/widgets/message_tile.dart';

class ChatMessages extends StatefulWidget {
  final Stream chats;

  const ChatMessages({this.chats});

  @override
  _ChatMessagesState createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.chats,
      builder: (context, snapshot){
        return snapshot.hasData ?  ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index){
              return MessageTile(
                message: snapshot.data.documents[index].data()["message"],
                sendByMe: FirebaseAuth.instance.currentUser.displayName == snapshot.data.documents[index].data()["sendBy"],
              );
            }) : Container();
      },
    );
  }
}
