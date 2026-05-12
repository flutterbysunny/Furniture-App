import 'package:get/get.dart';

import 'my_cart_controller.dart';

class MyCartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyCartController());
  }
}