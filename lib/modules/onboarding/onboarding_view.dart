// import 'package:flutter/material.dart';
// import 'package:furniture_app/app/utils/app_colors.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:sizer/sizer.dart';
// import '../../app/widgets/onboarding_mockup/mokup_2.dart';
// import '../../app/widgets/onboarding_mockup/mokup_3.dart';
// import '../../app/widgets/onboarding_mockup/mokupe_1.dart';
// import 'onboarding_controller.dart';
//
// class OnboardingView extends GetView<OnboardingController> {
//   const OnboardingView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.bgColor,
//       body: Stack(
//         children: [
//           // PageView
//           PageView(
//             controller: controller.pageController,
//             onPageChanged: controller.onPageChanged,
//             children: const [
//               OnboardingPage(index: 0),
//               OnboardingPage(index: 1),
//               OnboardingPage(index: 2),
//             ],
//           ),
//           // Skip button
//           Positioned(
//             top: 60,
//             right: 20,
//             child: GestureDetector(
//               onTap: controller.skipOnboarding,
//               child: Text(
//                 'Skip',
//                 style: GoogleFonts.poppins(
//                   fontSize: 15,
//                   color: AppColors.appColor,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//           ),
//           // Bottom nav
//           Positioned(
//             bottom: 24,
//             left: 24,
//             right: 24,
//             child: Obx(() => BottomNavRow(
//               currentPage: controller.currentPage.value,
//               totalPages: controller.pages.length,
//               onNext: controller.nextPage,
//               onPrev: controller.previousPage,
//             )),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class OnboardingPage extends GetView<OnboardingController> {
//   final int index;
//   const OnboardingPage({required this.index});
//
//   @override
//   Widget build(BuildContext context) {
//     final page = controller.pages[index];
//
//     final mockupWidgets = [
//       const Screen1MockupWidget(),
//       const Screen2MockupWidget(),
//       const Screen3MockupWidget(),
//     ];
//
//     return Stack(
//       children: [
//
//         /// Bottom Curved Section
//
//
//         /// Orbit decoration
//
//
//         /// Phone Mockup (OVERLAP)
//         Positioned(
//           top: 200,
//           left: 0,
//           right: 0,
//           child: Center(
//             child: mockupWidgets[index],
//           ),
//         ),
//         Positioned(
//           top: 180,
//           left: 0,
//           right: 0,
//           child: Center(
//             child: CustomPaint(
//               size: const Size(320, 320),
//               painter: OrbitPainter(),
//             ),
//           ),
//         ),
//
//         Align(
//           alignment: Alignment.bottomCenter,
//           child: ClipPath(
//             clipper: TopBezierClipper(),
//             child: Container(
//               height: MediaQuery.of(context).size.height * 0.50,
//               width: double.infinity,
//               color: AppColors.white,
//               padding: const EdgeInsets.fromLTRB(28, 120, 0, 80),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   SizedBox(height: 40,),
//                   /// Title
//                   RichText(
//                     textAlign: TextAlign.center,
//                     text: TextSpan(
//                       style: GoogleFonts.poppins(
//                         fontSize: 20.sp,
//                         fontWeight: FontWeight.w800,
//                         color: AppColors.blackColor,
//                         height: 1.2,
//                       ),
//                       children: [
//                         TextSpan(text: '${page.title}\n'),
//                         if (page.titleColored.isNotEmpty)
//                           TextSpan(
//                             text: page.titleColored,
//                             style: const TextStyle(
//                               color: AppColors.appColor,
//                             ),
//                           ),
//                         if (page.titleEnd.isNotEmpty)
//                           TextSpan(text: ' ${page.titleEnd}'),
//                       ],
//                     ),
//                   ),
//
//                   const SizedBox(height: 12),
//
//                   /// Description
//                   Center(
//                     child: Text(
//                       page.description,
//                       textAlign: TextAlign.center,
//                       style: GoogleFonts.poppins(
//                         fontSize: 13,
//                         color: AppColors.grey,
//                         height: 1.6,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class BottomNavRow extends StatelessWidget {
//   final int currentPage;
//   final int totalPages;
//   final VoidCallback onNext;
//   final VoidCallback onPrev;
//
//   const BottomNavRow({
//     required this.currentPage,
//     required this.totalPages,
//     required this.onNext,
//     required this.onPrev,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//
//         /// Back button (hide on last page)
//         currentPage == totalPages - 1
//             ? const SizedBox(width: 54)
//             : GestureDetector(
//           onTap: onPrev,
//           child: Container(
//             width: 54,
//             height: 54,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               border: Border.all(color: AppColors.lightGrey, width: 1.5),
//               color: AppColors.white,
//             ),
//             child: const Icon(
//               Icons.arrow_back,
//               color: AppColors.black,
//               size: 22,
//             ),
//           ),
//         ),
//
//         /// Dots
//         Row(
//           children: List.generate(
//             totalPages,
//                 (i) => AnimatedContainer(
//               duration: const Duration(milliseconds: 300),
//               margin: const EdgeInsets.symmetric(horizontal: 4),
//               width: i == currentPage ? 20 : 8,
//               height: 8,
//               decoration: BoxDecoration(
//                 color: i == currentPage
//                     ? AppColors.appColor
//                     : AppColors.lightGrey,
//                 borderRadius: BorderRadius.circular(4),
//               ),
//             ),
//           ),
//         ),
//
//         /// Next button
//         GestureDetector(
//           onTap: onNext,
//           child: Container(
//             width: 54,
//             height: 54,
//             decoration: const BoxDecoration(
//               shape: BoxShape.circle,
//               color: AppColors.appColor,
//             ),
//             child: const Icon(
//               Icons.arrow_forward,
//               color: AppColors.white,
//               size: 22,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class OrbitPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.grey.withOpacity(0.2)
//       ..strokeWidth = 1.2
//       ..style = PaintingStyle.stroke;
//
//     final path = Path();
//     path.addOval(
//       Rect.fromCenter(
//         center: Offset(size.width / 2, size.height / 2),
//         width: size.width,
//         height: size.height * 0.55,
//       ),
//     );
//
//     canvas.save();
//     canvas.translate(size.width / 2, size.height / 2);
//     canvas.rotate(-0.3);
//     canvas.translate(-size.width / 2, -size.height / 2);
//     canvas.drawPath(path, paint);
//     canvas.restore();
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
//
// class TopBezierClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//
//     double curveHeight = 80;
//
//     path.moveTo(0, curveHeight); // P0
//
//     path.quadraticBezierTo(
//       size.width / 2,      // P1 X
//       curveHeight + 80,    // P1 Y (niche control point)
//       size.width,          // P2 X
//       curveHeight,         // P2 Y
//     );
//
//     path.lineTo(size.width, size.height);
//     path.lineTo(0, size.height);
//
//     path.close();
//
//     return path;
//   }
//
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }

