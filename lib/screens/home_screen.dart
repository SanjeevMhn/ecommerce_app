import 'package:ecommerce_app/controllers/favorites_controller.dart';
import 'package:ecommerce_app/models/ProductListModel.dart';
import 'package:ecommerce_app/services/product_service.dart';
import 'package:ecommerce_app/widgets/category_button.dart';
import 'package:ecommerce_app/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<Productlistmodel> productList;
  late Future<List<String>> categories;

  String activeCategory = 'all';
  TextEditingController searchText = TextEditingController();

  final FavoritesController favoritesController = Get.put(
    FavoritesController(),
  );

  @override
  void initState() {
    productList = ProductService().getProducts();
    categories = ProductService().getProductCategories();
    super.initState();
  }

  Future<void> handleRefresh() async {
    setState(() {
      activeCategory = 'all';
      categories = ProductService().getProductCategories();
      productList = ProductService().getProducts();
    });
  }

  void onCategoryClick(String cat) {
    setState(() {
      activeCategory = cat;
      productList = ProductService().getProductsByCategory(cat);
    });
  }

  void onSearch(String search) {
    setState(() {
      productList = ProductService().getProductsBySearch(search);
    });
  }

  void onGetAllProducts() {
    setState(() {
      activeCategory = 'all';
      productList = ProductService().getProducts();
    });
  }

  @override
  void dispose() {
    searchText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        color: Color(0xFF121111),
        onRefresh: handleRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(25.r),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Hello, Welcome 👋",
                            style: TextStyle(fontSize: 15.sp),
                          ),
                          Text(
                            "John Doe",
                            style: TextStyle(
                              fontSize: 25.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: 22.r,
                        backgroundColor: Colors.blueAccent,
                      ),
                    ],
                  ),
                  SizedBox(height: 15.r),
                  Row(
                    spacing: 12.r,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: searchText,
                          onFieldSubmitted: onSearch,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(12.r),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            hintText: "Search...",
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(Icons.search, size: 25.r),
                            suffixIcon: ValueListenableBuilder<TextEditingValue>(
                              valueListenable: searchText,
                              builder: (context, value, child) {
                                return value.text.isNotEmpty
                                    ? IconButton(
                                        icon: const Icon(Icons.clear),
                                        onPressed: () {
                                          searchText.clear();
                                          onGetAllProducts();
                                        },
                                      )
                                    : const SizedBox.shrink(); // Use an empty box when hidden
                              },
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFDDDDDD),
                                width: 1.5.r,
                              ),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFDDDDDD),
                                width: 1.5.r,
                              ),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFDDDDDD),
                                width: 3.r,
                              ),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: Color(0xFF121111),
                        ),
                        child: Center(
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(Icons.tune),
                            color: Colors.white,
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25.h),
                  FutureBuilder<List<String>>(
                    future: categories,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        Center(child: const CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        Center(child: Text('Error: ${snapshot.error}'));
                      }
                      if (snapshot.hasData) {
                        final List<String>? data = snapshot.data;
                        return SizedBox(
                          height: 35.h,
                          child: Row(
                            children: [
                              CategoryButton(
                                category: 'All Items',
                                isActive: activeCategory == 'all',
                                onCategoryClicked: (String res) =>
                                    onGetAllProducts(),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: data!.length,
                                  itemBuilder: (context, index) {
                                    return CategoryButton(
                                      category: data[index],
                                      isActive: activeCategory == data[index],
                                      onCategoryClicked: onCategoryClick,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return Center(child: Text('No categories found'));
                    },
                  ),
                  SizedBox(height: 25.h),
                  FutureBuilder<Productlistmodel>(
                    future: productList,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: const CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text('Error ${snapshot.error}'));
                      }

                      if (snapshot.hasData) {
                        final data = snapshot.data;
                        final products = data!.products;
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
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final product = products[index];
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
                      }

                      return Center(child: Text('No products found.'));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
