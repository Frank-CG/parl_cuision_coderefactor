import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parl_cuision_coderefactor/app_conifg.dart';
import 'package:parl_cuision_coderefactor/blocs/blocs.dart';
import 'package:parl_cuision_coderefactor/pages/checkout/checkout_page.dart';
import 'package:parl_cuision_coderefactor/pages/information/information_page.dart';
import 'package:parl_cuision_coderefactor/pages/pages.dart';
import 'package:parl_cuision_coderefactor/pages/reservation/reservation_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NavBloc _navBloc;

  @override
  void initState() {
    super.initState();
    _navBloc = BlocProvider.of<NavBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        return BlocBuilder(
          bloc: _navBloc,
          builder: (BuildContext context, NavState state) {
            Widget _bodyWidget;
            switch (state.pageName) {
              case PageName.Menu:
                _bodyWidget =
                    AppConfig.instance.orientation == Orientation.portrait
                        ? MenuPagePortrait()
                        : MenuPageLandscape();
                break;
              case PageName.Reservation:
                _bodyWidget = ReservationPage();
                break;
              case PageName.Information:
                _bodyWidget = InfoPage();
                break;
              case PageName.Cart:
                _bodyWidget = CheckoutPage();
                break;
              case PageName.Profile:
                _bodyWidget = ProfilePage();
                break;
              default:
                _bodyWidget = null;
                break;
            }

            // Widget _bodyWidget = OrientationBuilder(
            //   builder: (context, orientation) {
            //     return _bodyWidgetTemp;
            //   },
            // );

            final _barItems = state.pageNavBarItem;
            final _bottomBarWidget = state.pageName.index == 3
                ? null
                : BottomNavigationBar(
                    onTap: (int index) {
                      _navBloc.dispatch(NavTo(
                          pageName: PageName.values[index],
                          previousPageName: state.pageName));
                    },
                    // currentIndex: state.pageName.index,
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    items: _barItems,
                  );

            return Scaffold(
              body: _bodyWidget,
              bottomNavigationBar: _bottomBarWidget,
            );
          },
        );
      },
    );
  }
}
