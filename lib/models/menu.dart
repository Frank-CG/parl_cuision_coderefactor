import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'menu_item.dart';

part 'menu.g.dart';

@JsonSerializable()
class Menu extends Equatable {
  final int id;
  final String version;
  final DateTime updateTime;
  final int menuItemCount;
  final List<MenuItem> menuItems;

  Menu(
      {this.id,
      this.version,
      this.updateTime,
      this.menuItemCount,
      this.menuItems})
      : super([id, version, updateTime, menuItemCount, menuItems]);

  factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);

  Menu copy() {
    List<MenuItem> newList = this.menuItems.map((e) => e).toList();
    return new Menu(
      id: this.id,
      version: this.version,
      updateTime: this.updateTime,
      menuItemCount: this.menuItemCount,
      menuItems: newList,
    );
  }
}
