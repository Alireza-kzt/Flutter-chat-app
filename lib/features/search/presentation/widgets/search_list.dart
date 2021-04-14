import 'package:flutter/material.dart';
import 'package:flutter_chat_app/features/search/presentation/widgets/search_tile.dart';

class SearchList extends StatelessWidget {
  final docs;

  const SearchList({Key key, this.docs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: docs.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return SearchTile(
            username: docs[index].data()['name'],
            email: docs[index].data()['email'],
          );
        });
  }
}
