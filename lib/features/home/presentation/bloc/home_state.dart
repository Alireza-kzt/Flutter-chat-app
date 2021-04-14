part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class Loading extends HomeState {}

class Error extends HomeState {}

class Loaded extends HomeState {
  final username, email;
  Loaded(this.username, this.email);
}