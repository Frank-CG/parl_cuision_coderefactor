import 'package:flutter/material.dart';

import 'package:parl_cuision_coderefactor/app_conifg.dart';
import 'package:parl_cuision_coderefactor/models/enums.dart';

class ReservationTitle extends StatelessWidget {
  ReservationTitle({Key key}) : super(key: key);

  final isLargeScreen =
      AppConfig.instance.deviceType == DeviceType.Tablets ? true : false;
  final isLandscape =
      AppConfig.instance.orientation == Orientation.landscape ? true : false;
  final double _fontSizeAdjustment =
      AppConfig.instance.deviceType == DeviceType.Tablets ? 8.0 : 0.0;
  final double _basicWidth = AppConfig.instance.blockWidth;
  final double _basicHeigth = AppConfig.instance.blockHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: _basicHeigth * 15,
        color: Colors.white,
        alignment: Alignment.bottomLeft,
        padding: EdgeInsets.only(
          left: _basicWidth * 5.0,
          right: _basicWidth * 5.0,
          top: _basicHeigth * 5.0,
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
