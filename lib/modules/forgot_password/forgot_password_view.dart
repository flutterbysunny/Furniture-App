import 'package:flutter/material.dart';
import 'package:furniture_app/app/widgets/app_styles.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../app/utils/app_colors.dart';
import '../../app/widgets/custom_button.dart';
import '../../app/widgets/custom_textfields.dart';
import 'forgot_password_controller.dart';

// class ForgotPasswordView extends GetView<ForgotPasswordController> {
//   const ForgotPasswordView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0),
//           child: Form(
//             key: controller.formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 16),
//
//                 // ── Back Button ──
//                 GestureDetector(
//                   onTap: controller.goBack,
//                   child: Container(
//                     width: 44,
//                     height: 44,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(
//                         color: AppColors.appSoftColor,
//                         width: 1.0,
//                       ),
//                       color: AppColors.white,
//                     ),
//                     child: const Icon(
//                       Icons.arrow_back_ios_new_rounded,
//                       size: 18,
//                       color: Colors.black87,
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(height: 36),
//
//                 const SizedBox(height: 32),
//
//                 // ── Title ──
//                 Center(
//                   child: Text(
//                     'Forgot Password?',
//                     style: AppStyles.titleText(
//                       color: AppColors.blackColor,
//                       fontSize: 18.sp,
//                       fontWeight: FontWeight.w700
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 const Center(
//                   child: Text(
//                     "Don't worry! It happens. Please enter the\nemail address linked with your account.",
//                     style: TextStyle(fontSize: 14, color: Colors.grey),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//
//                 const SizedBox(height: 40),
//
//                 // ── Email Field ──
//                 CustomTextField(
//                   label: 'Email',
//                   controller: controller.emailController,
//                   hintText: 'example@gmail.com',
//                   keyboardType: TextInputType.emailAddress,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your email';
//                     }
//                     if (!GetUtils.isEmail(value)) {
//                       return 'Please enter a valid email';
//                     }
//                     return null;
//                   },
//                 ),
//
//                 const SizedBox(height: 32),
//
//                 // ── Send Button ──
//                 Obx(
//                   () => CustomButton(
//                     text: 'Send Reset Link',
//                     borderRadius: 50,
//                     backgroundColor: const Color(0xFF3B6B5E),
//                     isLoading: controller.isLoading.value,
//                     onPressed: controller.sendResetLink,
//                   ),
//                 ),
//
//                 const SizedBox(height: 40),
//
//                 // ── Back to Sign In ──
//                 Center(
//                   child: GestureDetector(
//                     onTap: controller.goBack,
//                     child: RichText(
//                       text: const TextSpan(
//                         text: 'Remember password? ',
//                         style: TextStyle(fontSize: 14, color: Colors.black87),
//                         children: [
//                           TextSpan(
//                             text: 'Sign In',
//                             style: TextStyle(
//                               color: Color(0xFF3B6B5E),
//                               fontWeight: FontWeight.w600,
//                               decoration: TextDecoration.underline,
//                               decorationColor: Color(0xFF3B6B5E),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(height: 32),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});

  // ── Root ──────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16,),
                buildBackButton(),
                SizedBox(height: 36,),
                buildTitle(),
                SizedBox(height: 40,),
                buildEmailField(),
                SizedBox(height: 32,),
                buildSendButton(),
                SizedBox(height: 40,),
                buildSignInLink(),
                SizedBox(height: 32,)
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Back button ───────────────────────────────────────
  Widget buildBackButton() {
    return GestureDetector(
      onTap: controller.goBack,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.appSoftColor,
            width: 1.0,
          ),
          color: AppColors.white,
        ),
        child: const Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 18,
          color: Colors.black87,
        ),
      ),
    );
  }

  // ── Title + subtitle ──────────────────────────────────
  Widget buildTitle() {
    return Column(
      children: [
        Center(
          child: Text(
            'Forgot Password?',
            style: AppStyles.titleText(
              color: AppColors.blackColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 12),
        const Center(
          child: Text(
            "Don't worry! It happens. Please enter the\nemail address linked with your account.",
            style: TextStyle(fontSize: 14, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  // ── Email field ───────────────────────────────────────
  Widget buildEmailField() {
    return CustomTextField(
      label: 'Email',
      controller: controller.emailController,
      hintText: 'example@gmail.com',
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Please enter your email';
        if (!GetUtils.isEmail(value)) return 'Please enter a valid email';
        return null;
      },
    );
  }

  // ── Send reset link button ────────────────────────────
  Widget buildSendButton() {
    return Obx(
          () => CustomButton(
        text: 'Send Reset Link',
        borderRadius: 50,
        backgroundColor: const Color(0xFF3B6B5E),
        isLoading: controller.isLoading.value,
        onPressed: controller.sendResetLink,
      ),
    );
  }

  // ── "Remember password? Sign In" link ─────────────────
  Widget buildSignInLink() {
    return Center(
      child: GestureDetector(
        onTap: controller.goBack,
        child: RichText(
          text: const TextSpan(
            text: 'Remember password? ',
            style: TextStyle(fontSize: 14, color: Colors.black87),
            children: [
              TextSpan(
                text: 'Sign In',
                style: TextStyle(
                  color: Color(0xFF3B6B5E),
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                  decorationColor: Color(0xFF3B6B5E),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}