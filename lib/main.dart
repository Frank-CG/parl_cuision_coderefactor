import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:parl_cuision_coderefactor/blocs/blocs.dart';
import 'package:parl_cuision_coderefactor/models/models.dart';
import 'package:parl_cuision_coderefactor/pages/pages.dart';
import 'package:parl_cuision_coderefactor/repositories/repositories.dart';


void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository _userRepository = new UserRepository();
  final MenuRepository _menuRepository = new MenuRepository();
  final Order _order = new Order();
  runApp(App(userRepository: _userRepository, menuRepository: _menuRepository, order: _order, ));
}

class App extends StatefulWidget {
  final UserRepository userRepository;
  final MenuRepository menuRepository;
  final Order order;

  App({Key key, @required this.userRepository, @required this.menuRepository, @required this.order}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  
  @override
  Widget build(BuildContext context) {
    return BlocProviderTree(
      blocProviders: [
        BlocProvider<AuthenticationBloc>(
          builder: (context) => AuthenticationBloc(userRepository: widget.userRepository),
        ),
        BlocProvider<LoginBloc>(
          builder: (context) => LoginBloc(userRepository: widget.userRepository),
        ),
        BlocProvider<NavBloc>(
          builder: (BuildContext context) => NavBloc(),
        ),
        BlocProvider<MenuBloc>(
          builder: (context) => MenuBloc(repository: widget.menuRepository),
        ),
        BlocProvider<OrderBloc>(
          builder: (context) => OrderBloc(order: widget.order),
        ),
      ],
      child: MaterialApp(
        title: 'Parl Cuision',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainPage(),
      ),
    );
  }
}
