import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parl_cuision_coderefactor/blocs/blocs.dart';

import 'login_form.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc _loginBloc;
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body:Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/bg.png"), fit: BoxFit.fill),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              flex: 0,
              child: Container(
                height: 100,
              ),
            ),
            Center(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Text(
                      "Parl",
                      style: TextStyle(color: Colors.white, fontSize: 48.0, fontFamily: "Playfair Display",),
                    ),
                    Text(
                      "Cuision",
                      style: TextStyle(color: Colors.white, fontSize: 48.0, fontFamily: "Playfair Display"),
                    ),
                  ],
                ),
              ),
            ),            
            Text('- W E L C O M E -', style: TextStyle(color: Colors.white,),),
            Expanded(
              child: LoginForm(
                authenticationBloc: _authenticationBloc,
                loginBloc: _loginBloc,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }
}
