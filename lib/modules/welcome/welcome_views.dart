/// Long Video ///

// import 'package:flutter/material.dart';
// import 'package:furniture_app/app/utils/app_colors.dart';
// import 'package:get/get.dart';
// import 'package:furniture_app/modules/welcome/welcome_controller.dart';
// import '../../app/widgets/custom_button.dart';
// import '../../app/widgets/app_styles.dart';
//
// class WelcomeView extends GetView<WelcomeController> {
//   const WelcomeView({super.key});
//
//   static const String mainImg =
//       'https://i.pinimg.com/736x/e9/31/17/e93117979b8025446e1e0fa2846f7340.jpg';
//
//   // Small oval images
//   static const String topRightImg =
//       'https://i.pinimg.com/1200x/15/05/76/150576f629c796a32862a8ace31306ab.jpg'; // kitchen/shelf
//   static const String bottomLeftImg =
//       'https://i.pinimg.com/736x/dc/38/7a/dc387a0727bf6b09a27ecbbc32c439f8.jpg'; // green plant/sofa
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           /// ===== TOP-LEFT DECORATIVE BORDER ARC =====
//           Positioned(
//             top: -70,
//             left: -60,
//             child: Container(
//               width: 200,
//               height: 160,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(
//                   color: Colors.black.withOpacity(0.15),
//                   width: 1.5,
//                 ),
//                 color: Colors.transparent,
//               ),
//             ),
//           ),
//
//           /// ===== BOTTOM-RIGHT DECORATIVE BORDER ARC =====
//           Positioned(
//             bottom: -60,
//             right: -90,
//             child: Container(
//               width: 250,
//               height: 140,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(
//                   color: Colors.black.withOpacity(0.15),
//                   width: 1.5,
//                 ),
//                 color: Colors.transparent,
//               ),
//             ),
//           ),
//
//           /// ===== MAIN SCROLLABLE CONTENT =====
//           Center(
//             child: ListView(
//               shrinkWrap: true,
//               children: [
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const SizedBox(height: 100),
//
//                     /// ===== OVAL IMAGE SECTION WITH DECORATIVE OVALS =====
//                     SizedBox(
//                       width: screenWidth,
//                       height: 420,
//                       child: Stack(
//                         clipBehavior: Clip.none,
//                         alignment: Alignment.center,
//                         children: [
//                           /// --- RIGHT-SIDE BORDER OFFSET OVAL (behind main image) ---
//                           Positioned(
//                             left: screenWidth / 2 - 140 + 12,
//                             top: 0,
//                             child: Container(
//                               width: 280,
//                               height: 360,
//                               decoration: BoxDecoration(
//                                 borderRadius: const BorderRadius.all(
//                                   Radius.elliptical(280, 360),
//                                 ),
//                                 border: Border.all(
//                                   color: Colors.black.withOpacity(0.5),
//                                   width: 1.5,
//                                 ),
//                               ),
//                             ),
//                           ),
//
//                           /// --- MAIN CENTER OVAL IMAGE ---
//                           Positioned(
//                             left: screenWidth / 2 - 140,
//                             top: 0,
//                             child: Container(
//                               width: 280,
//                               height: 360,
//                               decoration: const BoxDecoration(
//                                 borderRadius: BorderRadius.all(
//                                   Radius.elliptical(280, 360),
//                                 ),
//                                 image: DecorationImage(
//                                   image: NetworkImage(mainImg),
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                           ),
//
//                           /// --- TOP-RIGHT SMALL OVAL (half visible, top-right edge) ---
//                           Positioned(
//                             top: -10,
//                             right: -10,
//                             child: ClipRect(
//                               child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 widthFactor: 0.6,
//                                 child: Transform.rotate(
//                                   angle: 0.3,
//                                   child: Container(
//                                     width: 110,
//                                     height: 130,
//                                     decoration: BoxDecoration(
//                                       borderRadius: const BorderRadius.all(
//                                         Radius.elliptical(110, 130),
//                                       ),
//                                       image: const DecorationImage(
//                                         image: NetworkImage(topRightImg),
//                                         fit: BoxFit.cover,
//                                       ),
//                                       border: Border.all(
//                                         color: Colors.white,
//                                         width: 3,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//
//                           /// --- BOTTOM-LEFT SMALL OVAL (rotated, half visible) ---
//                           Positioned(
//                             bottom: 10,
//                             left: -10,
//                             child: ClipRect(
//                               child: Align(
//                                 alignment: Alignment.centerRight,
//                                 widthFactor: 0.55,
//                                 child: Transform.rotate(
//                                   angle: -0.3,
//                                   child: Container(
//                                     width: 120,
//                                     height: 145,
//                                     decoration: BoxDecoration(
//                                       borderRadius: const BorderRadius.all(
//                                         Radius.elliptical(120, 145),
//                                       ),
//                                       image: const DecorationImage(
//                                         image: NetworkImage(bottomLeftImg),
//                                         fit: BoxFit.cover,
//                                       ),
//                                       border: Border.all(
//                                         color: Colors.white,
//                                         width: 3,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//
//                           /// --- ARROW BUTTON (bottom-right of main oval) ---
//                           Positioned(
//                             bottom: 78,
//                             right: screenWidth / 2 - 125 - 10,
//                             child: GestureDetector(
//                               onTap: controller.onGetStarted,
//                               child: Transform.rotate(
//                                 angle: -0.8,
//                                 child: Container(
//                                   width: 60,
//                                   height: 60,
//                                   decoration: BoxDecoration(
//                                     color: AppColors.appColor,
//                                     shape: BoxShape.circle,
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.black.withOpacity(0.25),
//                                         blurRadius: 10,
//                                         offset: const Offset(0, 5),
//                                       ),
//                                     ],
//                                   ),
//                                   child: const Icon(
//                                     Icons.arrow_forward,
//                                     color: Colors.white,
//                                     size: 28,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     const SizedBox(height: 40),
//
//                     /// ===== TITLE =====
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 40),
//                       child: Text(
//                         'The Furniture App That\nElevates Your Home',
//                         textAlign: TextAlign.center,
//                           style: AppStyles.titleText(
//                             fontSize: 20,
//                             fontWeight: FontWeight.w700,
//                             color: AppColors.appColor,
//                           )
//                       ),
//                     ),
//
//                     const SizedBox(height: 20),
//
//                     /// ===== DESCRIPTION =====
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 40),
//                       child: Text(
//                         'Lorem ipsum dolor sit amet, consectetur\nadipiscing elit, sed do eiusmod tempor incididunt',
//                         textAlign: TextAlign.center,
//                           style: AppStyles.bodyText(
//                             fontSize: 14,
//                             color: const Color(0xFF707F81),
//                           )
//                       ),
//                     ),
//
//                     const SizedBox(height: 20),
//
//                     /// ===== CTA BUTTON =====
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 40),
//                       child: CustomButton(
//                         borderRadius: 60,
//                         text: "Let's Get Started",
//                         onPressed: controller.onGetStarted,
//                       ),
//                     ),
//
//                     const SizedBox(height: 20),
//
//                     /// ===== SIGN IN =====
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           'Already have an account? ',
//                             style: AppStyles.bodyText(
//                               fontSize: 15,
//                               color: const Color(0xFF707F81),
//                             )
//                         ),
//                         GestureDetector(
//                           onTap: controller.onSignIn,
//                           child:  Text(
//                             'Sign In',
//                               style: AppStyles.bodyText(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w600,
//                                 color: const Color(0xFF3C5A5D),
//                                 decoration: TextDecoration.underline,
//                               )
//                           ),
//                         ),
//                       ],
//                     ),
//
//                     const SizedBox(height: 20),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


