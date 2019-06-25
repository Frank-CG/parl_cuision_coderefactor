import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parl_cuision_coderefactor/app_conifg.dart';
import 'package:parl_cuision_coderefactor/blocs/blocs.dart';
import 'package:parl_cuision_coderefactor/pages/checkout/checkout.dart';

import 'checkout_dialog.dart';

class CheckoutBottom extends StatefulWidget {
  CheckoutBottom({Key key}) : super(key: key);

  _CheckoutBottomState createState() => _CheckoutBottomState();
}

class _CheckoutBottomState extends State<CheckoutBottom> {
  CheckoutBloc _checkoutBloc;
  OrderBloc _orderBloc;

  @override
  void initState() {
    super.initState();
    _checkoutBloc = BlocProvider.of<CheckoutBloc>(context);
    _orderBloc = BlocProvider.of<OrderBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _checkoutBloc,
      builder: (BuildContext context, CheckoutState state) {
        int orderItemsCount = 0;
        final orderState = _orderBloc.currentState;
        if (orderState is OrderInited) {
          orderItemsCount = orderState.order.itemCount;
        }

        String buttonText = "Next";
        Color buttonColor = Colors.green;
        bool disabled = false;
        if (state.stepIndex == 0 && orderItemsCount == 0) {
          buttonColor = Colors.grey.shade500;
          disabled = true;
        }
        if (state.stepIndex == 1 && state.pickupTime == "Unselected") {
          buttonColor = Colors.grey.shade500;
          disabled = true;
        }
        if (state.stepIndex == 2) {
          buttonText = "Place order";
        }
        return GestureDetector(
          onTap: () {
            if (!disabled) {
              if (state.stepIndex == 2) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => CheckoutDialog(
                        title: "Success!",
                        pickupTime: state.pickupTime,
                        buttonText: "OK",
                        checkoutCallback: () {
                          _orderBloc.dispatch(ItemCleanEvent());
                          NavBloc _navBloc = BlocProvider.of<NavBloc>(context);
                          _navBloc.dispatch(NavTo(pageName: PageName.Menu, previousPageName: PageName.Menu,));
                        },
                      ),
                );
              } else {
                _checkoutBloc.dispatch(CheckoutNext(
                  stepIndex: state.stepIndex,
                  hour: state.hour,
                  minute: state.minute,
                ));
              }
            }
          },
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
