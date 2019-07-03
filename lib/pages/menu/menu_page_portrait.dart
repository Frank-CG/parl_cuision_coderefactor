import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parl_cuision_coderefactor/app_conifg.dart';
import 'package:parl_cuision_coderefactor/blocs/blocs.dart';
import 'package:parl_cuision_coderefactor/models/models.dart';
import 'package:parl_cuision_coderefactor/pages/menu/menu_item_card.dart';

class MenuPagePortrait extends StatefulWidget {
  MenuPagePortrait({Key key}) : super(key: key);

  _MenuPagePortraitState createState() => _MenuPagePortraitState();
}

class _MenuPagePortraitState extends State<MenuPagePortrait> {
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
      body: Stack(
        children: <Widget>[
          Column(
            children: [
              Container(  ///[Menu text Container]
                height: AppConfig.instance.blockHeight * 11.0,
                padding: EdgeInsets.only(
                  left: AppConfig.instance.blockWidth * 5.0,
                ),
                alignment: Alignment.bottomLeft,
                color: Colors.white,
                child: Text(
                  "Menu",
                  style: TextStyle(
                    fontSize: 36.0 + _fontSizeAdjustment,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppConfig.defaultFontFamily,
                  ),
                ),
              ),
              Container(  ///[Filters text Container]
                height: AppConfig.instance.blockHeight * 7.2,
                padding: EdgeInsets.only(
                  left: AppConfig.instance.blockWidth * 5.0,
                ),
                alignment: Alignment.bottomLeft,
                color: Colors.white,
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
                height: AppConfig.instance.blockHeight * 11.8,
                alignment: Alignment.bottomLeft,
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
                      onTap: () => _filterChanged(MenuFilters.Healthy),
                      child: Container(
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
                              width: AppConfig.instance.blockWidth * 20,
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                MenuFilters.Healthy.toString().split('.')[1],
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: AppConfig.defaultFontFamily,
                                ),
                              ),
                            ),
                            Positioned(
                              top: AppConfig.instance.blockHeight * 0.8,
                              right: AppConfig.instance.blockWidth * 1.0,
                              child: Image.asset(
                                _filters[MenuFilters.Healthy.index]
                                    ? "assets/images/checked.png"
                                    : "assets/images/unchecked.png",
                                height: AppConfig.instance.blockWidth * 3.6,
                                width: AppConfig.instance.blockWidth * 3.6,
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                // height: AppConfig.instance.blockHeight * 8.0,
                                width: AppConfig.instance.blockWidth * 14.4,
                                padding: EdgeInsets.only(
                                  left: AppConfig.instance.blockWidth * 4.4,
                                ),
                                child: Image.asset(
                                  "assets/images/icon_healthy.png",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _filterChanged(MenuFilters.Vegetarian),
                      child: Container(
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
                              width: AppConfig.instance.blockWidth * 20,
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                MenuFilters.Vegetarian.toString().split('.')[1],
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: AppConfig.defaultFontFamily,
                                ),
                              ),
                            ),
                            Positioned(
                              top: AppConfig.instance.blockHeight * 0.8,
                              right: AppConfig.instance.blockWidth * 1.0,
                              child: Image.asset(
                                _filters[MenuFilters.Vegetarian.index]
                                    ? "assets/images/checked.png"
                                    : "assets/images/unchecked.png",
                                height: AppConfig.instance.blockWidth * 3.6,
                                width: AppConfig.instance.blockWidth * 3.6,
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                // height: AppConfig.instance.blockHeight * 8.0,
                                width: AppConfig.instance.blockWidth * 14.4,
                                padding: EdgeInsets.only(
                                  left: AppConfig.instance.blockWidth * 4.4,
                                ),
                                child: Image.asset(
                                  "assets/images/icon_vegetarian.png",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _filterChanged(MenuFilters.Vegan),
                      child: Container(
                        child: Stack(
                          children: <Widget>[
                            Container(
                              width: AppConfig.instance.blockWidth * 20,
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                MenuFilters.Vegan.toString().split('.')[1],
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: AppConfig.defaultFontFamily,
                                ),
                              ),
                            ),
                            Positioned(
                              top: AppConfig.instance.blockHeight * 0.8,
                              right: AppConfig.instance.blockWidth * 1.0,
                              child: Image.asset(
                                _filters[MenuFilters.Vegan.index]
                                    ? "assets/images/checked.png"
                                    : "assets/images/unchecked.png",
                                height: AppConfig.instance.blockWidth * 3.6,
                                width: AppConfig.instance.blockWidth * 3.6,
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                // height: AppConfig.instance.blockHeight * 8.0,
                                width: AppConfig.instance.blockWidth * 14.4,
                                padding: EdgeInsets.only(
                                  left: AppConfig.instance.blockWidth * 4.4,
                                ),
                                child: Image.asset(
                                  "assets/images/icon_vegan.png",
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
              Container(  ///[Appetizers text Container]
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
                        fontSize: 24.0 + _fontSizeAdjustment,
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
              ),
            ],
          ),
          Positioned(
            top: AppConfig.instance.blockHeight * 8.0,
            right: 0.0,
            child: Container(
              child: Image.asset(
                "assets/images/menu_plate.png",
                height: AppConfig.instance.blockHeight * 30.0,
              ),
            ),
          ),
          Positioned(
            top: AppConfig.instance.blockHeight * 5.0,
            right: AppConfig.instance.blockWidth * 5.0,
            child: GestureDetector(
              onTap: profileOnTap,
              child: Container(
                child: Image.asset(
                  "assets/images/nav.png",
                  height: AppConfig.instance.blockHeight * 10.0,
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
    _navBloc.dispatch(NavTo(
      pageName: PageName.Profile,
      previousPageName: _navBloc.currentState.pageName,
    ));
  }
}
