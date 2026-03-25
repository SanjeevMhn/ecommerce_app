import 'package:dio/dio.dart';
import 'package:ecommerce_app/client/dio_client.dart';
import 'package:ecommerce_app/models/ProductListModel.dart';

class ProductService {
  final Dio _dio = DioClient.instance;

  Future<Productlistmodel> getProducts({
    int page = 0,
    String? category,
    String? search,
  }) async {
    try {
      final int skip = page * 6;
      final String url = category != null
          ? '/products/category/$category?limit=6&skip=$skip'
          : search != null
          ? '/products/search?q=$search&limit=6&skip=$skip'
          : '/products?limit=6&skip=$skip';
      final response = await _dio.get(url);
      var data = response.data;
      return Productlistmodel.fromJson(data);
    } on DioException catch (e) {
      throw handleError(e);
    }
  }

  Future<Product> getProductById(int id) async{
    try{
      final response = await _dio.get('/products/$id');
      var data = response.data;
      return Product.fromJson(data);
    }on DioException catch(e){
      throw handleError(e);
    }
  }

  Future<Productlistmodel> getProductsByCategory(String category) async {
    try {
      final response = await _dio.get('/products/category/$category?limit=6');
      var data = response.data;
      return Productlistmodel.fromJson(data);
    } on DioException catch (e) {
      throw handleError(e);
    }
  }

  Future<Productlistmodel> getProductsBySearch(String search) async {
    try {
      final response = await _dio.get('/products/search?q=$search&limit=6');
      var data = response.data;
      return Productlistmodel.fromJson(data);
    } on DioException catch (e) {
      throw handleError(e);
    }
  }

  Future<List<String>> getProductCategories() async {
    try {
      final response = await _dio.get('/product/category-list');
      List<String> data = List<String>.from(response.data ?? []);
      return data;
    } on DioException catch (e) {
      throw handleError(e);
    }
  }

  String handleError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      return "Connection timed out. Check your internet.";
    } else if (e.response?.statusCode == 404) {
      return "Product not found.";
    } else if (e.response?.statusCode == 401) {
      return "Please login to perform this action.";
    }
    return "Something went wrong. Please try again.";
  }
}
