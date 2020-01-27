import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parl_cuision_coderefactor/app_conifg.dart';
import 'package:parl_cuision_coderefactor/blocs/blocs.dart';
import 'package:parl_cuision_coderefactor/models/enums.dart';
import 'package:parl_cuision_coderefactor/repositories/user_repository.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLargeScreen;
  bool isLandscape;
  double _fontSizeAdjustment;
  double _basicWidth;
  double _basicHeigth;

  TextStyle _pageTitleStyle;
  TextStyle _tileStyle;
  TextStyle _subtitleStyle;

  bool isPickup = true;
  bool isReservation = true;
  AuthenticationBloc authenticationBloc;

  UserRepository userRepository;

  @override
  void initState() {
    this.authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    this.userRepository = authenticationBloc.userRepository;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isLargeScreen =
        AppConfig.instance.deviceType == DeviceType.Tablets ? true : false;
    isLandscape =
        AppConfig.instance.orientation == Orientation.landscape ? true : false;
    _fontSizeAdjustment =
        AppConfig.instance.deviceType == DeviceType.Tablets ? 8.0 : 0.0;
    _basicWidth = AppConfig.instance.blockWidth;
    _basicHeigth = AppConfig.instance.blockHeight;

    _pageTitleStyle = TextStyle(
      fontSize: 48.0 + _fontSizeAdjustment,
      fontFamily: AppConfig.defaultFontFamily,
      fontWeight: FontWeight.bold,
    );
    _tileStyle = TextStyle(
      fontSize: 28.0 + _fontSizeAdjustment,
      fontFamily: AppConfig.defaultFontFamily,
      fontWeight: FontWeight.bold,
    );
    _subtitleStyle = TextStyle(
      fontSize: 18.0 + _fontSizeAdjustment,
      fontFamily: AppConfig.defaultFontFamily,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _pageTop(),
          SizedBox(
            height: _basicHeigth * 5,
          ),
          _profileInfo(),
          SizedBox(
            height: _basicHeigth * 5,
          ),
          _notification(),
        ],
      ),
    );
  }

  Widget _pageTop() {
    return Container(
      padding: EdgeInsets.only(
        left: _basicWidth * 5.0,
        right: _basicWidth * 5.0,
        top: _basicHeigth * 5.0,
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
                // child: Image.asset(
                //   "assets/images/nav.png",
                //   width: _basicWidth * (isLandscape ? 12.0 : 20.0),
                // ),
                child: Image.network("https://graph.microsoft.com/v1.0/users/frankg@sliq.com/photo/\$value", 
                  headers: {"Authorization": "eyJ0eXAiOiJKV1QiLCJub25jZSI6IlMtRUNJQXJKU29sV2lYN1VJa0tCMTBuZjQyR3ByX09NZnRMc1YwZURsR3MiLCJhbGciOiJSUzI1NiIsIng1dCI6ImllX3FXQ1hoWHh0MXpJRXN1NGM3YWNRVkduNCIsImtpZCI6ImllX3FXQ1hoWHh0MXpJRXN1NGM3YWNRVkduNCJ9.eyJhdWQiOiJodHRwczovL2dyYXBoLm1pY3Jvc29mdC5jb20iLCJpc3MiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC9hOTRiZGQ2OC01ZmVhLTQ5ZWItODA0NS0xMTAwNmQwMjI4YzgvIiwiaWF0IjoxNTY2MzIxMjk0LCJuYmYiOjE1NjYzMjEyOTQsImV4cCI6MTU2NjMyNTE5NCwiYWlvIjoiNDJGZ1lKQTdlKzNFOUNhTzhMK2g4eXQxTHpEZEF3QT0iLCJhcHBfZGlzcGxheW5hbWUiOiJCMkN0ZXN0IiwiYXBwaWQiOiIwODE2NjYyNi1lNWFmLTQ0MjQtOGI3YS0wYTZkNTk4NTM2MTciLCJhcHBpZGFjciI6IjEiLCJpZHAiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC9hOTRiZGQ2OC01ZmVhLTQ5ZWItODA0NS0xMTAwNmQwMjI4YzgvIiwib2lkIjoiMTdlMWY3YzctMTVkNC00NjQwLWE4ZGItM2RiMTk4ZDA2NzNhIiwicm9sZXMiOlsiRGlyZWN0b3J5LlJlYWQuQWxsIiwiVXNlci5SZWFkLkFsbCJdLCJzdWIiOiIxN2UxZjdjNy0xNWQ0LTQ2NDAtYThkYi0zZGIxOThkMDY3M2EiLCJ0aWQiOiJhOTRiZGQ2OC01ZmVhLTQ5ZWItODA0NS0xMTAwNmQwMjI4YzgiLCJ1dGkiOiJQazZSLVVpTnhFR0h1MWNjVEUtb0FBIiwidmVyIjoiMS4wIiwieG1zX3RjZHQiOjE0MjIzODgyNTl9.CbKF3o5V2NnCheSFV2Yjcqd20qSkpC0mAsYHba_zflAcl-2MSR-VMpJyXXtO3Bbv02WvVJ7JT36XVEb8VEo2_LFwhiesauO49ZHrNW92qvAVZMhI06NmXoVfI07VZYqomazZ0RdBAKWllCsYSo4JSprXudV0wPn8t0S4bANMDvRfAXCW2O_SAANR9hUXNx3jUsTGL2Hxww5HG8C-2xLI2B6KCYp85Q8ttdYLJ1Vf9atwKryjn33XaVgdTjXCfnG90Y8DZRle9o_8qMlZtH_PYOthgzTSifTdWTHM7bahOQIlhpb-9VAi0wbYlaQvDo5zQeKEn1rIBAlch8LW_fX9zA"},),
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
                    controller: _getTextController(userRepository.userInfo.givenName),
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
                    controller: _getTextController(userRepository.userInfo.surname),
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
                    controller: _getTextController(userRepository.userInfo.mail),
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
                    controller: _getTextController(userRepository.userInfo.mobilePhone),
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
      fontSize: 18.0 + _fontSizeAdjustment,
      fontFamily: AppConfig.defaultFontFamily,
      fontWeight: FontWeight.bold,
    );
    return Container(
      // height: ScreenUtil.getInstance().setHeight(1100),
      padding: EdgeInsets.only(
        left: _basicWidth * 5.0,
        right: _basicWidth * 5.0,
        top: _basicHeigth * 3.0,
      ),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Container(
            width: _basicWidth * 90,
            child: Text(
              "Notifications",
              style: _tileStyle,
            ),
          ),
          Container(
            width: _basicWidth * 90,
            child: Row(
              children: <Widget>[
                Container(
                  width: _basicWidth * 20,
                  child: Text(
                    "Pickup",
                    style: _labelStyle,
                  ),
                ),
                Container(
                  width: _basicWidth * 15,
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
                  width: _basicWidth * 10,
                ),
                Container(
                  width: _basicWidth * 30,
                  child: Text(
                    "Reservation",
                    style: _labelStyle,
                  ),
                ),
                Container(
                  width: _basicWidth * 15,
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
            width: _basicWidth * 90,
            color: Colors.grey[300],
          ),
          Container(
            width: _basicWidth * 90,
            height: _basicHeigth * 8.0,
            alignment: Alignment.centerLeft,
            child: Row(
              children: <Widget>[
                Container(
                  width: _basicWidth * 70,
                  child: Text(
                    "Payment information",
                    style: _tileStyle,
                  ),
                ),
                Container(
                  width: _basicWidth * 15,
                  child: Icon(
                    Icons.lock_outline,
                    color: Colors.green,
                    size: 30,
                  ),
                ),
                Container(
                  width: _basicWidth * 5,
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
            width: _basicWidth * 90,
            color: Colors.grey[300],
          ),
          Container(
            width: _basicWidth * 90,
            height: _basicHeigth * 8.0,
            alignment: Alignment.centerLeft,
            child: Row(
              children: <Widget>[
                Container(
                  width: _basicWidth * 70,
                  child: Text(
                    "Change password",
                    style: _tileStyle,
                  ),
                ),
                Container(
                  width: _basicWidth * 15,
                  child: Icon(
                    Icons.lock_outline,
                    color: Colors.green,
                    size: 30,
                  ),
                ),
                Container(
                  width: _basicWidth * 5,
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
            width: _basicWidth * 90,
            color: Colors.grey[300],
          ),

          Container(
            width: _basicWidth * 90,
            height: _basicHeigth * 15,
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: _logout,
                  child: Container(
                    width: _basicWidth * 25,
                    height: 40.0,
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

                GestureDetector(
                  onTap: (){},
                  child: Container(
                    width: _basicWidth * 45,
                    height: 40.0,
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
                      "Save",
                      style: _subtitleStyle,
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

  void _logout() {
    authenticationBloc.dispatch(LoggedOut());
  }
}
