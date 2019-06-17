import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'menu_item.g.dart';

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