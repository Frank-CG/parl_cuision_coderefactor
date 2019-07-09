import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart' as dp;

import 'package:parl_cuision_coderefactor/app_conifg.dart';
import 'package:parl_cuision_coderefactor/blocs/navigate_bloc.dart';
import 'package:parl_cuision_coderefactor/models/enums.dart';
import 'package:parl_cuision_coderefactor/pages/common/ex_day_picker.dart';
import 'package:parl_cuision_coderefactor/pages/reservation/hour_minute_picker.dart';
import 'package:parl_cuision_coderefactor/pages/reservation/reservation_bloc.dart';

import 'reserve_dialog.dart';

class ReservationStepBody extends StatefulWidget {
  ReservationStepBody({Key key}) : super(key: key);

  _ReservationStepBodyState createState() => _ReservationStepBodyState();
}

class _ReservationStepBodyState extends State<ReservationStepBody> {
  ReserveBloc _reserveBloc;

  bool isLargeScreen;
  bool isLandscape;
  double _fontSizeAdjustment;
  double _basicWidth;
  double _basicHeigth;

  @override
  void initState() {
    _reserveBloc = BlocProvider.of<ReserveBloc>(context);
    isLargeScreen =
        AppConfig.instance.deviceType == DeviceType.Tablets ? true : false;
    isLandscape =
        AppConfig.instance.orientation == Orientation.landscape ? true : false;
    _fontSizeAdjustment =
        AppConfig.instance.deviceType == DeviceType.Tablets ? 8.0 : 0.0;
    _basicWidth = AppConfig.instance.blockWidth;
    _basicHeigth = AppConfig.instance.blockHeight;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isLargeScreen =
        AppConfig.instance.deviceType == DeviceType.Tablets ? true : false;
    isLandscape =
        AppConfig.instance.orientation == Orientation.landscape ? true : false;
    _fontSizeAdjustment =
        AppConfig.instance.deviceType == DeviceType.Tablets ? 8.0 : 0.0;
    _basicWidth = AppConfig.instance.blockWidth;
    _basicHeigth = AppConfig.instance.blockHeight;
    return BlocBuilder(
      bloc: _reserveBloc,
      builder: (BuildContext context, ReserveState state) {
        int index = state.stepIndex + 1;
        String title = "-  STEP  $index  -";
        List<String> subtitles = <String>[
          "Pick number of guests",
          "Select the date",
          "Select time",
          "Summary"
        ];

        Color unSelectedTextColor = Colors.grey.shade600;
        TextStyle titleStyle = TextStyle(
          fontSize: 14 + _fontSizeAdjustment,
          fontFamily: AppConfig.defaultFontFamily,
          color: unSelectedTextColor,
          fontWeight: FontWeight.bold,
        );

        TextStyle subTitleStyle = TextStyle(
          fontSize: 20 + _fontSizeAdjustment,
          fontFamily: AppConfig.defaultFontFamily,
          color: unSelectedTextColor,
          fontWeight: FontWeight.bold,
        );

        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 20.0,
              ),
              Container(
                child: Text(
                  title,
                  style: titleStyle,
                ),
              ),
              Container(
                child: Text(
                  subtitles[state.stepIndex],
                  style: subTitleStyle,
                ),
              ),
              _getPageContent(state.stepIndex),
              _getNextButton(
                  state.stepIndex, state.totalSteps, state.nextEnable),
              Container(
                height: 50.0,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _getNextButton(int currentStep, int totalSteps, bool isEnable) {
    String buttonText = "Next Step";
    if (currentStep == totalSteps - 1) {
      buttonText = "Reserve";
    }
    Color buttonColor = isEnable ? Colors.green : Colors.grey;
    TextStyle buttonTextStyle = TextStyle(
      fontSize: 20 + _fontSizeAdjustment,
      fontFamily: AppConfig.defaultFontFamily,
      fontWeight: FontWeight.bold,
    );
    return Container(
      height: 50.0,
      child: ButtonTheme(
        minWidth: _basicWidth * 60.0,
        child: RaisedButton(
          color: buttonColor,
          textColor: Colors.white,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0)),
          child: Text(
            buttonText,
            style: buttonTextStyle,
          ),
          onPressed: () {
            if (currentStep == totalSteps - 1) {
              showDialog(
                context: context,
                builder: (BuildContext context) => ReserveDialog(
                      title: "Success!",
                      reserveTime:
                          _reserveBloc.currentState.reserveTimeFormated,
                      buttonText: "OK",
                      callback: () {
                        NavBloc _navBloc = BlocProvider.of<NavBloc>(context);
                        _navBloc.dispatch(NavTo(
                          pageName: PageName.Menu,
                          previousPageName: PageName.Menu,
                        ));
                      },
                    ),
              );
            } else {
              if (isEnable) {
                _reserveBloc.dispatch(
                  StepChange(
                    stepIndex: currentStep + 1,
                    reservGuestsNumber:
                        _reserveBloc.currentState.reservGuestsNumber,
                    reservDateTime: _reserveBloc.currentState.reservDateTime,
                    reservHour: _reserveBloc.currentState.reservHour,
                    reservMinute: _reserveBloc.currentState.reservMinute,
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }

  Widget _getPageContent(int stepIndex) {
    TextStyle contentStyle = TextStyle(
      fontSize: 18.0 + _fontSizeAdjustment,
      fontFamily: AppConfig.defaultFontFamily,
      color: Colors.grey.shade600,
      fontWeight: FontWeight.bold,
    );

    Widget content;
    if (stepIndex == 0) {
      content = Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                top: 50.0,
              ),
              child: _buildPickCircle(
                  _reserveBloc.currentState.reservGuestsNumber, 130),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 15.0,
                bottom: 50,
              ),
              child: Text(
                "8 guests maximum",
                style: contentStyle,
              ),
            ),
          ],
        ),
      );
    } else if (stepIndex == 1) {
      dp.DatePickerStyles styles = dp.DatePickerStyles(
        displayedPeriodTitle: TextStyle(
          color: Colors.green,
          fontSize: 20.0 + _fontSizeAdjustment,
          fontWeight: FontWeight.bold,
        ),
        defaultDateTextStyle: TextStyle(
          fontSize: 14.0 + _fontSizeAdjustment,
        ),
        selectedDateStyle: Theme.of(context)
            .accentTextTheme
            .body2
            .copyWith(color: Colors.white),
        selectedSingleDateDecoration:
            BoxDecoration(color: Colors.green, shape: BoxShape.circle),
      );

      double containerWidth =
          isLandscape ? _basicWidth * 75.0 : _basicWidth * 90.0;
      double conatinerHeigth =
          isLandscape ? _basicWidth * 55.0 : _basicWidth * 70.0;

      content = Container(
        width: containerWidth,
        height: conatinerHeigth,
        // padding: EdgeInsets.all(16.0),
        child: ExDayPicker(
          selectedDate: _reserveBloc.currentState.reservDateTime,
          onChanged: (DateTime value) {
            DateTime _selectedDate = new DateTime(
              value.year,
              value.month,
              value.day,
            );
            _reserveBloc.dispatch(
              StepChange(
                stepIndex: _reserveBloc.currentState.stepIndex,
                reservGuestsNumber:
                    _reserveBloc.currentState.reservGuestsNumber,
                reservDateTime: _selectedDate,
                reservHour: _reserveBloc.currentState.reservHour,
                reservMinute: _reserveBloc.currentState.reservMinute,
              ),
            );
          },
          firstDate: DateTime.now().subtract(Duration(hours: 1)),
          lastDate: DateTime.now().add(Duration(days: 365)),
          onlyWeekdays: true,
          datePickerStyles: styles,
        ),
      );
    } else if (stepIndex == 2) {
      String sTime = _reserveBloc.currentState.reserveTimeFormated;
      TextStyle timeStyle = TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 50.0,
      );
      if (sTime == "Unselected") {
        timeStyle = TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24.0,
          color: Colors.grey.shade600,
        );
      }

      double containerWidth =
          isLandscape ? _basicWidth * 70.0 : _basicWidth * 90.0;

      content = Container(
        width: containerWidth,
        child: Column(
          children: <Widget>[
            Container(
              height: 20.0,
            ),
            Container(
              child: Text(
                sTime,
                style: timeStyle,
                textAlign: TextAlign.center,
              ),
            ),
            HourMinutePicker(),
            Container(
              height: 30.0,
            ),
          ],
        ),
      );
    } else if (stepIndex == 3) {
      int _guestNumber = _reserveBloc.currentState.reservGuestsNumber;
      content = Container(
        margin: EdgeInsets.only(
          top: 30.0,
          bottom: 40.0,
        ),
        // color: Colors.lightGreen[300],
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                bottom: 20.0,
              ),
              child: Image.asset(
                "assets/images/icon_summary.png",
                width: _basicWidth * 20.0,
              ),
            ),
            Text(
              _reserveBloc.currentState.reservDateFormated,
              style: TextStyle(
                fontSize: 20.0 + _fontSizeAdjustment,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              _reserveBloc.currentState.reserveTimeFormated,
              style: TextStyle(
                fontSize: 70.0 + _fontSizeAdjustment * 2,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "${_guestNumber + 1} person",
              style: TextStyle(
                fontSize: 16.0 + _fontSizeAdjustment,
                fontFamily: AppConfig.defaultFontFamily,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      );
    }

    return content;
  }

  Widget _buildPickCircle(int number, double diameter) {
    return Container(
      width: diameter + 60,
      height: diameter,
      child: AnimatedContainer(
        curve: Curves.fastOutSlowIn,
        duration: kThemeAnimationDuration,
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.blueGrey,
            width: 1.0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ButtonTheme(
              minWidth: 60,
              child: RaisedButton(
                color: Colors.green,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                textColor: Colors.white,
                child: Text(
                  "-",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                onPressed: () {
                  if (_reserveBloc.currentState.reservGuestsNumber > 0) {
                    _reserveBloc.dispatch(StepChange(
                      stepIndex: _reserveBloc.currentState.stepIndex,
                      reservGuestsNumber:
                          _reserveBloc.currentState.reservGuestsNumber - 1,
                      reservDateTime: _reserveBloc.currentState.reservDateTime,
                      reservHour: _reserveBloc.currentState.reservHour,
                      reservMinute: _reserveBloc.currentState.reservMinute,
                    ));
                  }
                },
              ),
            ),
            Text(
              number.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 60.0,
              ),
            ),
            ButtonTheme(
              minWidth: 60,
              child: RaisedButton(
                color: Colors.green,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                textColor: Colors.white,
                child: Text(
                  "+",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                onPressed: () {
                  if (_reserveBloc.currentState.reservGuestsNumber < 8) {
                    _reserveBloc.dispatch(StepChange(
                      stepIndex: _reserveBloc.currentState.stepIndex,
                      reservGuestsNumber:
                          _reserveBloc.currentState.reservGuestsNumber + 1,
                      reservDateTime: _reserveBloc.currentState.reservDateTime,
                      reservHour: _reserveBloc.currentState.reservHour,
                      reservMinute: _reserveBloc.currentState.reservMinute,
                    ));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
