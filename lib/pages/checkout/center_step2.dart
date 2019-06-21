import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parl_cuision_coderefactor/app_conifg.dart';
import 'package:parl_cuision_coderefactor/pages/checkout/checkout.dart';
import 'package:parl_cuision_coderefactor/pages/checkout/hour_minute_picker.dart';
import 'package:parl_cuision_coderefactor/pages/common/custom_picker.dart';

class CenterStep2 extends StatefulWidget {
  CenterStep2({Key key}) : super(key: key);

  _CenterStep2State createState() => _CenterStep2State();
}

class _CenterStep2State extends State<CenterStep2> {
  CheckoutBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<CheckoutBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: ScreenUtil.getInstance().setHeight(280),
          padding: EdgeInsets.only(
            left: ScreenUtil.getInstance().setWidth(63),
            top: ScreenUtil.getInstance().setHeight(90),
          ),
          alignment: Alignment.topLeft,
          child: Text(
            "Select pickup time",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w800,
              fontFamily: AppConfig.defaultFontFamily,
            ),
          ),
        ),
        Container(
          height: ScreenUtil.getInstance().setHeight(1000),
          child: HourMinutePicker(),
        ),
        Container(
          height: ScreenUtil.getInstance().setHeight(320),
          color: Colors.white,
          padding: EdgeInsets.only(
            left: ScreenUtil.getInstance().setWidth(63),
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: ScreenUtil.getInstance().setWidth(125),
                margin: EdgeInsets.only(
                  right: ScreenUtil.getInstance().setWidth(40),
                ),
                child: Image.asset(
                  "assets/images/icon_pickuptime.png",
                  width: ScreenUtil.getInstance().setWidth(120),
                ),
              ),
              Container(
                width: ScreenUtil.getInstance().setWidth(420),
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Pickup",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: AppConfig.defaultFontFamily,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      "time",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: AppConfig.defaultFontFamily,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: ScreenUtil.getInstance().setWidth(400),
                child: BlocBuilder(
                  bloc: _bloc,
                  builder: (BuildContext context, CheckoutState state) {
                    if (state is CheckoutStep2) {
                      TextStyle pickupTimeStyle = TextStyle(
                          fontSize: 28.0,
                          fontFamily: AppConfig.defaultFontFamily,
                          fontWeight: FontWeight.bold);

                      if (state.pickupTime == "Unselected") {
                        pickupTimeStyle = TextStyle(
                          fontSize: 18.0,
                          fontFamily: AppConfig.defaultFontFamily,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        );
                      }
                      return Text(
                        state.pickupTime,
                        style: pickupTimeStyle,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

}
