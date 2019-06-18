import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parl_cuision_coderefactor/app_conifg.dart';
import 'package:parl_cuision_coderefactor/pages/menu/menu_page.dart';
import 'package:parl_cuision_coderefactor/pages/pages.dart';


class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  int _previousIndex = 0;

  void _navToPage(RouteName rn) {
    setState(() {
      _currentIndex = rn.index;
    });
  }

  @override
  Widget build(BuildContext context) {

    final List<Widget> _children = [
      // PlaceholderWidget(Colors.green),
      MenuPage(callback: _navToPage),
      PlaceholderWidget(Colors.yellow),
      PlaceholderWidget(Colors.blue),
      PlaceholderWidget(Colors.lime),
      PlaceholderWidget(Colors.orange),
    ];

    Color selectedColor = Colors.green;
    Color unselectedColor = Colors.black;

    List<BottomNavigationBarItem> barItems = <BottomNavigationBarItem>[];
    List<String> barItemsTitle = <String>["Menu", "Resv", "Info", "Cart"];
    List<String> barItemsIcon = <String>[
      'assets/images/icon_menu.png',
      'assets/images/icon_reservation.png',
      'assets/images/icon_info.png',
      'assets/images/icon_cart.png',
    ];
    
    Color itemColor = unselectedColor;
    for(int i=0; i<barItemsIcon.length; i++){
      if (i == _currentIndex) {
        itemColor = selectedColor;
      } else {
        itemColor = unselectedColor;
      }
      var itemIcon = getImageIconBox(barItemsIcon[i], itemColor);
      barItems.add(BottomNavigationBarItem(
          icon: itemIcon,
          title: Text(barItemsTitle[i])));
    }
    var bottomBar = BottomNavigationBar(
            onTap: onTabTapped,
            currentIndex: _currentIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: barItems,
          );

    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: _currentIndex == 4 ? null : Container(
        height: ScreenUtil.getInstance().setHeight(200),
        child: bottomBar,
      ),
    );
  }

  void onTabTapped(int index) {
    if(_currentIndex != index){
      _previousIndex = _currentIndex;
      setState(() {
        _currentIndex = index;
      });
    }
  }

  Widget getImageIconBox(String path, Color cl) {
    return SizedBox(
      child: Image.asset(path, color: cl,),
      width: ScreenUtil.getInstance().setHeight(66),
      height: ScreenUtil.getInstance().setHeight(86),
    );
  }
}