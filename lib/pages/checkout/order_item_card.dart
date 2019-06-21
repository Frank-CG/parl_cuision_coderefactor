import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parl_cuision_coderefactor/blocs/blocs.dart';
import 'package:parl_cuision_coderefactor/models/models.dart';

class OrderItemCard extends StatefulWidget {
  OrderItemCard({Key key, @required this.orderItem}) : super(key: key);

  final OrderItem orderItem;

  @override
  _OrderItemCardState createState() => _OrderItemCardState();
}

class _OrderItemCardState extends State<OrderItemCard> {
  @override
  Widget build(BuildContext context) {
    final orderBloc = BlocProvider.of<OrderBloc>(context);

    return Container(
      margin: EdgeInsets.fromLTRB(ScreenUtil.getInstance().setWidth(63), 0,
          ScreenUtil.getInstance().setWidth(63), 0),
      width: ScreenUtil.getInstance().setWidth(1500),
      child: Card(
        child: Row(
          children: <Widget>[
            Container(
              width: ScreenUtil.getInstance().setWidth(282),
              child: getNetworkImage(widget.orderItem.item.thumbnailUrl),
            ),
            Container(
              width: ScreenUtil.getInstance().setWidth(550),
              color: Colors.white,
              alignment: Alignment.topLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                      left: ScreenUtil.getInstance().setWidth(60),
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
                      left: ScreenUtil.getInstance().setWidth(30),
                    ),
                    child: BlocBuilder(
                      bloc: orderBloc,
                      builder: (BuildContext context, OrderState state) {
                        return Row(
                          children: <Widget>[
                            Container(
                              child: ButtonTheme(
                                minWidth: ScreenUtil.getInstance().setWidth(30),
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
                                left: ScreenUtil.getInstance().setWidth(20),
                                right: ScreenUtil.getInstance().setWidth(20),
                              ),
                              child: Text(widget.orderItem.itemCount.toString()),
                            ),
                            Container(
                              child: ButtonTheme(
                                minWidth: ScreenUtil.getInstance().setWidth(30),
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
              width: ScreenUtil.getInstance().setWidth(130),
              // color: Colors.yellow,
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
