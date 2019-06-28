import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parl_cuision_coderefactor/blocs/blocs.dart';
import 'package:parl_cuision_coderefactor/models/models.dart';

class MenuItemCard extends StatefulWidget {
  MenuItemCard({Key key, @required this.menuItem, @required this.orderItem})
      : super(key: key);

  final MenuItem menuItem;
  final OrderItem orderItem;

  _MenuItemCardState createState() => _MenuItemCardState();
}

class _MenuItemCardState extends State<MenuItemCard> {
  int foodCount = 0;

  @override
  Widget build(BuildContext context) {
    final orderBloc = BlocProvider.of<OrderBloc>(context);

    return Container(
      margin: EdgeInsets.fromLTRB(ScreenUtil.getInstance().setWidth(60), 0,
          ScreenUtil.getInstance().setWidth(60), 0),
      width: ScreenUtil.getInstance().setWidth(999),
      // height: ScreenUtil.getInstance().setHeight(360),
      child: Card(
        child: Row(
          children: <Widget>[
            Container(
              width: ScreenUtil.getInstance().setWidth(280),
              child: getNetworkImage(widget.menuItem.thumbnailUrl),
            ),
            Container(
              width: ScreenUtil.getInstance().setWidth(500),
              color: Colors.white,
              alignment: Alignment.topLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                      left: ScreenUtil.getInstance().setWidth(60),
                    ),
                    child: Text(
                      widget.menuItem.itemName,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: ScreenUtil.getInstance().setWidth(60),
                      top: ScreenUtil.getInstance().setHeight(20),
                    ),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 10.0,
                          ),
                          child: Text(
                              "\$" + (widget.menuItem.unitPrice).toString()),
                        ),
                        getFoodTypeIcon(widget.menuItem.itemType),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: ScreenUtil.getInstance().setWidth(90),
              padding: EdgeInsets.only(
                right: ScreenUtil.getInstance().setWidth(50.0),
              ),
              alignment: Alignment.centerLeft,
              child: Icon(Icons.expand_more),
            ),
            Container(
              width: ScreenUtil.getInstance().setWidth(113),
              height: ScreenUtil.getInstance().setHeight(360),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: Colors.grey.shade400,
                    width: 0.6,
                  ),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        orderBloc.dispatch(
                            ItemAddEvent(orderItem: widget.orderItem));
                      },
                      child: Container(
                        color: Colors.lightGreen[100],
                        width: double.infinity,
                        child: Container(
                          child: Icon(
                            Icons.add,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: BlocBuilder(
                        bloc: orderBloc,
                        builder: (_, OrderState oState) {
                          if (oState is OrderInited) {
                            OrderItem item =
                                oState.order.fetch(widget.orderItem);
                            if (item == null) {
                              item = widget.orderItem;
                            }
                            return Text(
                              item.itemCount.toString(),
                              style:
                                  TextStyle(fontSize: 18, color: Colors.green),
                            );
                          } else {
                            return Text("");
                          }
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        orderBloc.dispatch(
                            ItemSubEvent(orderItem: widget.orderItem));
                      },
                      child: Container(
                        width: double.infinity,
                        color: Colors.lightGreen[100],
                        child: Container(
                          child: Icon(
                            Icons.remove,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        //),
      ),
    );
  }

  Widget getNetworkImage(String thumbnailUrl) {
    if (thumbnailUrl == "") {
      thumbnailUrl = "assets/images/food1.png";
    }
    return Image.asset(thumbnailUrl);
  }

  Widget getFoodTypeIcon(String foodType) {
    return Image.asset(
      "assets/images/icon_" + foodType + ".png",
      width: ScreenUtil.getInstance().setWidth(80),
    );
  }
}
