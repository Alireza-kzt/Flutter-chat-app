import 'package:flutter/material.dart';
import 'package:flutter_chat_app/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_app/theme.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      initialRoute: FirebaseAuth.instance.currentUser == null ? '/auth' : '/home',
      routes: Routes.routes,
    );
  }
}