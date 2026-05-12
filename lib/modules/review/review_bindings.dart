import 'package:furniture_app/modules/review/review_controller.dart';
import 'package:get/get.dart';

class ReviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReviewController());
  }
}