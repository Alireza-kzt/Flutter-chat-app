import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/repositories/remote_data_source.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_app/features/search/presentation/bloc/search_bloc.dart';
import 'package:flutter_chat_app/features/search/presentation/widgets/search_list.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchTextEditingController = TextEditingController();
  QuerySnapshot searchQuerySnapshot;
  DatabaseMethods databaseMethod = DatabaseMethods();
  SearchBloc bloc = SearchBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        title: Text("Search", style: TextStyle(color:Colors.white, fontWeight: FontWeight.w400),),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 80.0,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 12, right: 12, top: 18),
              child: TextField(
                  keyboardType: TextInputType.name,
                  autofocus: true,
                  controller: searchTextEditingController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).scaffoldBackgroundColor,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(30.0)),
                    contentPadding: EdgeInsets.only(
                        top: 15, left: 20, bottom: 15, right: 20),
                    suffixIcon: IconButton(
                      onPressed: () {
                        bloc.add(SearchUsername(
                            username: searchTextEditingController.text));
                      },
                      icon: Icon(
                        LineAwesomeIcons.search,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    hintText: "Search",
                  )),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0)),
              ),
              child: BlocBuilder<SearchBloc, SearchState>(
                cubit: bloc,
                builder: (context, state) {
                  if (state is SearchLoaded) {
                    return SearchList(
                      docs: state.docs,
                    );
                  } else if (state is SearchInitial) {
                    return Container();
                  } else if (state is SearchLoading) {
                    return Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        alignment: Alignment.topCenter,
                        child: CircularProgressIndicator());
                  } else if (state is NothingFound) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      alignment: Alignment.topCenter,
                      child: Text("Nothing Found!"),
                    );
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
