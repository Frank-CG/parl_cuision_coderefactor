import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parl_cuision_coderefactor/app_conifg.dart';
import 'package:parl_cuision_coderefactor/blocs/blocs.dart';
import 'package:parl_cuision_coderefactor/pages/checkout/checkout.dart';
import 'package:parl_cuision_coderefactor/pages/checkout/checkout_bloc/checkout_bloc.dart';

class CheckoutTop extends StatefulWidget {
  CheckoutTop({Key key}) : super(key: key);

  @override
  _CheckoutTopState createState() => _CheckoutTopState();
}

class _CheckoutTopState extends State<CheckoutTop> {
  final _pageTitle = "Checkout";
  final List<String> _stepTitles = <String>["REVIEW", "SET TIME", "CONFIRM"];
  CheckoutBloc _bloc;

  double _kStepSize = 24.0;

  @override
  void initState() {
    super.initState();
    this._bloc = BlocProvider.of<CheckoutBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _bloc,
      builder: (BuildContext context, CheckoutState state) {
        return Container(
          child: Column(
            children: <Widget>[
              Container(
                height: ScreenUtil.getInstance().setHeight(350),
                padding: EdgeInsets.only(
                    top: ScreenUtil.getInstance().setHeight(190)),
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        final _navBloc = BlocProvider.of<NavBloc>(context);
                        _navBloc.dispatch(NavTo(
                          pageName: _navBloc.currentState.previousPageName,
                          previousPageName: _navBloc.currentState.previousPageName,
                        ));
                      },
                      icon: Icon(Icons.arrow_back_ios),
                    ),
                    Text(
                      _pageTitle,
                      style: TextStyle(
                        fontSize: 36.0,
                        fontWeight: FontWeight.w600,
                        fontFamily: AppConfig.defaultFontFamily,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: ScreenUtil.getInstance().setHeight(300),
                color: Colors.white,
                padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 14.0),
                child: BlocBuilder(
                  bloc: _bloc,
                  builder: (BuildContext context, CheckoutState state) {
                    int curIndex = 0;
                    if (state is CheckoutStep1) {
                      curIndex = 0;
                    }
                    if (state is CheckoutStep2) {
                      curIndex = 1;
                    }
                    if (state is CheckoutStep3) {
                      curIndex = 2;
                    }
                    return _buildTopPath(3, curIndex);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTopPath(int stepCount, int currentStep) {
    List<Widget> children = <Widget>[];

    for (int i = 0; i < stepCount; i++) {
      children.add(_buildStep(i, currentStep));
    }
    // children.add( _buildStep(stepCount-1, true) );
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
    // if(index == 0){
    //   step.add(_buildLine(index,true));
    // }
    step.add(_buildLine(index, currentStep, true));
    step.add(_buildCircle(index, currentStep));
    step.add(_buildLine(index, currentStep, false));
    // if(index == steps_count - 1){
    //   step.add(_buildLine(index, false));
    // }
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
    int compIndex = 0;
    if (isLeft) {
      compIndex = currentStep;
    } else {
      compIndex = currentStep - 1;
    }
    return Container(
      width: ScreenUtil.getInstance().setWidth(120),
      height: 1.0,
      color: index <= compIndex ? Colors.green : Colors.grey.shade400,
    );
  }

  Color _circleColor(int index, int currentStep) {
    return index <= currentStep ? Colors.green : Colors.grey.shade400;
  }

  Widget _buildCircle(int index, int currentStep) {
    return Container(
      width: _kStepSize,
      height: _kStepSize,
      child: AnimatedContainer(
        curve: Curves.fastOutSlowIn,
        duration: kThemeAnimationDuration,
        decoration: BoxDecoration(
          color: _circleColor(index, currentStep),
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
}
