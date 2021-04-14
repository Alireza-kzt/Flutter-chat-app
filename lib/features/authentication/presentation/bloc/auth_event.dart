part of 'auth_bloc.dart';

abstract class AuthEvent  {
  const AuthEvent();
}

class onLoginSubmit extends AuthEvent{
  final String email;
  final String password;

  onLoginSubmit({this.email, this.password});
}

class onSignInSubmit extends AuthEvent{
  final String username;
  final String email;
  final String password;

  onSignInSubmit({this.email, this.username, this.password});
}