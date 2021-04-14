part of 'search_bloc.dart';

abstract class SearchEvent {
  const SearchEvent();
}

class SearchUsername extends SearchEvent {
  final String username;

  SearchUsername({this.username});
}
