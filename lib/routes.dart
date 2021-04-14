import 'package:flutter/material.dart';
import 'package:flutter_chat_app/features/authentication/presentation/pages/profile.dart';
import 'package:flutter_chat_app/features/search/presentation/pages/search_page.dart';
import 'features/authentication/presentation/pages/login_page.dart';
import 'features/authentication/presentation/pages/signup_page.dart';
import 'features/home/presentation/pages/home_page.dart';



class Routes {
  static final Map<String, WidgetBuilder> routes = {
    '/home': (_) => HomePage(),
    '/auth': (_) => AuthPage(),
    '/login': (_) => LoginPage(),
    '/search': (_) => SearchPage(),
    '/profile':(_) => Profile(),
  };
}
