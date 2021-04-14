part of 'auth_bloc.dart';

abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {}

class Loading extends AuthState {}

class Error extends AuthState {}

class Loaded extends AuthState {}
