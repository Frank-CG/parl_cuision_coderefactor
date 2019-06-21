import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CheckoutEvent extends Equatable {
  CheckoutEvent([List props = const []]) : super(props);
}

class CheckoutInitial extends CheckoutEvent {
  @override
  String toString() => 'Checkout CheckoutInitial';
}

// class CheckoutStpe1Confirm extends CheckoutEvent {
//   @override
//   String toString() => 'Checkout Stpe1 Confirm';
// }

// class CheckoutStpe2Confirm extends CheckoutEvent {
//   @override
//   String toString() => 'Checkout Stpe2 Confirm';
// }

// class CheckoutStpe3Confirm extends CheckoutEvent {
//   @override
//   String toString() => 'Checkout Stpe3 Confirm';
// }

class CheckoutNext extends CheckoutEvent {
  final int stepIndex;
  final String hour;
  final String minute;

  CheckoutNext({this.stepIndex, this.hour, this.minute});

  @override
  String toString() => 'Checkout Next';
}

class CheckoutSetTime extends CheckoutEvent {
  final String hour;
  final String minute;

  CheckoutSetTime({@required this.hour, @required this.minute});

  @override
  String toString() => 'Checkout Set Time';
}


class CheckoutCancel extends CheckoutEvent {
  @override
  String toString() => 'Checkout Cancel';
}

class CheckoutFinish extends CheckoutEvent {
  @override
  String toString() => 'Checkout Finish';
}
