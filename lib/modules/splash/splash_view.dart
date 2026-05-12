/// Long - Video ////


// import 'package:flutter/material.dart';
// import 'package:furniture_app/app/utils/app_image.dart';
// import 'package:furniture_app/modules/splash/splash_controller.dart';
// import 'package:get/get.dart';
//
// class SplashView extends GetView<SplashController> {
//   const SplashView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: AnimatedBuilder(
//         animation: controller.animController,
//         builder: (context, _) {
//           return Stack(
//             fit: StackFit.expand,
//             children: [
//               // ── Top-right decorative circle ──
//               Positioned(
//                 top: -80,
//                 right: -80,
//                 child: FadeTransition(
//                   opacity: controller.bgCircleFadeAnim,
//                   child: DecorCircle(size: 220),
//                 ),
//               ),
//
//               // ── Bottom-left decorative circle ──
//               Positioned(
//                 bottom: -100,
//                 left: -100,
//                 child: FadeTransition(
//                   opacity: controller.bgCircleFadeAnim,
//                   child: DecorCircle(size: 250),
//                 ),
//               ),
//
//               // ── Centre logo + text ──
//               Center(
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     // Logo circle with scale + fade
//                     FadeTransition(
//                       opacity: controller.scaleAnim,
//                       child: ScaleTransition(
//                         scale: controller.scaleAnim,
//                         child: Image.asset(AppImages.appLogo,height: 200,),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
//
// class DecorCircle extends StatelessWidget {
//   final double size;
//
//   const DecorCircle({required this.size});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: size,
//       height: size,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         border: Border.all(color: const Color(0xFFDDDDDD), width: 1.5),
//       ),
//     );
//   }
// }


/// Shorts - Video ////

import 'package:flutter/material.dart';
import 'package:furniture_app/app/utils/app_image.dart';
import 'package:furniture_app/modules/splash/splash_controller.dart';
import 'package:get/get.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedBuilder(
        animation: controller.animController,
        builder: (context, _) {
          return Stack(
            fit: StackFit.expand,
            children: [
              SplashDecorCircles(bgCircleFadeAnim: controller.bgCircleFadeAnim),
              SplashLogo(scaleAnim: controller.scaleAnim)
            ],
          );
        },
      ),
    );
  }
}

// ── Decorative circles (top-right + bottom-left) ──
class SplashDecorCircles extends StatelessWidget {
  final Animation<double> bgCircleFadeAnim;

  const SplashDecorCircles({required this.bgCircleFadeAnim});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          top: -80,
          right: -80,
          child: FadeTransition(
            opacity: bgCircleFadeAnim,
            child: const DecorCircle(size: 220),
          ),
        ),
        Positioned(
          bottom: -100,
          left: -100,
          child: FadeTransition(
            opacity: bgCircleFadeAnim,
            child: const DecorCircle(size: 250),
          ),
        ),
      ],
    );
  }
}

// ── Animated center logo ──
class SplashLogo extends StatelessWidget {
  final Animation<double> scaleAnim;

  const SplashLogo({required this.scaleAnim});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: scaleAnim,
        child: ScaleTransition(
          scale: scaleAnim,
          child: Image.asset(AppImages.appLogo, height: 200),
        ),
      ),
    );
  }
}

// ── Reusable decorative circle widget ──
class DecorCircle extends StatelessWidget {
  final double size;

  const DecorCircle({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFFDDDDDD),
          width: 1.5,
        ),
      ),
    );
  }
}