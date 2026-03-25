import 'package:ecommerce_app/controllers/favorites_controller.dart';
import 'package:ecommerce_app/models/ProductListModel.dart';
import 'package:ecommerce_app/screens/home/custom_floating_button_location.dart';
import 'package:ecommerce_app/services/product_service.dart';
import 'package:ecommerce_app/widgets/category_button.dart';
import 'package:ecommerce_app/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> products = [];
  int page = 0;
  bool loading = false;
  bool _showBackToTop = false;
  late Future<Productlistmodel> productList;
  late Future<List<String>> categories;

  String activeCategory = 'all';
  TextEditingController searchText = TextEditingController();
  ScrollController scrollController = ScrollController();

  final FavoritesController favoritesController = Get.put(
    FavoritesController(),
  );

  @override
  void initState() {
    super.initState();
    addProducts();
    categories = ProductService().getProductCategories();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent * 0.9) {
        setState(() {
          page++;
        });
        addProducts();
      }

      if (scrollController.offset > 500) {
        if (_showBackToTop == false) {
          setState(() => _showBackToTop = true);
        }
      } else {
        if (_showBackToTop == true) {
          setState(() => _showBackToTop = false);
        }
      }
    });
  }

  Future<void> addProducts({String? category, String? search}) async {
    try {
      final productlistmodel = await ProductService().getProducts(
        page: page,
        category: category,
        search: search,
      );
      setState(() {
        loading = false;
        products.addAll(productlistmodel.products);
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> handleRefresh() async {
    setState(() {
      activeCategory = 'all';
      categories = ProductService().getProductCategories();
      setState(() => page = 0);
      addProducts();
    });
  }

  void onCategoryClick(String cat) {
    setState(() {
      activeCategory = cat;
      products = [];
    });
      addProducts(category: cat);
  }

  void onSearch(String search) {
    setState(() {
      products = [];
    });
    addProducts(search: search);
  }

  void onGetAllProducts() {
    setState(() {
      activeCategory = 'all';
      setState(() {
        products = [];
        page = 0;
      });
      addProducts();
    });
  }

  void scrollToTop() {
    scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    searchText.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: CustomFloatingButtonLocation(),
      floatingActionButton: _showBackToTop
          ? FloatingActionButton(
              onPressed: scrollToTop,
              mini: true,
              backgroundColor: Color(0xFF121111),
              shape: CircleBorder(),
              child: Icon(Icons.arrow_upward, color: Colors.white,),
            )
          : null,
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        color: Color(0xFF121111),
        onRefresh: handleRefresh,
        child: SingleChildScrollView(
          controller: scrollController,
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
                  if (loading) Center(child: const CircularProgressIndicator()),
                  if (!loading && products.isEmpty)
                    Center(child: Text('No products found.')),

                  if (!loading && products.isNotEmpty)
                    GridView.builder(
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
                        return InkWell(
                          onTap: (){
                            context.go('/product/${product.id}');
                          },
                          child: ProductCard(
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
                          ),
                        );
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
