import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class ScaffoldDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.orange.shade700,
              Colors.orangeAccent,
            ])),
        child: Center(
          child: Column(
            children: <Widget>[UserInfo(), DrawerList(context)],
          ),
        ),
      ),
    );
  }

  Widget UserInfo() {
    String displayName = FirebaseAuth.instance.currentUser.displayName;
    String displayEmail = FirebaseAuth.instance.currentUser.email;
    return Expanded(
      flex: 1,
      child: Container(
        alignment: Alignment.bottomCenter,
        child: ListTile(
          leading: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.indigoAccent,
              child: displayName != null
                  ? Text(displayName[0], style: TextStyle(color: Colors.white, fontSize: 25))
                  : Icon(Icons.account_circle_outlined, color: Colors.white,
              )),
          title: Text(displayName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              )),
          subtitle: Text(displayEmail,
              style: TextStyle(color: Colors.white70, fontSize: 11)),
        ),
      ),
    );
  }

  Widget DrawerList(context) {
    return Expanded(
        flex: 2,
        child: ListView(
          children: [
            ListTile(
              leading: Icon(LineAwesomeIcons.user, color: Colors.white,),
              title: Text("Profile", style: TextStyle(color: Colors.white),),
              onTap: () => Navigator.pushNamed(context, '/profile'),
            ),
            ListTile(
              leading: Icon(LineAwesomeIcons.user_plus, color: Colors.white,),
              title: Text("Add Friend",style: TextStyle(color: Colors.white)),
              onTap: () => Navigator.pushNamed(context, '/search'),
            ),
            ListTile(
              leading: Icon(LineAwesomeIcons.wrench, color: Colors.white,),
              title: Text("Settings", style: TextStyle(color: Colors.white)),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(LineAwesomeIcons.info_circle, color: Colors.white,),
              title: Text("About Us", style: TextStyle(color: Colors.white)),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(LineAwesomeIcons.sign_out, color: Colors.white,),
              title: Text("Logout", style: TextStyle(color: Colors.white)),
              onTap: () { FirebaseAuth.instance.signOut(); Navigator.pushNamed(context, '/login');},
            ),
          ],
        ));
  }
}
