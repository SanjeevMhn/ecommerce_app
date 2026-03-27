import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  final _box = GetStorage();

  var isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    isLoggedIn.value = _box.read('token') != null;
    _box.listenKey('token', (value) {
      isLoggedIn.value = value != null;
    });

  }

  void logout() {
    _box.remove('token');
    _box.remove('user');
  }
}
