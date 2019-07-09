import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:parl_cuision_coderefactor/app_conifg.dart';
import 'package:parl_cuision_coderefactor/models/enums.dart';

class ReserveDialog extends StatelessWidget {
  final String title, reserveTime, buttonText;
  final Image image;

  String _defaultFontFamily = "Nunito Sans";

  Function() callback;

  ReserveDialog({
    @required this.title,
    @required this.reserveTime,
    @required this.buttonText,
    this.image,
    this.callback,
  });

  bool isLargeScreen;
  bool isLandscape;
  double _fontSizeAdjustment;
  double _basicWidth;
  double _basicHeigth;

  @override
  Widget build(BuildContext context) {
    isLargeScreen =
        AppConfig.instance.deviceType == DeviceType.Tablets ? true : false;
    isLandscape = AppConfig.instance.orientation == Orientation.landscape
        ? isLargeScreen ? false : true
        : false;
    _fontSizeAdjustment =
        AppConfig.instance.deviceType == DeviceType.Tablets ? 16.0 : 0.0;
    _basicWidth = AppConfig.instance.blockWidth;
    _basicHeigth = AppConfig.instance.blockHeight;
    
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    double _plateSizeHeight =
        isLandscape ? Consts.padding * 8.75 : Consts.padding * 10;

    return Container(
      width: AppConfig.instance.blockWidth * (isLandscape ? 60.0 : 80.0),
      child: SingleChildScrollView(
        // controller: controller,
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                top: Consts.avatarRadius,//+ Consts.padding,
                // bottom: Consts.padding,
                // left: Consts.padding,
                // right: Consts.padding,
              ),
              margin: EdgeInsets.only(top: Consts.avatarRadius),
              decoration: new BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(Consts.padding),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: const Offset(0.0, 10.0),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // To make the card compact
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 24.0 * (isLargeScreen ? 2 : 1),
                      fontWeight: FontWeight.w700,
                      fontFamily: _defaultFontFamily,
                    ),
                  ),
                  // SizedBox(height: 8.0),
                  Container(
                    width: AppConfig.instance.blockWidth * 50,
                    child: Text(
                      "Your reservation is accepeted:",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0 * (isLargeScreen ? 2 : 1),
                        fontFamily: _defaultFontFamily,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  // SizedBox(height: 8.0),
                  Container(
                    child: Text(
                      reserveTime,
                      style: TextStyle(
                        fontSize: 40.0,
                        fontFamily: _defaultFontFamily,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      callback();
                    },
                    child: Container(
                      decoration: new BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(Consts.padding),
                          bottomRight: Radius.circular(Consts.padding),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10.0,
                            offset: const Offset(0.0, 10.0),
                          ),
                        ],
                      ),
                      child: Container(
                        height: Consts.padding * (isLargeScreen ? 4 : 3),
                        alignment: Alignment.center,
                        child: Text(
                          buttonText,
                          style: TextStyle(
                            fontSize: 20.0 * (isLargeScreen ? 2 : 1),
                            fontFamily: _defaultFontFamily,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: Consts.padding,
              right: Consts.padding,
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: Consts.avatarRadius,
                child: Image.asset("assets/images/checkout_plate.png"),
              ),
              // child: Container,
            ),
            Positioned(
              top: Consts.padding * 3.5,
              left: Consts.padding * 1.6,
              right: Consts.padding,
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: Consts.avatarRadius * 0.3,
                child: Image.asset(
                  "assets/images/icon_pickuptime.png",
                  // width: ScreenUtil.getInstance().setWidth(100),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Consts {
  Consts._();

  static const double paddingPortrait = 16.0;
  static const double avatarRadiusPortrait = 88.0;

  static const double paddingLandscape = 14.0;
  static const double avatarRadiusLandscape = 77.0;

  static const double paddingLargeScreen = 20.0;
  static const double avatarRadiusLargeScreen = 110.0;

  static double get padding {
    bool isLandscape =
        AppConfig.instance.orientation == Orientation.landscape ? true : false;
    bool isLargeScreen =
        AppConfig.instance.deviceType == DeviceType.Tablets ? true : false;
    return isLandscape
        ? isLargeScreen ? paddingLargeScreen : paddingLandscape
        : paddingPortrait;
  }

  static double get avatarRadius {
    bool isLandscape =
        AppConfig.instance.orientation == Orientation.landscape ? true : false;
    bool isLargeScreen =
        AppConfig.instance.deviceType == DeviceType.Tablets ? true : false;
    return isLandscape
        ? isLargeScreen ? avatarRadiusLargeScreen : avatarRadiusLandscape
        : avatarRadiusPortrait;
  }
}
