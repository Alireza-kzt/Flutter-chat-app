import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/features/home/presentation/widgets/scaffold_drawer.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';

import 'home_page_scaffold.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return InnerDrawer(
      onTapClose: true,
      swipe: true,
      colorTransitionChild: Colors.orangeAccent,
      colorTransitionScaffold: Colors.transparent,
      offset: IDOffset.only(bottom: 0.05, left: 0.29),
      scale: IDOffset.horizontal( 0.8 ),
      proportionalChildArea : true,
      borderRadius: 40,
      backgroundDecoration: BoxDecoration(color: Colors.orangeAccent ),
      leftAnimationType: InnerDrawerAnimation.linear,
      leftChild: ScaffoldDrawer(),
      scaffold: HomePageScaffold(),
    );
  }
}
