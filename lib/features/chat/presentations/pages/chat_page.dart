import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/repositories/remote_data_source.dart';
import 'package:flutter_chat_app/features/chat/presentations/widgets/chat_appbar.dart';
import 'package:flutter_chat_app/features/chat/presentations/widgets/chat_messages.dart';
import 'package:flutter_chat_app/features/chat/presentations/widgets/send_message_box.dart';

class ChatRoom extends StatefulWidget {
  final String chatRoomID;

  const ChatRoom({this.chatRoomID});

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  Stream chats;

  @override
  void initState() {
    DatabaseMethods().getChats(widget.chatRoomID).then((val) {
      setState(() {
        chats = val;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatAppBar(context, widget.chatRoomID),
      body: Stack(
        children: [
          ChatMessages(chats: chats,),
          Container(alignment: Alignment.bottomCenter, child: SendMessageBox(chatRoomID: widget.chatRoomID,))
        ],
      ),
    );
  }
}
