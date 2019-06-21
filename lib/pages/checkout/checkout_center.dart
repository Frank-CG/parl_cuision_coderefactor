import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parl_cuision_coderefactor/pages/checkout/checkout.dart';

import 'center_step1.dart';
import 'center_step2.dart';
import 'center_step3.dart';

class CheckoutCenter extends StatefulWidget {
  CheckoutCenter({Key key}) : super(key: key);

  _CheckoutCenterState createState() => _CheckoutCenterState();
}

class _CheckoutCenterState extends State<CheckoutCenter> {
  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<CheckoutBloc>(context);
    return Container(
      child: BlocBuilder(
        bloc: _bloc,
        builder: (BuildContext context, CheckoutState state) {
          Widget center;
          switch (state.stepIndex) {
            case 0:
              center = new CenterStep1();
              break;
            case 1:
              center = new CenterStep2();
              break;
            case 2:
              center = new CenterStep3();
              break;
            default:
              center = null;
          }
          return center;
        },
      ),
    );
  }
}
