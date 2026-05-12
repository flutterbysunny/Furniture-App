import 'package:furniture_app/app/routes/app_routes.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController {
  void onGetStarted() {
    // Get.toNamed('/register');
  }

  void onSignIn() {
    Get.offNamed(AppRoutes.signInScreen);
  }
}