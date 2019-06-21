import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parl_cuision_coderefactor/pages/reservation/reservation_bloc.dart';

class ReservationStepper extends StatefulWidget {
  ReservationStepper({Key key}) : super(key: key);

  _ReservationStepperState createState() => _ReservationStepperState();
}

class _ReservationStepperState extends State<ReservationStepper> {
  final int totalSteps = 4;

  final double _kStepSize = 24.0;
  final List<String> _stepTitles = <String>[
    "GUESTS",
    "DATE",
    "TIME",
    "SUMMARY"
  ];
  ReserveBloc _reserveBloc;

  @override
  void initState() {
    super.initState();
    _reserveBloc = BlocProvider.of<ReserveBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.getInstance().setHeight(300),
      color: Colors.white,
      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 14.0),
      child: BlocBuilder(
        bloc: _reserveBloc,
        builder: (BuildContext context, ReserveState state) {
          return _buildTopPath(totalSteps, state.stepIndex);
        },
      ),
    );
  }

  Widget _buildTopPath(int totalSteps, int currentStep) {
    List<Widget> children = <Widget>[];
    for (int i = 0; i < totalSteps; i++) {
      children.add(_buildStep(i, currentStep));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _buildStep(int index, int currentStep) {
    var stepTextStyle = TextStyle(
        fontSize: 10.0,
        fontFamily: "Nunito Sans",
        fontWeight: FontWeight.w700,
        color: _circleColor(index, currentStep));
    List<Widget> step = <Widget>[];
    step.add(_buildLine(index, currentStep, true));
    step.add(_buildCircle(index,currentStep));
    step.add(_buildLine(index, currentStep, false));

    return Column(
      children: <Widget>[
        Row(
          children: step,
        ),
        SizedBox(
          height: 8.0,
        ),
        Text(
          _stepTitles[index],
          style: stepTextStyle,
        ),
      ],
    );
  }

  Widget _buildLine(int index, int currentStep, bool isLeft) {
    int compNum = 0;
    if (isLeft) {
      compNum = currentStep;
    } else {
      compNum = currentStep - 1;
    }
    return Container(
      width: ScreenUtil.getInstance().setWidth(85),
      height: 1.0,
      color: index <= compNum ? Colors.green : Colors.grey.shade400,
    );
  }

  Widget _buildCircle(int index, int currentStep) {
    return Container(
      width: _kStepSize,
      height: _kStepSize,
      child: AnimatedContainer(
        curve: Curves.fastOutSlowIn,
        duration: kThemeAnimationDuration,
        decoration: BoxDecoration(
          color: _circleColor(index,currentStep),
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 4,
          ),
          child: Text(
            (index + 1).toString(),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Color _circleColor(int index, int currentStep) {
    return index <= currentStep ? Colors.green : Colors.grey.shade400;
  }
}
