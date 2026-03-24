import 'package:flutter/material.dart';

class NavigationItemmodel {
  final int id;
  final String name;
  final String link;
  final Icon icon;
  final Icon activeIcon;

  NavigationItemmodel({
    required this.id,
    required this.name,
    required this.link,
    required this.icon,
    required this.activeIcon,
  });
}
