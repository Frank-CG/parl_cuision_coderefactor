import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parl_cuision_coderefactor/app_conifg.dart';
import 'package:parl_cuision_coderefactor/blocs/blocs.dart';
import 'package:parl_cuision_coderefactor/models/enums.dart';
import 'package:parl_cuision_coderefactor/pages/checkout/order_item_card.dart';

class CenterStep1 extends StatefulWidget {
  CenterStep1({Key key}) : super(key: key);

  _CenterStep1State createState() => _CenterStep1State();
}

class _CenterStep1State extends State<CenterStep1> {
  bool isLargeScreen;
  bool isLandscape;
  double _fontSizeAdjustment;
  double _basicWidth;
  double _basicHeigth;

  @override
  Widget build(BuildContext context) {
    final orderBloc = BlocProvider.of<OrderBloc>(context);
    isLargeScreen =
        AppConfig.instance.deviceType == DeviceType.Tablets ? true : false;
    isLandscape =
        AppConfig.instance.orientation == Orientation.landscape ? true : false;
    _fontSizeAdjustment =
        AppConfig.instance.deviceType == DeviceType.Tablets ? 8.0 : 0.0;
    _basicWidth = AppConfig.instance.blockWidth;
    _basicHeigth = AppConfig.instance.blockHeight;

    double titalContainerHeight =
        isLandscape && !isLargeScreen ? _basicHeigth * 10.0 : _basicHeigth * 8.0;

    double itemlistContainerWidth =
        isLandscape && !isLargeScreen ? _basicWidth * 75.0 : _basicWidth * 100.0;
    double itemlistContainerHeight =
        isLandscape && !isLargeScreen ? _basicHeigth * 50.0 : _basicHeigth * 50.0 - 60.0;

    double spaceContainerHeight = _basicHeigth * 5.0;

    double bottomContainerHeight =
        isLandscape && !isLargeScreen ? _basicHeigth * 20.0 : _basicHeigth * 12.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: titalContainerHeight,
          padding: EdgeInsets.only(
            left: _basicWidth * 5.0,
          ),
          alignment: Alignment.bottomLeft,
          child: Text(
            "Review items below",
            style: TextStyle(
              fontSize: 18.0 + _fontSizeAdjustment,
              fontWeight: FontWeight.w800,
              fontFamily: AppConfig.defaultFontFamily,
            ),
          ),
        ),
        Container(
          height: itemlistContainerHeight,
          width: itemlistContainerWidth,
          padding: EdgeInsets.only(
            left: _basicWidth * 5.0,
            right: _basicWidth * 5.0,
          ),
          child: BlocBuilder(
            bloc: orderBloc,
            builder: (BuildContext context, OrderState state) {
              if (state is OrderInited) {
                return ListView.builder(
                  shrinkWrap: true,
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
        Container(
          height: spaceContainerHeight,
        ),
        Container(
          // height: ScreenUtil.getInstance().setHeight(320),
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
                  "assets/images/icon_total.png",
                ),
              ),
              Container(
                width: 20.0,
              ),
              Container(
                width: _basicWidth * 50.0,
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Total",
                      style: TextStyle(
                        fontSize: 24.0 + _fontSizeAdjustment,
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
                              fontSize: 16.0 + _fontSizeAdjustment,
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
                width: _basicWidth * 30.0,
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
