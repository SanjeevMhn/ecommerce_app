import 'package:ecommerce_app/controllers/favorites_controller.dart';
import 'package:ecommerce_app/models/ProductListModel.dart';
import 'package:ecommerce_app/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';

class ProductDetailScreen extends StatefulWidget {
  final int productId;
  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  void initState() {
    super.initState();
    getProduct(widget.productId);
  }

  final FavoritesController favoritesController = Get.find();
  int quantity = 1;
  Product? product;

  Future<void> getProduct(int id) async {
    try {
      final data = await ProductService().getProductById(id);
      setState(() => product = data);
    } catch (e) {
      print('Error: $e');
    }
  }

  void increaseQuantity() {
    setState(() => quantity++);
  }

  void decreaseQuantity() {
    if (quantity > 1) {
      setState(() => quantity--);
    }
  }

  void addToCart() {
    if (GetStorage().read('token') == null) {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Login'),
            content: const Text('Login to add products to cart.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  context.go('/login');
                  Navigator.of(context).pop();
                },
                child: const Text('Login'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(25.r),
            child: product != null
                ? Expanded(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.r),
                                color: Colors.blue[100],
                              ),
                              child: AspectRatio(
                                aspectRatio: 1 / 1.25,
                                child: Image.network(
                                  product!.thumbnail,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 10,
                              top: 10,
                              child: Container(
                                width: 45.w,
                                height: 45.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    width: 1.2,
                                    color: Color(0xFFDDDDDD),
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      if (context.canPop()) {
                                        context.pop();
                                      } else {
                                        context.goNamed('home');
                                      }
                                    },
                                    icon: Icon(Icons.chevron_left),
                                    iconSize: 30.r,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: Container(
                                width: 45.w,
                                height: 45.h,
                                decoration: BoxDecoration(
                                  color: Color(0xFF121111),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      final bool result = favoritesController
                                          .toggleFavorite(product!);
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          behavior: SnackBarBehavior.floating,
                                          duration: Duration(seconds: 2),
                                          content: result
                                              ? Text('Added to favorites')
                                              : Text('Removed from favorites'),
                                        ),
                                      );
                                    },
                                    icon: Obx(() {
                                      final isFavorite = favoritesController
                                          .checkIfExists(widget.productId);

                                      return Icon(
                                        isFavorite
                                            ? Icons.favorite
                                            : Icons.favorite_outline,
                                        color: Colors.white,
                                      );
                                    }),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product!.title,
                                    style: TextStyle(
                                      fontSize: 20.r,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    spacing: 5.r,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.star, color: Colors.amber),
                                      Text(product!.rating.toStringAsFixed(1)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              spacing: 10.r,
                              children: [
                                GestureDetector(
                                  onTap: decreaseQuantity,
                                  child: Container(
                                    width: 35.w,
                                    height: 35.h,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Color(0xFFDDDDDD),
                                        width: 1,
                                      ),
                                      color: Colors.white,
                                    ),
                                    child: Center(
                                      child: Icon(Icons.remove, size: 25.r),
                                    ),
                                  ),
                                ),
                                Text(
                                  '$quantity',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: increaseQuantity,
                                  child: Container(
                                    width: 35.w,
                                    height: 35.h,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Color(0xFFDDDDDD),
                                        width: 1,
                                      ),
                                      color: Colors.white,
                                    ),
                                    child: Center(
                                      child: Icon(Icons.add, size: 25.r),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 15.h),
                        Text(product!.description),
                        SizedBox(height: 20.h),
                        FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: Color(0xFF121111),
                            shape: StadiumBorder(),
                          ),
                          onPressed: addToCart,
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.all(15.r),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                spacing: 10.r,
                                children: [
                                  Icon(
                                    Icons.shopping_cart,
                                    color: Colors.white,
                                    size: 20.r,
                                  ),
                                  Text(
                                    'Add to Cart | \$${product!.price.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}
