import 'package:ecommerce_app/layout/main_layout.dart';
import 'package:ecommerce_app/screens/cart_screen.dart';
import 'package:ecommerce_app/screens/favorites_screen.dart';
import 'package:ecommerce_app/screens/home/home_screen.dart';
import 'package:ecommerce_app/screens/login_screen.dart';
import 'package:ecommerce_app/screens/product_detail_screen.dart';
import 'package:ecommerce_app/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter routes = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainLayout(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              name: 'home',
              builder: (context, state) => HomeScreen(),
              routes: [
                GoRoute(
                  path: 'product/:id',
                  builder: (context, state) {
                    final productId = state.pathParameters['id'];
                    if (productId != null) {
                      final int id = int.parse(productId);
                      return ProductDetailScreen(productId: id);
                    }
                    return Placeholder();
                  },
                ),
                GoRoute(
                  path: 'login',
                  builder: (context, state) => LoginScreen(),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/cart', name: 'cart', builder: (context, state) => CartScreen()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/favorites',
              name: 'favorites',
              builder: (context, state) => FavoritesScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              name: 'profile',
              builder: (context, state) => ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
