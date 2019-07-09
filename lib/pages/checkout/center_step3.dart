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
  bool isLargeScreen;
  bool isLandscape;
  double _fontSizeAdjustment;
  double _basicWidth;
  double _basicHeigth;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<CheckoutBloc>(context);
    
  }

  @override
  Widget build(BuildContext context) {
    final orderBloc = BlocProvider.of<OrderBloc>(context);
    isLargeScreen =
        AppConfig.instance.deviceType == DeviceType.Tablets ? true : false;
    isLandscape = AppConfig.instance.orientation == Orientation.landscape
        ? isLargeScreen ? false : true
        : false;
    _fontSizeAdjustment =
        AppConfig.instance.deviceType == DeviceType.Tablets ? 8.0 : 0.0;
    _basicWidth = AppConfig.instance.blockWidth;
    _basicHeigth = AppConfig.instance.blockHeight;

    final listHeader = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: _basicWidth * 28.0,
            child: Text(
              "ITEMS",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 16.0 + _fontSizeAdjustment,
                fontFamily: AppConfig.defaultFontFamily,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade400,
              ),
            ),
          ),
          SizedBox(
            width: _basicWidth * 28.0,
            child: Text(
              "QUANTITY",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0 + _fontSizeAdjustment,
                fontFamily: AppConfig.defaultFontFamily,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade400,
              ),
            ),
          ),
          SizedBox(
            width: _basicWidth * 25.0,
            child: Text(
              "PRICE",
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 16.0 + _fontSizeAdjustment,
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

    
    
    double titalContainerHeight = isLandscape ? _basicHeigth * 10.0 : _basicHeigth * 7.5;
    double orderlistContainerHeigth = isLandscape ? _basicHeigth * 70.0 : _basicHeigth * 50.0 - 60.0;
    double commentsContainerHeight = isLandscape ? _basicHeigth * 20.0 : _basicHeigth * 12.0;
    double bottomContainerHeight = _basicHeigth * 5.5;

    double orderlistContainerPadding = isLandscape || isLargeScreen ? _basicWidth * 7.5 : _basicHeigth * 3.5;

    return Column(
      children: <Widget>[
        Container(
          height: titalContainerHeight,
          padding: EdgeInsets.only(
            left: _basicWidth * 5.0,
          ),
          alignment: Alignment.bottomLeft,
          child: Text(
            "Confirm your order",
            style: TextStyle(
              fontSize: 18.0 + _fontSizeAdjustment,
              fontWeight: FontWeight.w800,
              fontFamily: AppConfig.defaultFontFamily,
            ),
          ),
        ),
        Container(
          height: orderlistContainerHeigth,
          padding: EdgeInsets.only(
            left: orderlistContainerPadding,
            right: orderlistContainerPadding,
            bottom: orderlistContainerPadding,
          ),
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 2.0,
            child: BlocBuilder(
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
        Container(
          height: commentsContainerHeight,
          color: Colors.white,
          padding: EdgeInsets.only(
            left: _basicWidth * 5.0,
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: _basicWidth * 7.5,
                child: Image.asset(
                  "assets/images/icon_pickuptime.png",
                ),
              ),
              Container(width: _basicWidth * 4.0,),
              Container(
                width: _basicWidth * 28.0,
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Pickup time",
                      style: TextStyle(
                        fontSize: 14.0 + _fontSizeAdjustment,
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
                            fontSize: 20.0 + _fontSizeAdjustment,
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
                  height: _basicHeigth * 20.0,
                  width: 1,
                  color: Colors.grey.shade300,
                ),
              ),
              Container(
                width: _basicWidth * 7.5,
                child: Image.asset(
                  "assets/images/icon_total.png",
                ),
              ),
              Container(width: _basicWidth * 4.0,),
              Container(
                width: _basicWidth * 28.0,
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Total",
                      style: TextStyle(
                        fontSize: 14.0 + _fontSizeAdjustment,
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
                              fontSize: 20.0 + _fontSizeAdjustment,
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
          height: bottomContainerHeight,
          child: Align(
            alignment: Alignment(0, 0),
            child: Text(
              "ADD ORDER COMMENTS",
              style: TextStyle(
                fontSize: 12 + _fontSizeAdjustment / 2,
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
            width: _basicWidth * 28.0,
            child: Text(
              orderItem.item.itemName,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 14.0 + _fontSizeAdjustment,
                fontFamily: AppConfig.defaultFontFamily,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            width: _basicWidth * 28.0,
            child: Text(
              orderItem.itemCount.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.0 + _fontSizeAdjustment,
                fontFamily: AppConfig.defaultFontFamily,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            width: _basicWidth * 25.0,
            child: Text(
              (orderItem.itemCount * orderItem.item.unitPrice)
                  .toStringAsFixed(2),
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 14.0 + _fontSizeAdjustment,
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
