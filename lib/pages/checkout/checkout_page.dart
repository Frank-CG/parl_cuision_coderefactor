import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parl_cuision_coderefactor/app_conifg.dart';
import 'package:parl_cuision_coderefactor/pages/checkout/checkout.dart';
import 'package:parl_cuision_coderefactor/pages/checkout/checkout_bottom.dart';
import 'package:parl_cuision_coderefactor/pages/checkout/checkout_center.dart';
import 'package:parl_cuision_coderefactor/pages/checkout/checkout_top.dart';

class CheckoutPage extends StatefulWidget {
  CheckoutPage({
    Key key,
  }) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        builder: (BuildContext context) => CheckoutBloc(),
        child: Container(
          width: AppConfig.instance.blockWidth * 100,
          child: SingleChildScrollView(
            // controller: controller,
            child: Column(
              children: <Widget>[
                CheckoutTop(),
                CheckoutCenter(),
                CheckoutBottom(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
