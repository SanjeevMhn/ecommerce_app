import 'package:ecommerce_app/controllers/favorites_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProductCard extends StatefulWidget {
  final int id;
  final String title;
  final String category;
  final String image;
  final double price;
  final VoidCallback toggleFavorite;
  ProductCard({
    super.key,
    required this.id,
    required this.title,
    required this.category,
    required this.image,
    required this.price,
    required this.toggleFavorite,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();

  final FavoritesController favoritesController = Get.put(
    FavoritesController(),
  );
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.r),
                color: Colors.blue[100],
              ),
              child: AspectRatio(
                aspectRatio: 1 / 1.5,
                child: Image.network(widget.image, fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 5.h),
            Expanded(
              child: Padding(
                padding: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                          // overflow: TextOverflow.ellipsis,
                        ),
                        // softWrap: false,
                      ),
                    ),
                    Text(
                      widget.category,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Color.fromARGB(255, 45, 45, 45),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${widget.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: 10,
          right: 10,
          child: Container(
            width: 30.w,
            height: 30.h,
            decoration: BoxDecoration(
              color: Color(0xFF121111),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: widget.toggleFavorite,
                icon: Obx(() {
                  final isFavorite = widget.favoritesController.checkIfExists(
                    widget.id,
                  );

                  return Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_outline,
                    color: Colors.white,
                  );
                }),
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
