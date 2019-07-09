import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:parl_cuision_coderefactor/app_conifg.dart';
import 'package:parl_cuision_coderefactor/blocs/blocs.dart';
import 'package:parl_cuision_coderefactor/models/models.dart';

class InfoPage extends StatelessWidget {
  final isLargeScreen =
      AppConfig.instance.deviceType == DeviceType.Tablets ? true : false;
  final isLandscape =
      AppConfig.instance.orientation == Orientation.landscape ? true : false;
  final double _fontSizeAdjustment =
      AppConfig.instance.deviceType == DeviceType.Tablets ? 8.0 : 0.0;
  final double _basicWidth = AppConfig.instance.blockWidth;
  final double _basicHeigth = AppConfig.instance.blockHeight;

  @override
  Widget build(BuildContext context) {
    final _navBloc = BlocProvider.of<NavBloc>(context);
    print("_basicWidth=$_basicWidth, _basicHeigth=$_basicHeigth");

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          infoTop(_navBloc),
          hours(),
          SizedBox(
            height: 40,
          ),
          Divider(
            color: Colors.grey[500],
            height: 2,
          ),
          SizedBox(
            height: 20,
          ),
          payment(),
          SizedBox(
            height: 40,
          ),
          Divider(
            color: Colors.grey[500],
            height: 2,
          ),
          SizedBox(
            height: 20,
          ),
          contact(),
        ],
      ),
    );
  }

  Widget infoTop(NavBloc navBloc) {
    var contentTextStyle = new TextStyle(
      fontSize: 18.0 + _fontSizeAdjustment,
      fontFamily: 'Nunito Sans',
    );

    Widget _descreption = Text(
      "Canadian dining at its finest. Come explore a new, completely renovated dining room with food and drinks.",
      style: contentTextStyle,
    );

    return Container(
      // color: Colors.white,
      padding: EdgeInsets.only(
        left: _basicWidth * 4.0,
        top: _basicHeigth * 5,
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: _basicWidth * 70.0,
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Information",
                  style: TextStyle(
                      fontSize: 48.0 + _fontSizeAdjustment,
                      fontFamily: AppConfig.defaultFontFamily,
                      fontWeight: FontWeight.bold),
                ),
              ),
              GestureDetector(
                onTap: () {
                  navBloc.dispatch(NavTo(
                    pageName: PageName.Profile,
                    previousPageName: navBloc.currentState.pageName,
                  ));
                },
                child: Container(
                  width: _basicWidth * 26.0,
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      "assets/images/nav.png",
                      width: _basicWidth  * (isLandscape ? 12.0 : 20.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                width: _basicWidth * 80.0,
                alignment: Alignment.topLeft,
                child: _descreption,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget hours() {
    var dataFontStyle = new TextStyle(
        fontFamily: AppConfig.defaultFontFamily,
        fontSize: 14.0 + _fontSizeAdjustment,
        fontWeight: FontWeight.w800,
        color: Colors.grey[700]);
    var dataDivider = new Divider(
      color: Colors.grey[300],
      height: 1,
    );
    var blankLine = new SizedBox(
      height: 8.0,
    );
    return Container(
      padding: EdgeInsets.only(
        top: _basicHeigth * 5.0,
        left: _basicWidth * 4.0,
        right: _basicWidth * 4.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.asset(
            "assets/images/icon_hours.png",
            width: 54 + _fontSizeAdjustment * 2,
            height: 55 + _fontSizeAdjustment * 2,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: _basicHeigth * 5.0,
            ),
            child: Text(
              "Hours",
              style: TextStyle(
                fontSize: 24.0 + _fontSizeAdjustment,
                fontFamily: AppConfig.defaultFontFamily,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          blankLine,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                "assets/images/icon_remove_18dp.png",
                color: Colors.green,
              ),
              Text(
                "  DURING SITTING WEEKS",
                style: TextStyle(
                  fontSize: 14.0 + _fontSizeAdjustment,
                  fontFamily: AppConfig.defaultFontFamily,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          blankLine,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: _basicWidth * 30,
                child: Text("Breakfast",
                    style: dataFontStyle, textAlign: TextAlign.start),
              ),
              SizedBox(
                width: _basicWidth * 30,
                child: Text("7am to 9am",
                    style: dataFontStyle, textAlign: TextAlign.start),
              ),
              SizedBox(
                width: _basicWidth * 30,
                child: Text("Tue to Thu",
                    style: dataFontStyle, textAlign: TextAlign.right),
              ),
            ],
          ),
          dataDivider,
          blankLine,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: _basicWidth * 30,
                child: Text("Lunch",
                    style: dataFontStyle, textAlign: TextAlign.start),
              ),
              SizedBox(
                width: _basicWidth * 30,
                child: Text("11am to 1:30pm",
                    style: dataFontStyle, textAlign: TextAlign.start),
              ),
              SizedBox(
                width: _basicWidth * 30,
                child: Text("Mon to Fri",
                    style: dataFontStyle, textAlign: TextAlign.right),
              ),
            ],
          ),
          dataDivider,
          blankLine,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: _basicWidth * 30,
                child: Text(
                  "Bar menu",
                  style: dataFontStyle,
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                width: _basicWidth * 30,
                child: Text("3pm to 5pm",
                    style: dataFontStyle, textAlign: TextAlign.start),
              ),
              SizedBox(
                width: _basicWidth * 30,
                child: Text("Mon to Thu",
                    style: dataFontStyle, textAlign: TextAlign.right),
              ),
            ],
          ),
          dataDivider,
          blankLine,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: _basicWidth * 30,
                child: Text("Dinner",
                    style: dataFontStyle, textAlign: TextAlign.start),
              ),
              SizedBox(
                width: _basicWidth * 30,
                child: Text("5pm to 8pm",
                    style: dataFontStyle, textAlign: TextAlign.start),
              ),
              SizedBox(
                width: _basicWidth * 30,
                child: Text("Mon to Thu",
                    style: dataFontStyle, textAlign: TextAlign.right),
              ),
            ],
          ),
          dataDivider,
          SizedBox(
            height: 40.0,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                "assets/images/icon_remove_18dp.png",
                color: Colors.green,
              ),
              Text(
                "  DURING RECESS WEEKS",
                style: TextStyle(
                  fontSize: 14.0,
                  fontFamily: AppConfig.defaultFontFamily,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          blankLine,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: _basicWidth * 30,
                child: Text("Lunch",
                    style: dataFontStyle, textAlign: TextAlign.start),
              ),
              SizedBox(
                width: _basicWidth * 30,
                child: Text("11am to 1:30pm",
                    style: dataFontStyle, textAlign: TextAlign.start),
              ),
              SizedBox(
                width: _basicWidth * 30,
                child:
                    Text(" ", style: dataFontStyle, textAlign: TextAlign.right),
              ),
            ],
          ),
          dataDivider,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: _basicWidth * 30,
                child:
                    Text(" ", style: dataFontStyle, textAlign: TextAlign.start),
              ),
              SizedBox(
                width: _basicWidth * 50,
                child: Text("*Closed during summer brakes",
                    style: dataFontStyle, textAlign: TextAlign.start),
              ),
              SizedBox(
                width: _basicWidth * 10,
                child:
                    Text(" ", style: dataFontStyle, textAlign: TextAlign.right),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget payment() {
    String title = "Payment";
    String content = "We accept Apple Pay, credit cards, debit cards and cash.";

    var dataFontStyle = new TextStyle(
        fontFamily: AppConfig.defaultFontFamily,
        fontSize: 18.0 + _fontSizeAdjustment,
        fontWeight: FontWeight.w300,
        color: Colors.grey[500]);
    var blankLine = new SizedBox(
      height: 8.0,
    );

    return Container(
      padding: EdgeInsets.only(
        top: _basicHeigth * 5.0,
        left: _basicWidth * 4.0,
        right: _basicWidth * 4.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.asset(
            "assets/images/icon_payment.png",
            width: 54 + _fontSizeAdjustment * 2,
            height: 55 + _fontSizeAdjustment * 2,
          ),
          Padding(
            padding: EdgeInsets.only(top: _basicHeigth * 3.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 24.0 + _fontSizeAdjustment,
                fontFamily: AppConfig.defaultFontFamily,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Text(
            content,
            style: dataFontStyle,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                "assets/images/pay-ApplePay-dark.png",
                width: _basicWidth * 15,
                // height: ScreenUtil.getInstance().setHeight(96),
              ),
              Image.asset(
                "assets/images/pay-Visa-dark.png",
                width: _basicWidth * 15,
                // height: ScreenUtil.getInstance().setHeight(96),
              ),
              Image.asset(
                "assets/images/pay-MasterCard-dark.png",
                width: _basicWidth * 15,
                // height: ScreenUtil.getInstance().setHeight(96),
              ),
              // Image.asset(
              //   "assets/images/pay-debit.png",
              //   width: _basicWidth * 15,
              //   // height: ScreenUtil.getInstance().setHeight(96),
              // ),
              // Image.asset(
              //   "assets/images/pay-cash.png",
              //   width: _basicWidth * 15,
              //   // height: ScreenUtil.getInstance().setHeight(96),
              // ),
            ],
          ),
          blankLine,
        ],
      ),
    );
  }

  Widget contact() {
    String addr1 = "Room 139-N, West Block";
    String phone1 = "613-992-2758";
    String addr2 = "Room 130-A, West Block";
    String phone2 = "613-992-1497";
    String phone3 = "613-992-7407";

    var dataFontStyle = new TextStyle(
        fontFamily: AppConfig.defaultFontFamily,
        fontSize: 14.0 + _fontSizeAdjustment,
        fontWeight: FontWeight.w800,
        color: Colors.grey[500]);
    var dataDivider = new Divider(
      color: Colors.grey[300],
      height: 1,
    );
    return Container(
      padding: EdgeInsets.only(
        top: _basicHeigth * 5.0,
        left: _basicWidth * 4.0,
        right: _basicWidth * 4.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.asset(
            "assets/images/icon_contact.png",
            width: 54 + _fontSizeAdjustment * 2,
            height: 55 + _fontSizeAdjustment * 2,
          ),
          Padding(
            padding: EdgeInsets.only(top: _basicHeigth * 3.0),
            child: Text(
              "Contact",
              style: TextStyle(
                fontSize: 24.0 + _fontSizeAdjustment,
                fontFamily: AppConfig.defaultFontFamily,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          blankLine(1),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                "assets/images/icon_remove_18dp.png",
                color: Colors.green,
              ),
              Text(
                "  PARLIAMENTARY DINING ROOM",
                style: TextStyle(
                  fontSize: 14.0 + _fontSizeAdjustment,
                  fontFamily: AppConfig.defaultFontFamily,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          blankLine(3),
          Text(
            addr1,
            style: dataFontStyle,
          ),
          dataDivider,
          blankLine(1),
          Text(
            "Phone: " + phone1,
            style: dataFontStyle,
          ),
          blankLine(3),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                "assets/images/icon_remove_18dp.png",
                color: Colors.green,
              ),
              Text(
                "  WEST BLOCK CAFETERIA",
                style: TextStyle(
                  fontSize: 14.0 + _fontSizeAdjustment,
                  fontFamily: AppConfig.defaultFontFamily,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          blankLine(3),
          Text(
            addr2,
            style: dataFontStyle,
          ),
          dataDivider,
          blankLine(1),
          Text(
            "Phone: " + phone2,
            style: dataFontStyle,
          ),
          blankLine(3),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                "assets/images/icon_remove_18dp.png",
                color: Colors.green,
              ),
              Text(
                "  CATERING SERVICE",
                style: TextStyle(
                  fontSize: 14.0 + _fontSizeAdjustment,
                  fontFamily: AppConfig.defaultFontFamily,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          blankLine(3),
          Text(
            "Phone: " + phone3,
            style: dataFontStyle,
          ),
          blankLine(24),
        ],
      ),
    );
  }

  SizedBox blankLine(int lines) {
    return SizedBox(
      height: 8.0 * lines,
    );
  }
}
