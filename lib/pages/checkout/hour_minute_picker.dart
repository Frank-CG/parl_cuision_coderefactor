import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parl_cuision_coderefactor/pages/checkout/checkout.dart';
import 'package:parl_cuision_coderefactor/pages/common/custom_picker.dart';

class HourMinutePicker extends StatefulWidget {
  HourMinutePicker({Key key}) : super(key: key);

  _HourMinutePickerState createState() => _HourMinutePickerState();
}

class _HourMinutePickerState extends State<HourMinutePicker> {
  CheckoutBloc _bloc;
  String _hour;
  String _minute;

  @override
  void initState() { 
    super.initState();
    _bloc = BlocProvider.of<CheckoutBloc>(context);
    _hour = "-1";
    _minute = "-1";
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
    var temp = selectedValue.split(":");
    String value = temp[1];
    if (temp[0] == "HOURS") {
      _hour = value;
    } else if (temp[0] == "MINUTES") {
      _minute = value;
    }
    _bloc.dispatch(CheckoutSetTime(hour: _hour, minute: _minute,));
  }
}