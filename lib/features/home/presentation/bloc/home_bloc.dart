import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_chat_app/core/repositories/local_data_sorce.dart';
import 'package:flutter_chat_app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    Future<String> displayName = LocalData.getUserNameSharedPreference();
    Future<String> displayEmail = LocalData.getUserEmailSharedPreference();
    if(displayName == null && displayEmail == null)
      yield Loading();
    else
      yield Loaded(displayName, displayEmail);
  }
}
