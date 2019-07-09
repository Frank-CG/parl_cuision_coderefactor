import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:parl_cuision_coderefactor/app_conifg.dart';

/**
 * Navigation Bloc : State definition.
 */
enum PageName {
  Menu,
  Reservation,
  Information,
  Cart,
  Profile,
  Undefined,
}

class NavState extends Equatable {
  final PageName previousPageName;
  final PageName pageName;

  NavState({@required this.pageName, @required this.previousPageName}) : super([pageName, previousPageName]);

  List<BottomNavigationBarItem> get pageNavBarItem {
    List<String> iconsPath = <String>[
      'assets/images/icon_menu.png',
      'assets/images/icon_reservation.png',
      'assets/images/icon_info.png',
      'assets/images/icon_cart.png',
    ];
    Color iconColor;
    List<BottomNavigationBarItem> barItems = <BottomNavigationBarItem>[];
    Widget barIcon;
    for (int i = 0; i < iconsPath.length; i++) {
      if (pageName.index == i) {
        iconColor = Colors.green;
      } else {
        iconColor = Colors.black;
      }

      barIcon = SizedBox(
        child: Image.asset(iconsPath[i], color: iconColor, ),
        width: AppConfig.instance.blockWidth * 4.5,
        height: AppConfig.instance.blockHeight * 4.5,
      );

      barItems.add(BottomNavigationBarItem(
        icon: barIcon,
        title: Text(PageName.values[i].toString()),
      ));
      // icons.add(Image.asset(iconsPath[i], color: iconColor,));
    }
    return barItems;
  }
}

/**
 * Navigation Bloc : Event definition.
 */
@immutable
abstract class NavEvent extends Equatable {
  NavEvent([List props = const []]) : super(props);
}

class NavTo extends NavEvent {
  final PageName previousPageName;
  final PageName pageName;

  NavTo({@required this.pageName, @required this.previousPageName});
}

/**
 * Navigation Bloc : mapEventToState
 */
class NavBloc extends Bloc<NavEvent, NavState> {
  @override
  NavState get initialState => NavState(pageName: PageName.Menu, previousPageName: PageName.Menu);

  @override
  Stream<NavState> mapEventToState(
    NavEvent event,
  ) async* {
    if(event is NavTo){
      yield NavState(pageName: event.pageName, previousPageName: event.previousPageName);
    }
  }
}
