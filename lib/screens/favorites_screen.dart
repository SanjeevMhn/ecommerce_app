import 'package:ecommerce_app/controllers/favorites_controller.dart';
import 'package:ecommerce_app/models/ProductListModel.dart';
import 'package:ecommerce_app/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FavoritesController favoritesController = Get.put(
      FavoritesController(),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(25.r),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 45.w,
                      height: 45.h,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.2,
                          color: Color(0xFFDDDDDD),
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          icon: Icon(Icons.chevron_left),
                          iconSize: 30.r,
                        ),
                      ),
                    ),
                    Text(
                      'Favorites',
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 45.w),
                  ],
                ),
                SizedBox(height: 25.h),
                Obx(() {
                  final List<Product> favs = favoritesController.getFavorites();

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.5,
                        ),
                    itemCount: favs.length,
                    itemBuilder: (context, index) {
                      final product = favs[index];
                      return ProductCard(
                        id: product.id,
                        title: product.title,
                        category: product.category,
                        image: product.thumbnail,
                        price: product.price,
                        toggleFavorite: () {
                          final bool result = favoritesController
                              .toggleFavorite(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              duration: Duration(seconds: 2),
                              content: result
                                  ? Text('Added to favorites')
                                  : Text('Removed from favorites'),
                            ),
                          );
                        },
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
