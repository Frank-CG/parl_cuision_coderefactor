import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parl_cuision_coderefactor/app_conifg.dart';
import 'package:parl_cuision_coderefactor/blocs/blocs.dart';
import 'package:parl_cuision_coderefactor/models/models.dart';
import 'package:parl_cuision_coderefactor/pages/menu/menu_item_card.dart';

class MenuPage extends StatefulWidget {
  MenuPage({Key key}) : super(key: key);

  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  bool _filterItem1 = true;
  bool _filterItem2 = true;
  bool _filterItem3 = true;

  void _filterItem1Changed(bool v) => setState(() => _filterItem1 = v);
  void _filterItem2Changed(bool v) => setState(() => _filterItem2 = v);
  void _filterItem3Changed(bool v) => setState(() => _filterItem3 = v);

  @override
  void initState() {
    super.initState();
    final menuBloc = BlocProvider.of<MenuBloc>(context);
    menuBloc.dispatch(FetchMenu());
  }

  @override
  Widget build(BuildContext context) {
    final menuBloc = BlocProvider.of<MenuBloc>(context);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: [
              Container(
                height: ScreenUtil.getInstance().setHeight(330),
                padding: EdgeInsets.only(
                  left: ScreenUtil.getInstance().setWidth(63),
                  top: ScreenUtil.getInstance().setHeight(150),
                ),
                alignment: Alignment.topLeft,
                color: Colors.white,
                child: Text(
                  "Menu",
                  style: TextStyle(
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppConfig.defaultFontFamily,
                  ),
                ),
              ),
              Container(
                height: ScreenUtil.getInstance().setHeight(180),
                padding: EdgeInsets.only(
                  left: ScreenUtil.getInstance().setWidth(63),
                  top: ScreenUtil.getInstance().setHeight(60),
                  bottom: ScreenUtil.getInstance().setHeight(57),
                ),
                alignment: Alignment.topLeft,
                color: Colors.white,
                child: Text(
                  "Filters",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppConfig.defaultFontFamily,
                  ),
                ),
              ),
              Container(
                height: ScreenUtil.getInstance().setHeight(240),
                padding: EdgeInsets.only(
                  left: 12.0,
                  top: 0.0,
                ),
                alignment: Alignment.centerLeft,
                decoration: new BoxDecoration(
                    color: Colors.white,
                    border: new Border(
                        top: BorderSide(
                      color: Colors.grey[200],
                      width: 0.8,
                    ))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => _filterItem1Changed(!_filterItem1),
                      child: Container(
                        padding: EdgeInsets.only(
                          right: 8.0,
                          left: 8.0,
                        ),
                        decoration: new BoxDecoration(
                          border: Border(
                            right: BorderSide(
                              color: Colors.grey[200],
                              width: 0.8,
                            ),
                          ),
                        ),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              height: 80,
                              width: 60,
                            ),
                            Positioned(
                              top: 4.0,
                              right: 0,
                              child: Image.asset(
                                _filterItem1
                                    ? "assets/images/checked.png"
                                    : "assets/images/unchecked.png",
                                height: 13,
                                width: 13,
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                child: Image.asset(
                                  "assets/images/icon_healthy.png",
                                  height: 55.0,
                                  width: 50.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _filterItem2Changed(!_filterItem2),
                      child: Container(
                        padding: EdgeInsets.only(
                          right: 8.0,
                          left: 8.0,
                        ),
                        decoration: new BoxDecoration(
                          border: Border(
                            right: BorderSide(
                              color: Colors.grey[200],
                              width: 0.8,
                            ),
                          ),
                        ),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              height: 80,
                              width: 60,
                            ),
                            Positioned(
                              top: 4.0,
                              right: 0,
                              child: Image.asset(
                                _filterItem2
                                    ? "assets/images/checked.png"
                                    : "assets/images/unchecked.png",
                                height: 13,
                                width: 13,
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                child: Image.asset(
                                  "assets/images/icon_vegetarian.png",
                                  height: 55.0,
                                  width: 75.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _filterItem3Changed(!_filterItem3),
                      child: Container(
                        padding: EdgeInsets.only(
                          right: 8.0,
                          left: 8.0,
                        ),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              height: 80,
                              width: 60,
                            ),
                            Positioned(
                              top: 4.0,
                              right: 0,
                              child: Image.asset(
                                _filterItem3
                                    ? "assets/images/checked.png"
                                    : "assets/images/unchecked.png",
                                height: 13,
                                width: 13,
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                child: Image.asset(
                                  "assets/images/icon_vegan.png",
                                  height: 45.0,
                                  width: 55.0,
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
              Container(
                height: ScreenUtil.getInstance().setHeight(200),
                padding: EdgeInsets.only(
                  top: ScreenUtil.getInstance().setHeight(60),
                  left: ScreenUtil.getInstance().setHeight(60),
                  bottom: ScreenUtil.getInstance().setHeight(60),
                ),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.expand_more),
                    Text(
                      "Appetizers",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: ScreenUtil.getInstance().setHeight(1280),
                child: BlocBuilder(
                  bloc: menuBloc,
                  builder: (_, MenuState mState) {
                    if (mState is Loading || mState is Empty) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (mState is Loaded) {
                      return ListView.builder(
                        itemCount: mState.menu.menuItems.length,
                        itemBuilder: (BuildContext context, int index) {
                          MenuItem mItem = mState.menu.menuItems[index];
                          return MenuItemCard(
                            menuItem: mItem,
                            orderItem: OrderItem(item: mItem, itemCount: 0),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
          Positioned(
            top: ScreenUtil.getInstance().setHeight(180),
            right: 0.0,
            child: Container(
              child: Image.asset(
                "assets/images/menu_plate.png",
              ),
            ),
          ),
          Positioned(
            top: ScreenUtil.getInstance().setHeight(130),
            right: 0.0,
            child: GestureDetector(
              onTap: profileOnTap,
              child: Container(
                child: Image.asset(
                  "assets/images/nav.png",
                  height: ScreenUtil.getInstance().setHeight(176 * 1.2),
                  width: ScreenUtil.getInstance().setWidth(247 * 1.2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void profileOnTap() {
    final _navBloc = BlocProvider.of<NavBloc>(context);
    _navBloc.dispatch(NavTo(pageName: PageName.Profile, previousPageName: _navBloc.currentState.pageName,));
  }
}
