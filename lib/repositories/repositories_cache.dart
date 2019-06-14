
import 'package:flutter/widgets.dart';

import 'package:parl_cuision_coderefactor/repositories/menu_repository.dart';

enum RepositoryType { MenuRepository, OrderRepository }

class RepositoryCache extends InheritedModel<RepositoryType> {
  RepositoryCache(
      {Key key, @required this.menuRepository, @required this.child})
      : super(key: key, child: child);

  final Widget child;
  final MenuRepository menuRepository;

  static RepositoryCache of(BuildContext context, {RepositoryType aspect}) {
    return InheritedModel.inheritFrom<RepositoryCache>(context, aspect: aspect);
  }

  @override
  bool updateShouldNotify(RepositoryCache oldWidget) {
    return menuRepository.data.id != oldWidget.menuRepository.data.id;
  }

  @override
  bool updateShouldNotifyDependent(RepositoryCache oldWidget, Set<RepositoryType> dependencies) {
    return ( dependencies.contains(RepositoryType.MenuRepository) && (menuRepository.data.id != oldWidget.menuRepository.data.id) );
  }
}