import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parl_cuision_coderefactor/app_conifg.dart';
import 'package:parl_cuision_coderefactor/blocs/blocs.dart';
import 'package:parl_cuision_coderefactor/models/enums.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final isLargeScreen =
      AppConfig.instance.deviceType == DeviceType.Tablets ? true : false;
  final isLandscape =
      AppConfig.instance.orientation == Orientation.landscape ? true : false;
  final double _fontSizeAdjustment =
      AppConfig.instance.deviceType == DeviceType.Tablets ? 8.0 : 0.0;
  final double _basicWidth = AppConfig.instance.blockWidth;
  final double _basicHeigth = AppConfig.instance.blockHeight;

  TextStyle _pageTitleStyle;
  TextStyle _tileStyle;
  TextStyle _subtitleStyle;

  bool isPickup = true;
  bool isReservation = true;
  AuthenticationBloc authenticationBloc;

  @override
  void initState() {
    this.authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _pageTitleStyle = TextStyle(
      fontSize: 64.0 + _fontSizeAdjustment,
      fontFamily: AppConfig.defaultFontFamily,
      fontWeight: FontWeight.bold,
    );
    _tileStyle = TextStyle(
      fontSize: 32.0 + _fontSizeAdjustment,
      fontFamily: AppConfig.defaultFontFamily,
      fontWeight: FontWeight.bold,
    );
    _subtitleStyle = TextStyle(
      fontSize: 32.0 + _fontSizeAdjustment,
      fontFamily: AppConfig.defaultFontFamily,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _pageTop(),
          SizedBox(
            height: ScreenUtil.getInstance().setHeight(40),
          ),
          _profileInfo(),
          SizedBox(
            height: ScreenUtil.getInstance().setHeight(40),
          ),
          //_notification(),
        ],
      ),
    );
  }

  Widget _pageTop() {
    return Container(
      padding: EdgeInsets.only(
        left: _basicWidth * 5.0,
        right: _basicWidth * 5.0,
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: _basicWidth * 60.0,
            alignment: Alignment.bottomLeft,
            child: Text(
              "Settings",
              style: _pageTitleStyle,
            ),
          ),
          Container(
            width: _basicWidth * 30.0,
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  "assets/images/nav.png",
                  width: _basicWidth * 12.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileInfo() {
    TextStyle _labelStyle = TextStyle(
      color: Colors.grey,
      fontSize: 12.0 + _fontSizeAdjustment,
      fontFamily: AppConfig.defaultFontFamily,
      fontWeight: FontWeight.bold,
    );
    TextStyle _inputStyle = TextStyle(
      color: Colors.grey,
      fontSize: 14.0 + _fontSizeAdjustment,
      fontFamily: AppConfig.defaultFontFamily,
      fontWeight: FontWeight.bold,
    );
    return Container(
      padding: EdgeInsets.only(
        left: _basicWidth * 5.0,
        right: _basicWidth * 5.0,
      ),
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: _basicWidth * 90,
            child: Text(
              "Profile information",
              style: _tileStyle,
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  width: _basicWidth * 40,
                  child: TextField(
                    style: _inputStyle,
                    controller: _getTextController("Mark"),
                    decoration: InputDecoration(
                      labelText: "FIRST NAME",
                      labelStyle: _labelStyle,
                      isDense: true,
                      contentPadding: EdgeInsets.only(
                        top: 8.0,
                        bottom: 2.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: _basicWidth * 4.0,
                ),
                Container(
                  width: _basicWidth * 40,
                  child: TextField(
                    style: _inputStyle,
                    controller: _getTextController("Smith"),
                    decoration: InputDecoration(
                      labelText: "LAST NAME",
                      labelStyle: _labelStyle,
                      isDense: true,
                      contentPadding: EdgeInsets.only(
                        top: 8.0,
                        bottom: 2.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  width: _basicWidth * 84,
                  child: TextField(
                    style: _inputStyle,
                    controller: _getTextController("msmith@gmail.com"),
                    decoration: InputDecoration(
                      labelText: "EMAIL",
                      labelStyle: _labelStyle,
                      isDense: true,
                      contentPadding: EdgeInsets.only(
                        top: 8.0,
                        bottom: 2.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  width: _basicWidth * 84,
                  child: TextField(
                    style: _inputStyle,
                    controller: _getTextController("514-999-2464"),
                    decoration: InputDecoration(
                      labelText: "PHONE",
                      labelStyle: _labelStyle,
                      isDense: true,
                      contentPadding: EdgeInsets.only(
                        top: 8.0,
                        bottom: 2.0,
                      ),
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

  TextEditingController _getTextController(String defaultText) {
    TextEditingController _textController = new TextEditingController();
    _textController.text = defaultText;
    return _textController;
  }

  Widget _notification() {
    TextStyle _labelStyle = TextStyle(
      color: Colors.grey,
      fontSize: 18.0,
      fontFamily: AppConfig.defaultFontFamily,
      fontWeight: FontWeight.bold,
    );
    return Container(
      height: ScreenUtil.getInstance().setHeight(1100),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Container(
            width: ScreenUtil.getInstance().setWidth(1125),
            padding: EdgeInsets.only(
              top: ScreenUtil.getInstance().setHeight(30),
              left: ScreenUtil.getInstance().setWidth(75),
              right: ScreenUtil.getInstance().setWidth(75),
            ),
            child: Text(
              "Notifications",
              style: _tileStyle,
            ),
          ),
          Container(
            width: ScreenUtil.getInstance().setWidth(1125),
            padding: EdgeInsets.only(
              top: ScreenUtil.getInstance().setHeight(30),
              left: ScreenUtil.getInstance().setWidth(75),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: ScreenUtil.getInstance().setWidth(220),
                  child: Text(
                    "Pickup",
                    style: _labelStyle,
                  ),
                ),
                Container(
                  width: ScreenUtil.getInstance().setWidth(160),
                  child: Switch(
                    value: isPickup,
                    onChanged: (value) {
                      setState(() {
                        isPickup = value;
                      });
                    },
                    activeTrackColor: Colors.green,
                    activeColor: Colors.white,
                  ),
                ),
                SizedBox(
                  width: ScreenUtil.getInstance().setWidth(60),
                ),
                Container(
                  width: ScreenUtil.getInstance().setWidth(280),
                  child: Text(
                    "Reservation",
                    style: _labelStyle,
                  ),
                ),
                Container(
                  width: ScreenUtil.getInstance().setWidth(160),
                  child: Switch(
                    value: isReservation,
                    onChanged: (value) {
                      setState(() {
                        isReservation = value;
                      });
                    },
                    activeTrackColor: Colors.green,
                    activeColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            color: Colors.grey[300],
            margin: EdgeInsets.only(
              top: ScreenUtil.getInstance().setHeight(10),
              left: ScreenUtil.getInstance().setWidth(75),
              right: ScreenUtil.getInstance().setWidth(75),
            ),
          ),
          Container(
            width: ScreenUtil.getInstance().setWidth(1125),
            padding: EdgeInsets.only(
              top: ScreenUtil.getInstance().setHeight(20),
              bottom: ScreenUtil.getInstance().setHeight(20),
              left: ScreenUtil.getInstance().setWidth(75),
              right: ScreenUtil.getInstance().setWidth(75),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: ScreenUtil.getInstance().setWidth(750),
                  child: Text(
                    "Payment information",
                    style: _tileStyle,
                  ),
                ),
                Container(
                  width: ScreenUtil.getInstance().setWidth(150),
                  child: Icon(
                    Icons.lock_outline,
                    color: Colors.green,
                    size: 30,
                  ),
                ),
                Container(
                  width: ScreenUtil.getInstance().setWidth(50),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.green,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            color: Colors.grey[300],
            margin: EdgeInsets.only(
              top: ScreenUtil.getInstance().setHeight(10),
              left: ScreenUtil.getInstance().setWidth(75),
              right: ScreenUtil.getInstance().setWidth(75),
            ),
          ),
          Container(
            width: ScreenUtil.getInstance().setWidth(1125),
            padding: EdgeInsets.only(
              top: ScreenUtil.getInstance().setHeight(20),
              bottom: ScreenUtil.getInstance().setHeight(20),
              left: ScreenUtil.getInstance().setWidth(75),
              right: ScreenUtil.getInstance().setWidth(75),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: ScreenUtil.getInstance().setWidth(750),
                  child: Text(
                    "Change password",
                    style: _tileStyle,
                  ),
                ),
                Container(
                  width: ScreenUtil.getInstance().setWidth(150),
                  child: Icon(
                    Icons.lock_outline,
                    color: Colors.green,
                    size: 30,
                  ),
                ),
                Container(
                  width: ScreenUtil.getInstance().setWidth(50),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.green,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            color: Colors.grey[300],
            margin: EdgeInsets.only(
              top: ScreenUtil.getInstance().setHeight(10),
              left: ScreenUtil.getInstance().setWidth(75),
              right: ScreenUtil.getInstance().setWidth(75),
            ),
          ),
          Container(
            height: ScreenUtil.getInstance().setHeight(240),
            padding: EdgeInsets.only(
              top: ScreenUtil.getInstance().setHeight(60),
              bottom: ScreenUtil.getInstance().setHeight(60),
            ),
            child: GestureDetector(
              onTap: _logout,
              child: Container(
                width: ScreenUtil.getInstance().setWidth(300),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.green,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.green,
                ),
                child: Text(
                  "Logout",
                  style: _subtitleStyle,
                ),
              ),
            ),
          ),
          Container(
            height: ScreenUtil.getInstance().setHeight(160),
            width: ScreenUtil.getInstance().setWidth(900),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.green,
                width: 1,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            child: GestureDetector(
              onTap: () {
                print("Profile Save");
                // Navigator.pop(context);
              },
              child: Container(
                alignment: Alignment(0, 0),
                color: Colors.green,
                child: Text(
                  "Save",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppConfig.defaultFontFamily,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _logout() {
    authenticationBloc.dispatch(LoggedOut());
    // Navigator.pop(context);
  }
}
