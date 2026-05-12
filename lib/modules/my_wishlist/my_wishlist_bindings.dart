import 'package:get/get.dart';

import 'my_wishlist_controller.dart';

class WishlistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WishlistController());
  }
}