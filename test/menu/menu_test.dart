import 'dart:convert';
import 'dart:io';
import 'package:parl_cuision_coderefactor/models/models.dart';
import 'package:test/test.dart';
import 'package:parl_cuision_coderefactor/repositories/repositories.dart';


void main() {
  group('Menu Test', () {
    test('Menu deserialize from local file', () async {
      final file = new File('test/menu/menu.json');
      final json = jsonDecode(await file.readAsString());

      var menu = Menu.fromJson(json);
      expect(menu.menuItemCount, 4);
      expect(menu.menuItems, isA<List<MenuItem>>());
      expect(menu.menuItems.length, menu.menuItemCount);

      var menuItem = menu.menuItems[0];
      expect(menuItem, isA<MenuItem>());
      expect(menuItem.unitPrice, greaterThan(0));
    });

    test('Menu repository test', () async {
      final MenuRepository menuRepository = MenuRepository();
      await menuRepository.initial();
      final Menu menu = menuRepository.data;
      expect(menu.menuItemCount, 4);
      expect(menu.menuItems, isA<List<MenuItem>>());
      expect(menu.menuItems.length, menu.menuItemCount);

    });
  });
}
