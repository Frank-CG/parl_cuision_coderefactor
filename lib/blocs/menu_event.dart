import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class MenuEvent extends Equatable {
  MenuEvent([List props = const []]) : super(props);
}

class FetchMenu extends MenuEvent {}

class RefreshMenu extends MenuEvent {}
