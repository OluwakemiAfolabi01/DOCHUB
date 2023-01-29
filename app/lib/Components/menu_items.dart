import 'package:dochub/Models/menu_item.dart';
import 'package:flutter/material.dart';

class MenuItems {

  static const List<MenuContent> itemsFirst = [itemProfile];
  static const List<MenuContent> itemsSecond = [itemLogut];

  static const itemProfile = MenuContent(
    text: 'Profile',
    icon: Icons.person,
  );

  static const itemLogut = MenuContent(
    text: 'Logout',
    icon: Icons.logout,
  );
}