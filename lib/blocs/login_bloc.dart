import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:parl_cuision_coderefactor/blocs/blocs.dart';
import 'package:parl_cuision_coderefactor/repositories/repositories.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  // final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.userRepository,
    // @required this.authenticationBloc,
  })  : assert(userRepository != null);
        // assert(authenticationBloc != null);

  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final token = await userRepository.authenticate(
          username: event.username,
          password: event.password,
          idp: event.identityProvider,
        );

        if(token != "local"){
          event.authenticationBloc.dispatch(LoggedIn(token: token));
          yield LoginInitial();
        }else{
          yield LoginFailure(error: "Username not found!");
        }
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
