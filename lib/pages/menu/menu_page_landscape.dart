import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parl_cuision_coderefactor/app_conifg.dart';
import 'package:parl_cuision_coderefactor/blocs/blocs.dart';
import 'package:parl_cuision_coderefactor/models/models.dart';
import 'package:parl_cuision_coderefactor/pages/menu/menu_item_card.dart';

class MenuPageLandscape extends StatefulWidget {
  MenuPageLandscape({Key key}) : super(key: key);

  _MenuPageLandscapeState createState() => _MenuPageLandscapeState();
}

class _MenuPageLandscapeState extends State<MenuPageLandscape> {
  MenuBloc menuBloc;

  List<bool> _filters = <bool>[true, true, true];
  void _filterChanged(MenuFilters filter) {
    int index = filter.index;
    setState(() {
      _filters[index] = !_filters[index];
    });
    menuBloc.dispatch(MenuFilterChange(
      isHealthy: _filters[0],
      isVegetarian: _filters[1],
      isVegan: _filters[2],
    ));
  }

  @override
  void initState() {
    super.initState();
    menuBloc = BlocProvider.of<MenuBloc>(context);
    menuBloc.dispatch(FetchMenu());
  }

  @override
  Widget build(BuildContext context) {
    final menuBloc = BlocProvider.of<MenuBloc>(context);
    double _fontSizeAdjustment = 0.0;
    if(AppConfig.instance.deviceType == DeviceType.Tablets){
      _fontSizeAdjustment = 12.0;
    }

    return Scaffold(
      body: Row(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Positioned(
                top: 0.0,
                child: Container(
                  color: Colors.white,
                  child: Image.asset(
                    "assets/images/menu_plate_top.png",
                    height: AppConfig.instance.blockHeight * 30.0,
                    width: AppConfig.instance.blockWidth * 40,
                  ),
                ),
              ),
              
              Container(
                width: AppConfig.instance.blockWidth * 40,
                height: AppConfig.instance.blockHeight * 100,
                child: Column(
                  children: [
                    Container(
                      ///[Menu text Container]
                      height: AppConfig.instance.blockHeight * 30.0,
                      alignment: Alignment.bottomLeft,
                      color: Colors.transparent,
                      padding: EdgeInsets.only(
                          left: AppConfig.instance.blockWidth * 3.0),
                      child: Text(
                        "Menu",
                        style: TextStyle(
                          fontSize: 36.0 + _fontSizeAdjustment,
                          fontWeight: FontWeight.w800,
                          fontFamily: AppConfig.defaultFontFamily,
                        ),
                      ),
                    ),
                    Container(
                      ///[Filters text Container]
                      height: AppConfig.instance.blockHeight * 8,
                      alignment: Alignment.bottomLeft,
                      color: Colors.transparent,
                      padding: EdgeInsets.only(
                          left: AppConfig.instance.blockWidth * 3.0),
                      child: Text(
                        "Filters",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 18.0 + _fontSizeAdjustment,
                          fontWeight: FontWeight.w600,
                          fontFamily: AppConfig.defaultFontFamily,
                        ),
                      ),
                    ),
                    Container(  ///[Filter items Container]
                      height: AppConfig.instance.blockHeight * 45,
                      padding: EdgeInsets.only(
                          left: AppConfig.instance.blockWidth * 3),
                      color: Colors.transparent,
                      child: ListView(
                        children: <Widget>[
                          Card(
                            child: Container(
                              height: AppConfig.instance.blockHeight * 14,
                              alignment: Alignment.center,
                              child: ListTile(
                                onTap: () => _filterChanged(MenuFilters.Healthy),
                                leading: Image.asset(
                                  "assets/images/icon_healthy.png",
                                  height: AppConfig.instance.blockHeight * 8,
                                ),
                                title: Text(
                                  MenuFilters.Healthy.toString().split('.')[1],
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 18.0 + _fontSizeAdjustment/2,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: AppConfig.defaultFontFamily,
                                  ),
                                ),
                                trailing: Image.asset(
                                  _filters[MenuFilters.Healthy.index]
                                      ? "assets/images/checked.png"
                                      : "assets/images/unchecked.png",
                                  height: AppConfig.instance.blockWidth * 3.6,
                                  width: AppConfig.instance.blockWidth * 3.6,
                                ),
                              ),
                            ),
                          ),
                          Card(
                            child: Container(
                              height: AppConfig.instance.blockHeight * 14,
                              alignment: Alignment.center,
                              child: ListTile(
                                onTap: () => _filterChanged(MenuFilters.Vegetarian),
                                leading: Image.asset(
                                  "assets/images/icon_vegetarian.png",
                                  height: AppConfig.instance.blockHeight * 8,
                                ),
                                title: Text(
                                  MenuFilters.Vegetarian.toString().split('.')[1],
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 18.0 + _fontSizeAdjustment/2,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: AppConfig.defaultFontFamily,
                                  ),
                                ),
                                trailing: Image.asset(
                                  _filters[MenuFilters.Vegetarian.index]
                                      ? "assets/images/checked.png"
                                      : "assets/images/unchecked.png",
                                  height: AppConfig.instance.blockWidth * 3.6,
                                  width: AppConfig.instance.blockWidth * 3.6,
                                ),
                              ),
                            ),
                          ),
                          Card(
                            child: Container(
                              height: AppConfig.instance.blockHeight * 14,
                              alignment: Alignment.center,
                              child: ListTile(
                                onTap: () => _filterChanged(MenuFilters.Vegan),
                                leading: Image.asset(
                                  "assets/images/icon_vegan.png",
                                  height: AppConfig.instance.blockHeight * 8,
                                ),
                                title: Text(
                                  MenuFilters.Vegan.toString().split('.')[1],
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 18.0 + _fontSizeAdjustment/2,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: AppConfig.defaultFontFamily,
                                  ),
                                ),
                                trailing: Image.asset(
                                  _filters[MenuFilters.Vegan.index]
                                      ? "assets/images/checked.png"
                                      : "assets/images/unchecked.png",
                                  height: AppConfig.instance.blockWidth * 3.6,
                                  width: AppConfig.instance.blockWidth * 3.6,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: AppConfig.instance.blockHeight * 15.0,
                right: 0.0,
                child: GestureDetector(
                  onTap: profileOnTap,
                  child: Container(
                    child: Image.asset(
                      "assets/images/nav.png",
                      height: AppConfig.instance.blockHeight * 15.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: AppConfig.instance.blockWidth * 60,
            child: Column(
              children: <Widget>[
                Container(
                  ///[Appetizers text Container]
                  height: AppConfig.instance.blockHeight * 8.0,
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.only(
                    left: AppConfig.instance.blockWidth * 5.0,
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.expand_more),
                      Text(
                        "Appetizers",
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
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
                              MenuItem mItem0 = mState.menu.menuItems[index];
                              return MenuItemCard(
                                menuItem: mItem0,
                                orderItem:
                                    OrderItem(item: mItem0, itemCount: 0),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void profileOnTap() {
    final _navBloc = BlocProvider.of<NavBloc>(context);
    _navBloc.dispatch(NavTo(
      pageName: PageName.Profile,
      previousPageName: _navBloc.currentState.pageName,
    ));
  }
}
