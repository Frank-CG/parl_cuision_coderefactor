import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parl_cuision_coderefactor/pages/reservation/reservation_bloc.dart';
import 'package:parl_cuision_coderefactor/pages/reservation/reservation_stepbody.dart';
import 'package:parl_cuision_coderefactor/pages/reservation/reservation_stepper.dart';
import 'package:parl_cuision_coderefactor/pages/reservation/reservation_title.dart';

class ReservationPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (BuildContext context) => ReserveBloc(),
      child: Container(
        child: SingleChildScrollView(
          // controller: controller,
          child: Column(
            children: <Widget>[
              ReservationTitle(),
              ReservationStepper(),
              ReservationStepBody(),
            ],
          ),
        ),
      ),
    );
  }
}