import 'package:flutter/material.dart';
import 'package:furniture_app/app/utils/app_colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../../app/widgets/bottom_nav_row.dart';
import '../../app/widgets/onboarding_mockup/mokup_2.dart';
import '../../app/widgets/onboarding_mockup/mokup_3.dart';
import '../../app/widgets/onboarding_mockup/mokupe_1.dart';
import '../../app/widgets/orbit_poiter.dart';
import '../../app/widgets/top_bezier_clipper.dart';
import 'onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Stack(
        children: [
          buildPageView(),
          buildSkipButton(),
          buildBottomNav(),
        ],
      ),
    );
  }

  /// PageView with all onboarding pages
  Widget buildPageView() {
    return PageView(
      controller: controller.pageController,
      onPageChanged: controller.onPageChanged,
      children: const [
        OnboardingPage(index: 0),
        OnboardingPage(index: 1),
        OnboardingPage(index: 2),

      ],
    );
  }

  /// Skip button positioned top-right
  Widget buildSkipButton() {
    return Positioned(
      top: 60,
      right: 20,
      child: GestureDetector(
        onTap: controller.skipOnboarding,
        child: Text(
          'Skip',
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: AppColors.appColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  /// Bottom nav with dots and arrows
  Widget buildBottomNav() {
    return Positioned(
      bottom: 24,
      left: 24,
      right: 24,
      child: Obx(() => BottomNavRow(
        currentPage: controller.currentPage.value,
        totalPages: controller.pages.length,
        onNext: controller.nextPage,
        onPrev: controller.previousPage,
      )),
    );
  }
}

// ─────────────────────────────────────────────
// OnboardingPage
// ─────────────────────────────────────────────

class OnboardingPage extends GetView<OnboardingController> {
  final int index;
  const OnboardingPage({required this.index});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildMockup(),
        buildOrbit(),
        buildBottomCard(context)


      ],
    );
  }

  /// Phone mockup widget centered on screen
  Widget buildMockup() {
    final mockupWidgets = [
      const Screen1MockupWidget(),
      const Screen2MockupWidget(),
      const Screen3MockupWidget(),
    ];

    return Positioned(
      top: 200,
      left: 0,
      right: 0,
      child: Center(
        child: mockupWidgets[index],
      ),
    );
  }

  /// Elliptical orbit ring drawn with CustomPainter
  Widget buildOrbit() {
    return Positioned(
      top: 180,
      left: 0,
      right: 0,
      child: Center(
        child: CustomPaint(
          size: const Size(320, 320),
          painter: OrbitPainter(),
        ),
      ),
    );
  }

  /// White curved bottom card with title and description
  Widget buildBottomCard(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ClipPath(
        clipper: TopBezierClipper(),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.50,
          width: double.infinity,
          color: AppColors.white,
          padding: const EdgeInsets.fromLTRB(28, 120, 0, 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40,),
              buildTitle(),
              SizedBox(height: 12,),
              buildDescription()

            ],
          ),
        ),
      ),
    );
  }

  /// RichText title with optional colored segment
  Widget buildTitle() {
    final page = controller.pages[index];

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: GoogleFonts.poppins(
          fontSize: 20.sp,
          fontWeight: FontWeight.w800,
          color: AppColors.blackColor,
          height: 1.2,
        ),
        children: [
          TextSpan(text: '${page.title}\n'),
          if (page.titleColored.isNotEmpty)
            TextSpan(
              text: page.titleColored,
              style: const TextStyle(color: AppColors.appColor),
            ),
          if (page.titleEnd.isNotEmpty)
            TextSpan(text: ' ${page.titleEnd}'),
        ],
      ),
    );
  }

  /// Grey description text centered below title
  Widget buildDescription() {
    final page = controller.pages[index];

    return Center(
      child: Text(
        page.description,
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          fontSize: 13,
          color: AppColors.grey,
          height: 1.6,
        ),
      ),
    );
  }
}





