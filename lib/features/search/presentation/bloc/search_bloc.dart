import 'dart:async';
import 'package:flutter_chat_app/core/repositories/remote_data_source.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bloc/bloc.dart';


part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial());

  QuerySnapshot searchQuerySnapshot;
  DatabaseMethods databaseMethod = DatabaseMethods();

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is SearchUsername) {
      yield SearchLoading();
      searchQuerySnapshot = await databaseMethod.getUserByUsername(event.username);
      if (searchQuerySnapshot.docs.isEmpty)
        yield NothingFound();
      else
        yield SearchLoaded(docs: searchQuerySnapshot.docs);
    }
  }
}
