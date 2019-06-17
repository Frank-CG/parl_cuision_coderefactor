// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Menu _$MenuFromJson(Map<String, dynamic> json) {
  return Menu(
      id: json['id'] as int,
      version: json['version'] as String,
      updateTime: json['updateTime'] == null
          ? null
          : DateTime.parse(json['updateTime'] as String),
      menuItemCount: json['menuItemCount'] as int,
      menuItems: (json['menuItems'] as List)
          ?.map((e) =>
              e == null ? null : MenuItem.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$MenuToJson(Menu instance) => <String, dynamic>{
      'id': instance.id,
      'version': instance.version,
      'updateTime': instance.updateTime?.toIso8601String(),
      'menuItemCount': instance.menuItemCount,
      'menuItems': instance.menuItems
    };
