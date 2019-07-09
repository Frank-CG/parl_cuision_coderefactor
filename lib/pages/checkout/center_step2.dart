import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parl_cuision_coderefactor/app_conifg.dart';
import 'package:parl_cuision_coderefactor/models/enums.dart';
import 'package:parl_cuision_coderefactor/pages/checkout/checkout.dart';
import 'package:parl_cuision_coderefactor/pages/checkout/hour_minute_picker.dart';
import 'package:parl_cuision_coderefactor/pages/common/custom_picker.dart';

class CenterStep2 extends StatefulWidget {
  CenterStep2({Key key}) : super(key: key);

  _CenterStep2State createState() => _CenterStep2State();
}

class _CenterStep2State extends State<CenterStep2> {
  CheckoutBloc _bloc;
  bool isLargeScreen;
  bool isLandscape;
  double _fontSizeAdjustment;
  double _basicWidth;
  double _basicHeigth;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<CheckoutBloc>(context);
    
  }

  @override
  Widget build(BuildContext context) {

    isLargeScreen =
        AppConfig.instance.deviceType == DeviceType.Tablets ? true : false;
    isLandscape = AppConfig.instance.orientation == Orientation.landscape
        ? isLargeScreen ? false : true
        : false;
    _fontSizeAdjustment =
        AppConfig.instance.deviceType == DeviceType.Tablets ? 8.0 : 0.0;
    _basicWidth = AppConfig.instance.blockWidth;
    _basicHeigth = AppConfig.instance.blockHeight;

    double titalContainerHeight = isLandscape ? _basicHeigth * 10.0 : _basicHeigth * 8.0;
    double centerContainerHeight = isLandscape ? _basicHeigth * 55.0 : _basicHeigth * 55.0 - 60.0;
    double centerContainerWidth = isLandscape || isLargeScreen ? _basicWidth * 70.0 : _basicWidth * 90.0;
    double centerContainerPadding = isLandscape ? _basicHeigth * 2.0 : _basicHeigth * 5.0;
    double bottomContainerHeight = isLandscape ? _basicHeigth * 15.0 : _basicHeigth * 12.0;

    return Column(
      children: <Widget>[
        Container(
          height: titalContainerHeight,
          padding: EdgeInsets.only(
            left: _basicWidth * 5.0,
          ),
          alignment: Alignment.bottomLeft,
          child: Text(
            "Select pickup time",
            style: TextStyle(
              fontSize: 18.0 + _fontSizeAdjustment,
              fontWeight: FontWeight.w800,
              fontFamily: AppConfig.defaultFontFamily,
            ),
          ),
        ),
        Container(
          width: centerContainerWidth,
          height: centerContainerHeight,
          padding: EdgeInsets.only(top: centerContainerPadding,),
          child: HourMinutePicker(),
        ),
        // Container(height: 50.0,),
        Container(
          height: bottomContainerHeight,
          color: Colors.white,
          padding: EdgeInsets.only(
            left: _basicWidth * 5.0,
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: _basicWidth * 7.5,
                child: Image.asset(
                  "assets/images/icon_pickuptime.png",
                ),
              ),
              Container(width: _basicWidth * 3.0,),
              Container(
                width: _basicWidth * 40.0,
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Pickup",
                      style: TextStyle(
                        fontSize: 16.0 + _fontSizeAdjustment,
                        fontFamily: AppConfig.defaultFontFamily,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      "time",
                      style: TextStyle(
                        fontSize: 16.0 + _fontSizeAdjustment,
                        fontFamily: AppConfig.defaultFontFamily,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: _basicWidth * 40.0,
                child: BlocBuilder(
                  bloc: _bloc,
                  builder: (BuildContext context, CheckoutState state) {
                    if (state is CheckoutStep2) {
                      TextStyle pickupTimeStyle = TextStyle(
                          fontSize: 28.0 + _fontSizeAdjustment,
                          fontFamily: AppConfig.defaultFontFamily,
                          fontWeight: FontWeight.bold);

                      if (state.pickupTime == "Unselected") {
                        pickupTimeStyle = TextStyle(
                          fontSize: 18.0 + _fontSizeAdjustment,
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
