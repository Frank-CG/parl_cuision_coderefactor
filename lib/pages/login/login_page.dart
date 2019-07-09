import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parl_cuision_coderefactor/app_conifg.dart';
import 'package:parl_cuision_coderefactor/blocs/blocs.dart';

import 'login_form.dart';

class LoginPage extends StatefulWidget {
  LoginPage({
    Key key,
  }) : super(key: key);

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
    print("Width:" + AppConfig.instance.screenWidth.toString());
    print("Heigth:" + AppConfig.instance.screenHeight.toString());
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: Container(
        // width: ScreenUtil.getInstance().setWidth(1125),
        // height: ScreenUtil.getInstance().setHeight(2436),
        width: AppConfig.instance.screenWidth,
        height: AppConfig.instance.screenHeight,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/bg.png"), fit: BoxFit.fill),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                // height: ScreenUtil.getInstance().setHeight(400),
                height: AppConfig.instance.blockHeight * 6,
              ),
              Container(
                height: AppConfig.instance.blockHeight * 14,
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      height: AppConfig.instance.blockHeight * 7,
                      child: FittedBox(
                        child: Text(
                          "Parl",
                          style: TextStyle(
                            color: Colors.white,
                            // fontSize: 48.0,
                            fontFamily: "Playfair Display",
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: AppConfig.instance.blockHeight * 7,
                      child: FittedBox(
                        child: Text(
                          "Cuision",
                          style: TextStyle(
                              color: Colors.white,
                              // fontSize: 48.0,
                              fontFamily: "Playfair Display"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: AppConfig.instance.blockHeight * 3,
                alignment: Alignment.topCenter,
                child: FittedBox(
                  child: Text(
                    '- W E L C O M E -',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                height: AppConfig.instance.blockHeight * 75,
                alignment: Alignment.topCenter,
                child: LoginForm(
                  authenticationBloc: _authenticationBloc,
                  loginBloc: _loginBloc,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // _loginBloc.dispose();
    super.dispose();
  }
}
