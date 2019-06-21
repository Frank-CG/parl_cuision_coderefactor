import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parl_cuision_coderefactor/app_conifg.dart';

class ReservationTitle extends StatelessWidget {
  const ReservationTitle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: ScreenUtil.getInstance().setHeight(350),
        width: ScreenUtil.getInstance().setWidth(1125),
        color: Colors.white,
        alignment: Alignment.bottomLeft,
        padding: EdgeInsets.only(
          left: 16.0,
        ),
        child: Text(
          "Reservations",
          style: TextStyle(
              fontSize: 30.0,
              fontFamily: AppConfig.defaultFontFamily,
              fontWeight: FontWeight.w700),
        ));
  }
}
