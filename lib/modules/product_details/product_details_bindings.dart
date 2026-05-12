import 'package:furniture_app/modules/product_details/product_details_controller.dart';
import 'package:furniture_app/modules/product_details/product_details_view.dart';
import 'package:get/get.dart';

class ProductDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductDetailController());
  }
}