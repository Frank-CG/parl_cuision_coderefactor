import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:parl_cuision_coderefactor/models/models.dart';
import 'blocs.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final Order order;

  OrderBloc({@required this.order});

  @override
  OrderState get initialState => OrderInited(order: this.order);

  @override
  Stream<OrderState> mapEventToState(
    OrderEvent event,
  ) async* {
    if (event is ItemAddEvent) {
      yield OrderChanging();
      this.order.add(event.orderItem);
      yield OrderInited(order: this.order);
    }
    if (event is ItemSubEvent) {
      yield OrderChanging();
      this.order.remove(event.orderItem);
      yield OrderInited(order: this.order);
    }
  }

  dispose(){}
}
