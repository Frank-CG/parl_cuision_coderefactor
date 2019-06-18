import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:parl_cuision_coderefactor/blocs/auth_bloc.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super(props);
}

class LoginButtonPressed extends LoginEvent {
  final String username;
  final String password;
  final AuthenticationBloc authenticationBloc;

  LoginButtonPressed({
    @required this.username,
    @required this.password,
    @required this.authenticationBloc,
  }) : super([username, password]);

  @override
  String toString() =>
      'LoginButtonPressed { username: $username, password: $password }';
}