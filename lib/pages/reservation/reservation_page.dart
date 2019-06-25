import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        width: ScreenUtil.getInstance().setWidth(1125),
        height: ScreenUtil.getInstance().setHeight(2400),
        child: Column(
          children: <Widget>[
            ReservationTitle(),
            ReservationStepper(),
            ReservationStepBody(),
            // Container(
            //   height: ScreenUtil.getInstance().setHeight(1870),
            //   // color: Colors.grey[300],
            //   //child: ReservSteps(callback),
            // ),
          ],
        ),
      ),
    );
  }
}
