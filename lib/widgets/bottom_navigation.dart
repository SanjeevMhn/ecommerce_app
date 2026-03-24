import 'package:ecommerce_app/models/NavigationItemModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  List<NavigationItemmodel> navItems = [
    NavigationItemmodel(
      id: 1,
      name: "Home",
      link: '/',
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
    ),
    NavigationItemmodel(
      id: 2,
      name: "Cart",
      link: '/cart',
      icon: Icon(Icons.shopping_bag_outlined),
      activeIcon: Icon(Icons.shopping_bag),
    ),
    NavigationItemmodel(
      id: 3,
      name: "Favorites",
      link: '/favorites',
      icon: Icon(Icons.favorite_outline),
      activeIcon: Icon(Icons.favorite),
    ),
    NavigationItemmodel(
      id: 4,
      name: "Home",
      link: '/profile',
      icon: Icon(Icons.person_outline),
      activeIcon: Icon(Icons.person),
    ),
  ];

  void onTap(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.all(15.r),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100.r),
            child: BottomNavigationBar(
              currentIndex: widget.navigationShell.currentIndex,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Color(0xFF292526),
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white,
              onTap: onTap,
              items: navItems.map((item) {
                return BottomNavigationBarItem(
                  icon: item.icon,
                  label: item.name,
                  activeIcon: item.activeIcon,
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
