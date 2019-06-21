import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parl_cuision_coderefactor/app_conifg.dart';
import 'package:parl_cuision_coderefactor/blocs/blocs.dart';
import 'package:parl_cuision_coderefactor/pages/checkout/order_item_card.dart';

class CenterStep1 extends StatefulWidget {
  CenterStep1({Key key}) : super(key: key);

  _CenterStep1State createState() => _CenterStep1State();
}

class _CenterStep1State extends State<CenterStep1> {
  @override
  Widget build(BuildContext context) {
    final orderBloc = BlocProvider.of<OrderBloc>(context);

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
            "Review items below",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w800,
              fontFamily: AppConfig.defaultFontFamily,
            ),
          ),
        ),
        Container(
          height: ScreenUtil.getInstance().setHeight(1000),
          child: Scaffold(
            body: BlocBuilder(
              bloc: orderBloc,
              builder: (BuildContext context, OrderState state) {
                if (state is OrderInited) {
                  return ListView.builder(
                    itemCount: state.order.itemCount,
                    itemBuilder: (BuildContext context, int index) {
                      return OrderItemCard(
                        orderItem: state.order.orderItems[index],
                      );
                    },
                  );
                }
              },
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
                width: ScreenUtil.getInstance().setWidth(125),
                margin: EdgeInsets.only(
                  right: ScreenUtil.getInstance().setWidth(40),
                ),
                child: Image.asset(
                  "assets/images/icon_total.png",
                  width: ScreenUtil.getInstance().setWidth(120),
                ),
              ),
              Container(
                width: ScreenUtil.getInstance().setWidth(520),
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Total",
                      style: TextStyle(
                        fontSize: 24.0,
                        fontFamily: AppConfig.defaultFontFamily,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    BlocBuilder(
                      bloc: orderBloc,
                      builder: (BuildContext context, OrderState state) {
                        if (state is OrderInited) {
                          return Text(
                            state.order.itemCount.toString() + " items",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: AppConfig.defaultFontFamily,
                              color: Colors.grey.shade400,
                            ),
                          );
                        }
                        return Container();
                      },
                    )
                  ],
                ),
              ),
              Container(
                width: ScreenUtil.getInstance().setWidth(300),
                child: BlocBuilder(
                  bloc: orderBloc,
                  builder: (BuildContext context, OrderState state) {
                    if (state is OrderInited) {
                      return Text(
                        "\$" + state.order.totalPrice.toStringAsFixed(2),
                        style: TextStyle(
                            fontSize: 28.0,
                            fontFamily: AppConfig.defaultFontFamily,
                            fontWeight: FontWeight.bold),
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
