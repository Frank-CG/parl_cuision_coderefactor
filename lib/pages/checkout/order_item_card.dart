import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parl_cuision_coderefactor/app_conifg.dart';
import 'package:parl_cuision_coderefactor/blocs/blocs.dart';
import 'package:parl_cuision_coderefactor/models/models.dart';

class OrderItemCard extends StatefulWidget {
  OrderItemCard({Key key, @required this.orderItem}) : super(key: key);

  final OrderItem orderItem;

  @override
  _OrderItemCardState createState() => _OrderItemCardState();
}

class _OrderItemCardState extends State<OrderItemCard> {
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

    double thumbnailContainerWidth = isLandscape ? _basicWidth * 12.0 : _basicWidth * 22.0;
    double centerContainerWidth = isLandscape ? _basicWidth * 40.0 : _basicWidth * 50.0;
    double priceContainerWidth = _basicWidth * 10.0;

    return Card(
        child: Row(
          children: <Widget>[
            Container(
              width: thumbnailContainerWidth,
              child: getNetworkImage(widget.orderItem.item.thumbnailUrl),
            ),
            Container(
              width: centerContainerWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                      left: _basicWidth * 5.0,
                    ),
                    child: Text(
                      widget.orderItem.item.itemName,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: _basicWidth * 4.0,
                    ),
                    child: BlocBuilder(
                      bloc: orderBloc,
                      builder: (BuildContext context, OrderState state) {
                        return Row(
                          children: <Widget>[
                            Container(
                              child: ButtonTheme(
                                minWidth: _basicWidth * 2.5,
                                height: 30,
                                child: RaisedButton(
                                  color: Colors.green,
                                  textColor: Colors.white,
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(30.0)),
                                  child: Text("-"),
                                  onPressed: () {
                                    orderBloc.dispatch(ItemSubEvent(orderItem: widget.orderItem));
                                  },
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                left: _basicWidth,
                                right: _basicWidth,
                              ),
                              child: Text(widget.orderItem.itemCount.toString()),
                            ),
                            Container(
                              child: ButtonTheme(
                                minWidth: _basicWidth * 2.5,
                                height: 30,
                                child: RaisedButton(
                                  color: Colors.green,
                                  textColor: Colors.white,
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(30.0)),
                                  child: Text("+"),
                                  onPressed: () {
                                    orderBloc.dispatch(ItemAddEvent(orderItem: widget.orderItem));
                                  },
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: priceContainerWidth,
              child: BlocBuilder(
                bloc: orderBloc,
                builder: (BuildContext context, OrderState state) {
                  if(state is OrderInited){
                    return Text("\$" + (widget.orderItem.item.unitPrice * widget.orderItem.itemCount).toString());
                  }
                },
              ),
            ),
          ],
        ),
      );
  }

  Widget getNetworkImage(String thumbnailUrl) {
    if (thumbnailUrl == "") {
      thumbnailUrl = "assets/images/food1.png";
    }
    return Image.asset(thumbnailUrl);
  }
}
