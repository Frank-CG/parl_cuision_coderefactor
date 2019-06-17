
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:parl_cuision_coderefactor/models/models.dart';

@immutable
abstract class MenuState extends Equatable {
  MenuState([List props = const []]) : super(props);
}

class Empty extends MenuState {}

class Loading extends MenuState {
  @override
  String toString() => 'Loading';
}


class Loaded extends MenuState {
  final Menu menu;

  Loaded({@required this.menu}) : super([menu]);

  @override
  String toString() => 'Loaded { count: ${menu.menuItemCount} }';
}
