import 'package:furniture_app/modules/dashboard/dashboard_bindings.dart';
import 'package:furniture_app/modules/dashboard/dashboard_view.dart';
import 'package:furniture_app/modules/forgot_password/forgot_password_bindings.dart';
import 'package:furniture_app/modules/forgot_password/forgot_password_view.dart';
import 'package:furniture_app/modules/location_permission/location_permission_bindings.dart';
import 'package:furniture_app/modules/location_permission/location_permission_view.dart';
import 'package:furniture_app/modules/location_search/location_search_bindings.dart';
import 'package:furniture_app/modules/location_search/location_search_view.dart';
import 'package:furniture_app/modules/my_cart/my_cart_bindings.dart';
import 'package:furniture_app/modules/my_cart/my_cart_view.dart';
import 'package:furniture_app/modules/my_wishlist/my_wishlist_bindings.dart';
import 'package:furniture_app/modules/my_wishlist/my_wishlist_view.dart';
import 'package:furniture_app/modules/onboarding/onboarding_binding.dart';
import 'package:furniture_app/modules/onboarding/onboarding_view.dart';
import 'package:furniture_app/modules/product_details/product_details_bindings.dart';
import 'package:furniture_app/modules/product_details/product_details_view.dart';
import 'package:furniture_app/modules/profile/profile_binding.dart';
import 'package:furniture_app/modules/profile/profile_view.dart';
import 'package:furniture_app/modules/review/review_bindings.dart';
import 'package:furniture_app/modules/review/review_view.dart';
import 'package:furniture_app/modules/search/search_bindings.dart';
import 'package:furniture_app/modules/search/search_view.dart';
import 'package:furniture_app/modules/sign_in/sign_in_binding.dart';
import 'package:furniture_app/modules/sign_in/sign_in_view.dart';
import 'package:furniture_app/modules/sign_up/sign_up_binding.dart';
import 'package:furniture_app/modules/sign_up/sign_up_view.dart';
import 'package:furniture_app/modules/splash/splash_view.dart';
import 'package:furniture_app/modules/welcome/welcome_bindings.dart';
import 'package:furniture_app/modules/welcome/welcome_views.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';


import '../../modules/splash/splash_binding.dart';


class AppRoutes {
  /// Splash Screen
  static String splashScreen = '/splash_screen';
  static String welcomeScreen = '/welcome_screen';
  static String onboardingScreen = '/onboarding_screen';
  static String signInScreen = '/signIn_screen';
  static String signUpScreen = '/signUp_screen';
  static String forgotPasswordScreen = '/forgot_password_screen';
  static String dashboard = '/dashboard_screen';
  static String otpScreen = '/otp_screen';
  static String profileScreen = '/profile_screen';
  static String permissionScreen = '/permission_screen';
  static String enterLocationScreen = '/enter_location_screen';
  static String productDetailsScreen = '/product_details_screen';
  static String myCartScreen = '/my_cart_screen';
  static String reviewScreen = '/review_screen';
  static String wishlistScreen = '/wishlist_screen';
  static String productSearchScreen = '/product_search_screen';


  static List<GetPage> pages = [
    GetPage(
      name: splashScreen,
      page: () => SplashView(),
      bindings: [
        SplashBinding(),
      ],
    ),
    GetPage(
      name: welcomeScreen,
      page: () => const WelcomeView(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: onboardingScreen,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    //
    GetPage(
      name: signInScreen,
      page: () => const SignInView(),
      binding: SignInBinding(),
    ),

    GetPage(
      name: signUpScreen,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
    ),

    GetPage(
      name: forgotPasswordScreen,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),

    GetPage(
      name: profileScreen,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),

    GetPage(
      name: permissionScreen,
      page: () => const LocationPermissionView(),
      binding: LocationPermissionBinding(),
    ),

    GetPage(
      name: enterLocationScreen,
      page: () => const LocationSearchView(),
      binding: LocationSearchBindings(),
    ),

    GetPage(
      name: dashboard,
      page: () => const DashboardScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: productDetailsScreen,
      page: () => const ProductDetailView(),
      binding: ProductDetailBinding(),
    ),

    GetPage(
      name: myCartScreen,
      page: () =>  MyCartView(),
      binding: MyCartBinding(),
    ),

    GetPage(
      name: reviewScreen,
      page: () =>  ReviewView(),
      binding: ReviewBinding(),
    ),


    GetPage(
      name: wishlistScreen,
      page: () =>  MyWishlistView(),
      binding: WishlistBinding(),
    ),

    GetPage(
      name: productSearchScreen,
      page: () =>  SearchView(),
      binding: SearchBinding(),
    ),

  ];
}