/// Shorts Video ///

import 'package:flutter/material.dart';
import 'package:furniture_app/app/utils/app_colors.dart';
import 'package:get/get.dart';
import 'package:furniture_app/modules/welcome/welcome_controller.dart';
import '../../app/widgets/custom_button.dart';
import '../../app/widgets/app_styles.dart';

class WelcomeView extends GetView<WelcomeController> {
  const WelcomeView({super.key});

  static const String mainImg =
      'https://i.pinimg.com/736x/e9/31/17/e93117979b8025446e1e0fa2846f7340.jpg';
  static const String topRightImg =
      'https://i.pinimg.com/1200x/15/05/76/150576f629c796a32862a8ace31306ab.jpg';
  static const String bottomLeftImg =
      'https://i.pinimg.com/736x/dc/38/7a/dc387a0727bf6b09a27ecbbc32c439f8.jpg';

  // ─────────────────────────────────────────
  // BUILD: Top-left decorative arc
  // ─────────────────────────────────────────
  Widget buildTopLeftArc() {
    return Positioned(
      top: -70,
      left: -60,
      child: Container(
        width: 200,
        height: 160,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.black.withOpacity(0.15),
            width: 1.5,
          ),
          color: Colors.transparent,
        ),
      ),
    );
  }

  // ─────────────────────────────────────────
  // BUILD: Bottom-right decorative arc
  // ─────────────────────────────────────────
  Widget buildBottomRightArc() {
    return Positioned(
      bottom: -60,
      right: -90,
      child: Container(
        width: 250,
        height: 140,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.black.withOpacity(0.15),
            width: 1.5,
          ),
          color: Colors.transparent,
        ),
      ),
    );
  }

  // ─────────────────────────────────────────
  // BUILD: Offset border oval behind main image
  // ─────────────────────────────────────────
  Widget _buildOffsetBorderOval(double screenWidth) {
    return Positioned(
      left: screenWidth / 2 - 140 + 12,
      top: 0,
      child: Container(
        width: 280,
        height: 360,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.elliptical(280, 360)),
          border: Border.all(
            color: Colors.black.withOpacity(0.5),
            width: 1.5,
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────
  // BUILD: Main center oval image
  // ─────────────────────────────────────────
  Widget _buildMainOvalImage(double screenWidth) {
    return Positioned(
      left: screenWidth / 2 - 140,
      top: 0,
      child: Container(
        width: 280,
        height: 360,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.elliptical(280, 360)),
          image: DecorationImage(
            image: NetworkImage(mainImg),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────
  // BUILD: Top-right small oval image
  // ─────────────────────────────────────────
  Widget _buildTopRightSmallOval() {
    return Positioned(
      top: -10,
      right: -10,
      child: ClipRect(
        child: Align(
          alignment: Alignment.centerLeft,
          widthFactor: 0.6,
          child: Transform.rotate(
            angle: 0.3,
            child: Container(
              width: 110,
              height: 130,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.elliptical(110, 130)),
                image: const DecorationImage(
                  image: NetworkImage(topRightImg),
                  fit: BoxFit.cover,
                ),
                border: Border.all(color: Colors.white, width: 3),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────
  // BUILD: Bottom-left small oval image
  // ─────────────────────────────────────────
  Widget _buildBottomLeftSmallOval() {
    return Positioned(
      bottom: 10,
      left: -10,
      child: ClipRect(
        child: Align(
          alignment: Alignment.centerRight,
          widthFactor: 0.55,
          child: Transform.rotate(
            angle: -0.3,
            child: Container(
              width: 120,
              height: 145,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.elliptical(120, 145)),
                image: const DecorationImage(
                  image: NetworkImage(bottomLeftImg),
                  fit: BoxFit.cover,
                ),
                border: Border.all(color: Colors.white, width: 3),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────
  // BUILD: Arrow button (bottom-right of oval)
  // ─────────────────────────────────────────
  Widget _buildArrowButton(double screenWidth) {
    return Positioned(
      bottom: 78,
      right: screenWidth / 2 - 125 - 10,
      child: GestureDetector(
        onTap: controller.onGetStarted,
        child: Transform.rotate(
          angle: -0.8,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.appColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Icon(Icons.arrow_forward, color: Colors.white, size: 28),
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────
  // BUILD: Full image section (all ovals + arrow)
  // ─────────────────────────────────────────
  Widget buildImageSection(double screenWidth) {
    return SizedBox(
      width: screenWidth,
      height: 420,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          _buildOffsetBorderOval(screenWidth),
          _buildMainOvalImage(screenWidth),
          _buildTopRightSmallOval(),
          _buildBottomLeftSmallOval(),
          _buildArrowButton(screenWidth),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  // BUILD: Title text
  // ─────────────────────────────────────────
  Widget buildTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Text(
        'The Furniture App That\nElevates Your Home',
        textAlign: TextAlign.center,
        style: AppStyles.titleText(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.appColor,
        ),
      ),
    );
  }

  // ─────────────────────────────────────────
  // BUILD: Description text
  // ─────────────────────────────────────────
  Widget buildDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Text(
        'Lorem ipsum dolor sit amet, consectetur\nadipiscing elit, sed do eiusmod tempor incididunt',
        textAlign: TextAlign.center,
        style: AppStyles.bodyText(
          fontSize: 14,
          color: const Color(0xFF707F81),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────
  // BUILD: CTA button
  // ─────────────────────────────────────────
  Widget buildGetStartedButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: CustomButton(
        borderRadius: 60,
        text: "Let's Get Started",
        onPressed: controller.onGetStarted,
      ),
    );
  }

  // ─────────────────────────────────────────
  // BUILD: Sign in row
  // ─────────────────────────────────────────
  Widget buildSignInRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account? ',
          style: AppStyles.bodyText(
            fontSize: 15,
            color: const Color(0xFF707F81),
          ),
        ),
        GestureDetector(
          onTap: controller.onSignIn,
          child: Text(
            'Sign In',
            style: AppStyles.bodyText(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF3C5A5D),
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  // ─────────────────────────────────────────
  // MAIN BUILD
  // ─────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          buildTopLeftArc(),
          buildBottomRightArc(),

          Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 100,),
                    buildImageSection(screenWidth),
                    SizedBox(height: 40,),
                    buildTitle(),
                    SizedBox(height: 20,),
                    buildDescription(),
                    SizedBox(height: 20,),
                    buildGetStartedButton(),
                    SizedBox(height: 20,),
                    buildSignInRow()

                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}