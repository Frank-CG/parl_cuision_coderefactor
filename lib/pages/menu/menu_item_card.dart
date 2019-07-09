import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parl_cuision_coderefactor/app_conifg.dart';
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
    double _basicWidth = AppConfig.instance.blockWidth;
    double _marginLeft = _basicWidth * 6.0;
    double _marginRight = _basicWidth * 6.0;
    if (AppConfig.instance.deviceType == DeviceType.Tablets) {
      if (AppConfig.instance.orientation == Orientation.landscape) {
        _basicWidth *= 0.6;
        _marginLeft = _basicWidth * 6.0;
        _marginRight = (AppConfig.instance.blockWidth - _basicWidth) * 25.0;
        _basicWidth = _basicWidth - _marginRight/100.0;
      }else{
        _basicWidth *= 0.8;
        _marginRight = (AppConfig.instance.blockWidth - _basicWidth) * 100.0;
      }
    }else{
      if (AppConfig.instance.orientation == Orientation.landscape) {
        _basicWidth *= 0.6;
        _marginLeft = _basicWidth * 6.0;
        _marginRight = (AppConfig.instance.blockWidth - _basicWidth) * 20.0;
        _basicWidth = _basicWidth - _marginRight / 100.0;
      }
    }

    return Container(
      margin: EdgeInsets.fromLTRB(
          _marginLeft, 0, _marginRight, 10),
      width: _basicWidth * 100,
      child: Card(
        child: Row(
          children: <Widget>[
            Container(
              width: _basicWidth * 25.0,
              height: _basicWidth * 25.0,
              child: getNetworkImage(widget.menuItem.thumbnailUrl),
            ),
            Container(
              width: _basicWidth * 44.0,
              color: Colors.white,
              alignment: Alignment.topLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                      left: _basicWidth * 4.0,
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
                      left: _basicWidth * 4.0,
                      top: _basicWidth * 2.0,
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
              width: _basicWidth * 8.0,
              alignment: Alignment.centerLeft,
              child: Icon(Icons.expand_more),
            ),
            Expanded(
              child: Container(
                height: _basicWidth * 25.0,
                alignment: Alignment.centerRight,
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
                                style: TextStyle(
                                    fontSize: 18, color: Colors.green),
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

  Widget getFoodTypeIcon(String foodType) {
    return Image.asset(
      "assets/images/icon_" + foodType + ".png",
      width: AppConfig.instance.blockWidth * 4.0,
    );
  }
}
