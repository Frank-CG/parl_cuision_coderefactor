import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:parl_cuision_coderefactor/models/order.dart';

@immutable
abstract class OrderState extends Equatable {
  OrderState([List props = const []]) : super(props);
}


class OrderInited extends OrderState {
  final Order order;

  OrderInited({@required this.order}) : super([order]);

  @override
  String toString() => 'OrderInited { items: ${order.itemCount} }';
}
