import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:parl_cuision_coderefactor/models/models.dart';
import 'package:parl_cuision_coderefactor/repositories/menu_repository.dart';
import 'blocs.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final MenuRepository repository;

  MenuBloc({@required this.repository});

  @override
  MenuState get initialState => Empty();

  @override
  Stream<MenuState> mapEventToState(
    MenuEvent event,
  ) async* {
    if (event is FetchMenu) {
      final menuState = currentState;
      if(menuState is Loaded){
        yield Loaded(menu: menuState.menu);
      }else{
        yield Loading();
        Menu menu = await repository.fetchMenu();
        yield Loaded(menu: menu);
      }
    }
    if (event is RefreshMenu) {
      yield Loading();
      Menu menu = await repository.fetchMenu(forceRefresh: true);
      yield Loaded(menu: menu);
    }
  }

  dispose(){}
}
