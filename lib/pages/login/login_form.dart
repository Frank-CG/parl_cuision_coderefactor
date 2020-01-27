import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parl_cuision_coderefactor/app_conifg.dart';
import 'package:parl_cuision_coderefactor/blocs/blocs.dart';
import 'package:parl_cuision_coderefactor/repositories/repositories.dart';

class LoginForm extends StatefulWidget {
  final LoginBloc loginBloc;
  final AuthenticationBloc authenticationBloc;

  LoginForm({
    Key key,
    @required this.loginBloc,
    @required this.authenticationBloc,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginBloc get _loginBloc => widget.loginBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginEvent, LoginState>(
      bloc: _loginBloc,
      builder: (
        BuildContext context,
        LoginState state,
      ) {
        if (state is LoginFailure) {
          _onWidgetDidBuild(() {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          });
        }

        return Container(
          // height: AppConfig.instance.blockHeight * 75,
          // decoration: BoxDecoration(
          //   image: DecorationImage(image: AssetImage("assets/images/plate.png"), fit: BoxFit.contain)
          // ),
          //color: Colors.grey.shade300,
          padding: EdgeInsets.fromLTRB(32, 0, 32, 0),
          //padding: EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                children: [
                  // Container(
                  //   height: AppConfig.instance.blockHeight * 3,
                  // ),
                  Container(
                    height: AppConfig.instance.blockHeight * 10,
                    alignment: Alignment.center,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        fillColor: Colors.white,
                        enabledBorder: new UnderlineInputBorder(
                            borderSide: new BorderSide(
                          color: Colors.white70,
                        )),
                      ),
                      controller: _usernameController,
                    ),
                  ),
                  Container(
                    height: AppConfig.instance.blockHeight * 10,
                    alignment: Alignment.center,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        fillColor: Colors.white,
                        enabledBorder: new UnderlineInputBorder(
                            borderSide: new BorderSide(
                          color: Colors.white70,
                        )),
                      ),
                      controller: _passwordController,
                      obscureText: true,
                    ),
                  ),
                  SizedBox(
                    height: AppConfig.instance.blockHeight * 5,
                  ),
                  Container(
                    height: AppConfig.instance.blockHeight * 27,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/plate.png"),
                            fit: BoxFit.contain)),
                  ),
                  Container(
                    height: AppConfig.instance.blockHeight * 6,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: AppConfig.instance.blockWidth * 60,
                        minHeight: AppConfig.instance.blockWidth * 8,
                      ),
                      child: RaisedButton(
                        onPressed: (){
                          if(state is! LoginLoading){
                            _onLoginButtonPressed(IdentityProvider.Local);
                          }
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 16.9, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: AppConfig.instance.blockHeight * 2,
                  ),
                  Container(
                    height: AppConfig.instance.blockHeight * 6,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: AppConfig.instance.blockWidth * 60,
                        minHeight: AppConfig.instance.blockWidth * 8,
                      ),
                      child: RaisedButton(
                        onPressed: (){
                          if(state is! LoginLoading){
                            _onLoginButtonPressed(IdentityProvider.SliqAzureAD);
                          }
                        },
                        child: Text(
                          'Sliq Azure AD Login',
                          style: TextStyle(
                              fontSize: 16.9, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: AppConfig.instance.blockHeight * 5,
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.9,
                        ),
                      ),
                      onTap: () => {},
                    ),
                  ),
                  Container(
                    child: state is LoginLoading
                        ? CircularProgressIndicator()
                        : null,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  _onLoginButtonPressed(IdentityProvider idp) {
    print(_loginBloc.currentState);
    _loginBloc.dispatch(LoginButtonPressed(
      username: _usernameController.text,
      password: _passwordController.text,
      identityProvider: idp,
      authenticationBloc: widget.authenticationBloc,
    ));
  }
}
