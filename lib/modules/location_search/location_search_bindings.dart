import 'package:furniture_app/modules/location_search/location_search_controller.dart';
import 'package:get/get.dart';

class LocationSearchBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LocationSearchController());
  }
}