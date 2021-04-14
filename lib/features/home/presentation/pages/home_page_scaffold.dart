import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/repositories/remote_data_source.dart';
import 'package:flutter_chat_app/features/home/presentation/widgets/chat_title.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePageScaffold extends StatefulWidget {
  @override
  _HomePageScaffoldState createState() => _HomePageScaffoldState();
}

class _HomePageScaffoldState extends State<HomePageScaffold> {
  Stream chatRooms;

@override
  void initState() {
  DatabaseMethods().getUserChats().then((snapshots) {
    setState(() {
      chatRooms = snapshots;
    });
  });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Container(child: Icon(LineAwesomeIcons.user, color: Colors.white,),height: 60, width: 60,
          decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              Colors.orangeAccent,
              Colors.orange,
              Colors.deepOrange
            ],
          ),
        ),),
        onPressed: () => Navigator.pushNamed(context, '/search'),
      ),
      appBar: AppBar(

        automaticallyImplyLeading: false,
        title: Text(
          "Message",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 3,
        shadowColor: Colors.black54,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.black54,
          ),
        ),
      ),
      body: Container(
        child: StreamBuilder(
          stream: chatRooms,
          builder: (context, snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ChatTile(
                    userName: snapshot.data.documents[index].data()['chatRoomId'].toString().replaceAll("_", "").replaceAll(FirebaseAuth.instance.currentUser.displayName, ""),
                    chatRoomId: snapshot.data.documents[index].data()["chatRoomId"],
                  );
                })
                : Container();
          },
        ),
      ),
    );
  }
}

