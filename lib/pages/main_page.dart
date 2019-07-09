import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:parl_cuision_coderefactor/app_conifg.dart';
import 'package:parl_cuision_coderefactor/blocs/blocs.dart';
import 'package:parl_cuision_coderefactor/pages/pages.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  AuthenticationBloc authenticationBloc;

  @override
  void initState() { 
    super.initState();
    authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    authenticationBloc.dispatch(AppStarted());
  }

  @override
  Widget build(BuildContext context) {
    AppConfig.instance = AppConfig()..init(context);
    
    return BlocBuilder<AuthenticationEvent, AuthenticationState>(
          bloc: authenticationBloc,
          builder: (BuildContext context, AuthenticationState state) {
            if (state is AuthenticationUninitialized) {
              return SplashPage();
            }
            if (state is AuthenticationAuthenticated) {
              return HomePage();
            }
            if (state is AuthenticationUnauthenticated) {
              return LoginPage();
            }
            if (state is AuthenticationLoading) {
              return LoadingIndicator();
            }
          },
        );
  }
}