import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'menu.g.dart';

@JsonSerializable()
class Menu extends Equatable {
  final int id;
  final String version;
  final DateTime updateTime;
  final int menuItemCount;
  final List<MenuItem> menuItems;

  Menu({this.id, this.version, this.updateTime, this.menuItemCount, this.menuItems})
      : super([id, version, updateTime, menuItemCount, menuItems]);
  
  factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);
}



enum FoodType { healthy, vegetarian, vegan, unknown }

@JsonSerializable()
class MenuItem extends Equatable {
  final int itemId;
  final String itemName;
  final double unitPrice;
  final String itemType;
  final String thumbnailUrl;

  MenuItem({this.itemId, this.itemName, this.unitPrice, this.itemType, this.thumbnailUrl})
      : super([itemId, itemName, unitPrice, itemType, thumbnailUrl]);

  factory MenuItem.fromJson(Map<String, dynamic> json) => _$MenuItemFromJson(json);
}