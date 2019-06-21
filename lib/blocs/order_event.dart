import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:parl_cuision_coderefactor/models/models.dart';

@immutable
abstract class OrderEvent extends Equatable {
  OrderEvent([List props = const []]) : super(props);
}

class ItemCleanEvent extends OrderEvent {
  @override
  String toString() => 'ItemClean';
}

class ItemAddEvent extends OrderEvent {
  final OrderItem orderItem;
  
  ItemAddEvent({@required this.orderItem}) : super([orderItem]);

  @override
  String toString() => 'ItemAdd';
}

class ItemSubEvent extends OrderEvent {
  final OrderItem orderItem;
  
  ItemSubEvent({@required this.orderItem}) : super([orderItem]);

  @override
  String toString() => 'ItemSub';
}