import 'package:ecommerce_app/models/ProductListModel.dart';
import 'package:get/get.dart';

class FavoritesController extends GetxController {
  var favorites = <Product>[].obs;

  List<Product> getFavorites() => favorites;

  bool checkIfExists(int id) => favorites.any((fav) => fav.id == id);

  bool toggleFavorite(Product product) {
    if (!checkIfExists(product.id)) {
      favorites.add(product);
      return true;
    }
    favorites.removeWhere((prod) => prod.id == product.id);
    return false;
  }
}
