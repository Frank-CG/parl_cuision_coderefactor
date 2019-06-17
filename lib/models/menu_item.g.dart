// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuItem _$MenuItemFromJson(Map<String, dynamic> json) {
  return MenuItem(
      itemId: json['itemId'] as int,
      itemName: json['itemName'] as String,
      unitPrice: (json['unitPrice'] as num)?.toDouble(),
      itemType: json['itemType'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String);
}

Map<String, dynamic> _$MenuItemToJson(MenuItem instance) => <String, dynamic>{
      'itemId': instance.itemId,
      'itemName': instance.itemName,
      'unitPrice': instance.unitPrice,
      'itemType': instance.itemType,
      'thumbnailUrl': instance.thumbnailUrl
    };
