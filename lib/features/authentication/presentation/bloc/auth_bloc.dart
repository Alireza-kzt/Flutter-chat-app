import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_chat_app/core/repositories/local_data_sorce.dart';
import 'package:flutter_chat_app/core/repositories/remote_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';
part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  DatabaseMethods databaseMethod = DatabaseMethods();
  AuthBloc() : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is onLoginSubmit) {
      yield Loading();
      var userOrError = await databaseMethod.loginUser(event.email, event.password);
      if (userOrError == null) {
        yield Error();
      } else {
        String username = await databaseMethod.getDisplayName();
        LocalData.saveUserNameSharedPreference(username);
        LocalData.saveUserEmailSharedPreference(event.email);
        yield Loaded();
      }
    }
    if (event is onSignInSubmit) {
      yield Loading();
      var userOrError = await databaseMethod.registerUser(event.email, event.password);
      if (userOrError == null) {
        yield Error();
      } else {
        databaseMethod.addUser(event.email, event.username);
        LocalData.saveUserNameSharedPreference(event.username);
        LocalData.saveUserEmailSharedPreference(event.email);
        yield Loaded();
      }
    }
  }
}
