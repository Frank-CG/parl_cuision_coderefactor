import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parl_cuision_coderefactor/pages/common/custom_picker.dart';
import 'package:parl_cuision_coderefactor/pages/reservation/reservation_bloc.dart';

class HourMinutePicker extends StatefulWidget {
  HourMinutePicker({Key key}) : super(key: key);

  _HourMinutePickerState createState() => _HourMinutePickerState();
}

class _HourMinutePickerState extends State<HourMinutePicker> {
  ReserveBloc _bloc;
  int _hour;
  int _minute;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<ReserveBloc>(context);
    _hour = -1;
    _minute = -1;
  }

  @override
  Widget build(BuildContext context) {
    List<String> _hours = <String>[];
    for (int i = 0; i < 24; i++) {
      if (i < 10) {
        _hours.add("0" + i.toString());
      } else {
        _hours.add(i.toString());
      }
    }
    List<String> _minutes = <String>["00", "15", "30", "45"];

    return Column(
      children: <Widget>[
        _getCustomPicker("HOURS", _hours),
        _getCustomPicker("MINUTES", _minutes),
      ],
    );
  }

  Widget _getCustomPicker(String title, List<String> options) {
    return CustomPicker(
        title: title, options: options, onChanged: _customPickerCallback);
  }

  void _customPickerCallback(String selectedValue) {
    print(selectedValue);
    print(_bloc.currentState.reserveTimeFormated);
    var temp = selectedValue.split(":");
    String value = temp[1];
    if (temp[0] == "HOURS") {
      setState(() {
       _hour = int.parse(value);
       _minute = _bloc.currentState.reservMinute;
      });
    } else if (temp[0] == "MINUTES") {
      setState(() {
       _minute = int.parse(value);
       _hour = _bloc.currentState.reservHour;
      });
    }
    print("hour=$_hour, minute=$_minute");
    _bloc.dispatch(StepChange(
      stepIndex: _bloc.currentState.stepIndex,
      reservGuestsNumber: _bloc.currentState.reservGuestsNumber,
      reservDateTime: _bloc.currentState.reservDateTime,
      reservHour: _hour,
      reservMinute: _minute,
    ));
    // _bloc.dispatch(CheckoutSetTime(hour: _hour, minute: _minute,));
  }
}
