import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CheckoutState extends Equatable {
  final int stepIndex;
  final String hour;
  final String minute;
  String get pickupTime {
    int h = int.parse(hour);
    int m = int.parse(minute);
    String suffix = h < 12 ? " am" : " pm";
    if (h == -1 || m == -1) {
      return "Unselected";
    } else {
      return hour + ":" + minute + suffix;
    }
  }

  CheckoutState(
      {this.stepIndex = 0,
      this.hour = "-1",
      this.minute = "-1",
      List props = const []})
      : super(props);
}

class CheckoutStep1 extends CheckoutState {
  @override
  String toString() => 'Checkout Step1';
}

class CheckoutStep2 extends CheckoutState {
  CheckoutStep2({@required hour, @required minute})
      : super(stepIndex: 1, hour: hour, minute: minute);

  String get hour => super.hour;
  String get minute => super.minute;

  @override
  String toString() => 'Checkout Step2 { hour: $hour, minute: $minute }';
}

class CheckoutTimeSetting extends CheckoutState {
  CheckoutTimeSetting({@required hour, @required minute})
      : super(stepIndex: 1, hour: hour, minute: minute);

  @override
  String toString() => 'Checkout TimeSetting';
}

class CheckoutStep3 extends CheckoutState {
  CheckoutStep3({@required hour, @required minute})
      : super(stepIndex: 2, hour: hour, minute: minute);

  @override
  String toString() => 'Checkout Step3';
}

class CheckoutConfirmed extends CheckoutState {
  CheckoutConfirmed() : super(stepIndex: -1,);

  @override
  String toString() => 'Checkout Confirm';
}

class CheckoutCanceled extends CheckoutState {
  CheckoutCanceled()
      : super(
          stepIndex: -1,
        );

  @override
  String toString() => 'Checkout Canceled';
}
