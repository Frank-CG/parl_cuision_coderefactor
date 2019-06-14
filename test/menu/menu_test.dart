import 'dart:convert';
import 'dart:io';

import 'package:parl_cuision_coderefactor/models/menu.dart';
import 'package:test/test.dart';

void main() {
  test('MenuItem deserialize', () async {
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
}