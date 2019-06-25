import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class MenuEvent extends Equatable {
  MenuEvent([List props = const []]) : super(props);
}

class FetchMenu extends MenuEvent {}

class RefreshMenu extends MenuEvent {}

class MenuFilterChange extends MenuEvent {
  final bool isHealthy;
  final bool isVegetarian;
  final bool isVegan;

  MenuFilterChange({this.isHealthy = true, this.isVegetarian = true, this.isVegan = true});
}
