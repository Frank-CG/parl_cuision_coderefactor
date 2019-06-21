import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parl_cuision_coderefactor/app_conifg.dart';
import 'package:parl_cuision_coderefactor/blocs/blocs.dart';
import 'package:parl_cuision_coderefactor/models/models.dart';
import 'package:parl_cuision_coderefactor/pages/checkout/checkout.dart';
import 'package:parl_cuision_coderefactor/pages/checkout/checkout_bloc/checkout_bloc.dart';

class CenterStep3 extends StatefulWidget {
  CenterStep3({Key key}) : super(key: key);

  _CenterStep3State createState() => _CenterStep3State();
}

class _CenterStep3State extends State<CenterStep3> {
  CheckoutBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<CheckoutBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final orderBloc = BlocProvider.of<OrderBloc>(context);

    final listHeader = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: ScreenUtil.getInstance().setWidth(300),
            child: Text(
              "ITEMS",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: AppConfig.defaultFontFamily,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade400,
              ),
            ),
          ),
          SizedBox(
            width: ScreenUtil.getInstance().setWidth(300),
            child: Text(
              "QUANTITY",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: AppConfig.defaultFontFamily,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade400,
              ),
            ),
          ),
          SizedBox(
            width: ScreenUtil.getInstance().setWidth(280),
            child: Text(
              "PRICE",
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: AppConfig.defaultFontFamily,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade400,
              ),
            ),
          ),
        ],
      ),
    );
    final listHeaderSpace = Padding(
      padding: const EdgeInsets.only(
        left: 8.0,
        right: 8.0,
      ),
      child: Divider(
        color: Colors.grey.shade400,
        height: 2,
      ),
    );

    return Column(
      children: <Widget>[
        Container(
          height: ScreenUtil.getInstance().setHeight(280),
          padding: EdgeInsets.only(
            left: ScreenUtil.getInstance().setWidth(120),
            top: ScreenUtil.getInstance().setHeight(90),
          ),
          alignment: Alignment.topLeft,
          child: Text(
            "Confirm your order",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w800,
              fontFamily: AppConfig.defaultFontFamily,
            ),
          ),
        ),
        Container(
          height: ScreenUtil.getInstance().setHeight(850),
          padding: EdgeInsets.only(
            left: ScreenUtil.getInstance().setWidth(80),
            right: ScreenUtil.getInstance().setWidth(80),
            bottom: ScreenUtil.getInstance().setWidth(80),
          ),
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 2.0,
            child: Scaffold(
              body: BlocBuilder(
                bloc: orderBloc,
                builder: (BuildContext context, OrderState state) {
                  if (state is OrderInited) {
                    return ListView.builder(
                      itemCount: state.order.itemCount + 2,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0) {
                          return listHeader;
                        }
                        if (index == 1) {
                          return listHeaderSpace;
                        }
                        int itemIndex = index - 2;
                        return _getOrderItem(state.order.orderItems[itemIndex]);
                      },
                    );
                  }
                },
              ),
            ),
          ),
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
                width: ScreenUtil.getInstance().setWidth(100),
                margin: EdgeInsets.only(
                  right: ScreenUtil.getInstance().setWidth(40),
                ),
                child: Image.asset(
                  "assets/images/icon_pickuptime.png",
                  width: ScreenUtil.getInstance().setWidth(100),
                ),
              ),
              Container(
                width: ScreenUtil.getInstance().setWidth(340),
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Pickup time",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontFamily: AppConfig.defaultFontFamily,
                        color: Colors.grey,
                      ),
                    ),
                    BlocBuilder(
                      bloc: _bloc,
                      builder: (BuildContext context, CheckoutState state) {
                        return Text(
                          state.pickupTime,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: AppConfig.defaultFontFamily,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: ScreenUtil.getInstance().setHeight(320),
                  width: 1,
                  color: Colors.grey.shade300,
                ),
              ),
              Container(
                width: ScreenUtil.getInstance().setWidth(100),
                margin: EdgeInsets.only(
                  right: ScreenUtil.getInstance().setWidth(40),
                ),
                child: Image.asset(
                  "assets/images/icon_total.png",
                  width: ScreenUtil.getInstance().setWidth(100),
                ),
              ),
              Container(
                width: ScreenUtil.getInstance().setWidth(340),
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Total",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontFamily: AppConfig.defaultFontFamily,
                        color: Colors.grey,
                      ),
                    ),
                    BlocBuilder(
                      bloc: orderBloc,
                      builder: (BuildContext context, OrderState state) {
                        if (state is OrderInited) {
                          return Text(
                            "\$" + state.order.totalPrice.toStringAsFixed(2),
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: AppConfig.defaultFontFamily,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          height: ScreenUtil.getInstance().setHeight(150),
          child: Align(
            alignment: Alignment(0, 0),
            child: Text(
              "ADD ORDER COMMENTS",
              style: TextStyle(
                fontSize: 12,
                fontFamily: AppConfig.defaultFontFamily,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _getOrderItem(OrderItem orderItem) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: ScreenUtil.getInstance().setWidth(300),
            child: Text(
              orderItem.item.itemName,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 14.0,
                fontFamily: AppConfig.defaultFontFamily,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            width: ScreenUtil.getInstance().setWidth(300),
            child: Text(
              orderItem.itemCount.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.0,
                fontFamily: AppConfig.defaultFontFamily,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            width: ScreenUtil.getInstance().setWidth(280),
            child: Text(
              (orderItem.itemCount * orderItem.item.unitPrice)
                  .toStringAsFixed(2),
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 14.0,
                fontFamily: AppConfig.defaultFontFamily,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
