import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parl_cuision_coderefactor/app_conifg.dart';
import 'package:parl_cuision_coderefactor/pages/checkout/checkout.dart';

class CheckoutBottom extends StatefulWidget {
  CheckoutBottom({Key key}) : super(key: key);

  _CheckoutBottomState createState() => _CheckoutBottomState();
}

class _CheckoutBottomState extends State<CheckoutBottom> {
  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<CheckoutBloc>(context);

    // if (current_step == 2) {
    //   buttonText = "Place order";
    // }

    // if (((current_step == 1) && (_hour == -1 || _minute == -1))||(current_step == 0 && itemsCount == 0)) {
    //   buttonColor = Colors.grey.shade500;
    // }

    return BlocBuilder(
      bloc: _bloc,
      builder: (BuildContext context, CheckoutState state) {
        String buttonText = "Next";
        Color buttonColor = Colors.green;
        bool disabled = false;
        // if(state.stepIndex == 0) { }
        if (state.stepIndex == 1 && state.pickupTime == "Unselected") {
          buttonColor = Colors.grey.shade500;
          disabled = true;
        }
        if (state.stepIndex == 2) {
          buttonText = "Place order";
        }
        return GestureDetector(
          onTap: () { if(!disabled){ _bloc.dispatch(CheckoutNext(stepIndex: state.stepIndex, hour: state.hour, minute: state.minute,)); } },
          child: Container(
            height: ScreenUtil.getInstance().setHeight(186),
            width: ScreenUtil.getInstance().setWidth(1125),
            alignment: Alignment(0, 0),
            color: buttonColor,
            child: Text(
              buttonText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: AppConfig.defaultFontFamily,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}
