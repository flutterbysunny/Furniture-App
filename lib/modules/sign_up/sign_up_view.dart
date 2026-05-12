import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../app/utils/app_colors.dart';
import '../../app/utils/app_image.dart';
import '../../app/widgets/app_styles.dart';
import '../../app/widgets/custom_button.dart';
import '../../app/widgets/custom_textfields.dart';
import '../../app/widgets/social_button.dart';
import 'sign_up_controller.dart';

// class SignUpView extends GetView<SignUpController> {
//   const SignUpView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         bottom: false,
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0),
//           child: Form(
//             key: controller.formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const SizedBox(height: 80),
//
//                 // ── Title ──
//                  Text(
//                   'Create Account',
//                   style: AppStyles.titleText(
//                       color: AppColors.blackColor,
//                       fontSize: 18.sp,
//                       fontWeight: FontWeight.w700
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 const Text(
//                   'Fill your information below or register\nwith your social account.',
//                   style: TextStyle(fontSize: 14, color: Colors.grey),
//                   textAlign: TextAlign.center,
//                 ),
//
//                 const SizedBox(height: 32),
//
//                 // ── Name Field ──
//                 CustomTextField(
//                   label: 'Name',
//                   controller: controller.nameController,
//                   hintText: 'John Doe',
//                   keyboardType: TextInputType.name,
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'Please enter your name';
//                     }
//                     return null;
//                   },
//                 ),
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
//                 // ── Password Field ──
//                 CustomTextField(
//                   label: 'Password',
//                   controller: controller.passwordController,
//                   hintText: '••••••••••••••••',
//                   isPassword: true,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your password';
//                     }
//                     if (value.length < 6) {
//                       return 'Password must be at least 6 characters';
//                     }
//                     return null;
//                   },
//                 ),
//
//                 const SizedBox(height: 8),
//
//                 // ── Terms & Conditions Checkbox ──
//                 Obx(
//                       () => Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       GestureDetector(
//                         onTap: () => controller.isAgreed.toggle(),
//                         child: AnimatedContainer(
//                           duration: const Duration(milliseconds: 200),
//                           width: 22,
//                           height: 22,
//                           decoration: BoxDecoration(
//                             color: controller.isAgreed.value
//                                 ? const Color(0xFF3B6B5E)
//                                 : Colors.white,
//                             borderRadius: BorderRadius.circular(5),
//                             border: Border.all(
//                               color: controller.isAgreed.value
//                                   ? const Color(0xFF3B6B5E)
//                                   : const Color(0xFFCCCCCC),
//                               width: 2,
//                             ),
//                           ),
//                           child: controller.isAgreed.value
//                               ? const Icon(
//                             Icons.check,
//                             size: 14,
//                             color: Colors.white,
//                           )
//                               : null,
//                         ),
//                       ),
//                       const SizedBox(width: 10),
//                       Text(
//                         'Agree with ',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.grey[700],
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: controller.onTermsTap,
//                         child: const Text(
//                           'Terms & Condition',
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Color(0xFF3B6B5E),
//                             fontWeight: FontWeight.w600,
//                             decoration: TextDecoration.underline,
//                             decorationColor: Color(0xFF3B6B5E),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 const SizedBox(height: 28),
//
//                 // ── Sign Up Button ──
//                 Obx(
//                       () => CustomButton(
//                     text: 'Sign Up',
//                     borderRadius: 50,
//                     backgroundColor: const Color(0xFF3B6B5E),
//                     isLoading: controller.isLoading.value,
//                     onPressed: controller.signUp,
//                   ),
//                 ),
//
//                 const SizedBox(height: 30),
//
//                 // ── Or Sign Up With ──
//                 Row(
//                   children: const [
//                     Expanded(child: Divider(color: Color(0xFFDDDDDD))),
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 12),
//                       child: Text(
//                         'Or sign up with',
//                         style: TextStyle(fontSize: 13, color: Colors.grey),
//                       ),
//                     ),
//                     Expanded(child: Divider(color: Color(0xFFDDDDDD))),
//                   ],
//                 ),
//
//                 const SizedBox(height: 24),
//
//                 // ── Social Buttons ──
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SocialButton(
//                         onTap: controller.signUpWithApple,
//                         child: Image.asset(AppImages.appleLogo,height: 25)
//
//                     ),
//                     const SizedBox(width: 20),
//                     SocialButton(
//                         onTap: controller.signUpWithGoogle,
//                         child: Image.asset(AppImages.googleLogo,height: 25)
//                     ),
//                     const SizedBox(width: 20),
//                     SocialButton(
//                         onTap: controller.signUpWithFacebook,
//                         child: Image.asset(AppImages.fbLogo,height: 25)
//                     ),
//                   ],
//                 ),
//
//                 const SizedBox(height: 32),
//
//                 // ── Sign In Link ──
//                 GestureDetector(
//                   onTap: controller.goToSignIn,
//                   child: RichText(
//                     text: const TextSpan(
//                       text: 'Already  have an account? ',
//                       style: TextStyle(fontSize: 14, color: Colors.black87),
//                       children: [
//                         TextSpan(
//                           text: 'Sign In',
//                           style: TextStyle(
//                             color: Color(0xFF3B6B5E),
//                             fontWeight: FontWeight.w600,
//                             decoration: TextDecoration.underline,
//                             decorationColor: Color(0xFF3B6B5E),
//                           ),
//                         ),
//                       ],
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

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});

  // ── Root ──────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 80,),
                buildTitle(),
                SizedBox(height: 32,),
                buildNameField(),
                buildEmailField(),
                buildPasswordField(),
                SizedBox(height: 8,),
                buildTermsCheckbox(),
                SizedBox(height: 28,),
                buildSignUpButton(),
                SizedBox(height: 30,),
                buildDivider(),
                SizedBox(height: 24,),
                buildSocialButtons(),
                SizedBox(height: 32,),
                buildSignInLink(),
                SizedBox(height: 32,)

              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Title + subtitle ──────────────────────────────────
  Widget buildTitle() {
    return Column(
      children: [
        Text(
          'Create Account',
          style: AppStyles.titleText(
            color: AppColors.blackColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Fill your information below or register\nwith your social account.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // ── Name field ────────────────────────────────────────
  Widget buildNameField() {
    return CustomTextField(
      label: 'Name',
      controller: controller.nameController,
      hintText: 'John Doe',
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value == null || value.trim().isEmpty) return 'Please enter your name';
        return null;
      },
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

  // ── Password field ────────────────────────────────────
  Widget buildPasswordField() {
    return CustomTextField(
      label: 'Password',
      controller: controller.passwordController,
      hintText: '••••••••••••••••',
      isPassword: true,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Please enter your password';
        if (value.length < 6) return 'Password must be at least 6 characters';
        return null;
      },
    );
  }

  // ── Terms & Conditions checkbox ───────────────────────
  Widget buildTermsCheckbox() {
    return Obx(
          () => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => controller.isAgreed.toggle(),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: controller.isAgreed.value
                    ? const Color(0xFF3B6B5E)
                    : Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: controller.isAgreed.value
                      ? const Color(0xFF3B6B5E)
                      : const Color(0xFFCCCCCC),
                  width: 2,
                ),
              ),
              child: controller.isAgreed.value
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'Agree with ',
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
          GestureDetector(
            onTap: controller.onTermsTap,
            child: const Text(
              'Terms & Condition',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF3B6B5E),
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
                decorationColor: Color(0xFF3B6B5E),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Sign-up button ────────────────────────────────────
  Widget buildSignUpButton() {
    return Obx(
          () => CustomButton(
        text: 'Sign Up',
        borderRadius: 50,
        backgroundColor: const Color(0xFF3B6B5E),
        isLoading: controller.isLoading.value,
        onPressed: controller.signUp,
      ),
    );
  }

  // ── "Or sign up with" divider ─────────────────────────
  Widget buildDivider() {
    return Row(
      children: const [
        Expanded(child: Divider(color: Color(0xFFDDDDDD))),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'Or sign up with',
            style: TextStyle(fontSize: 13, color: Colors.grey),
          ),
        ),
        Expanded(child: Divider(color: Color(0xFFDDDDDD))),
      ],
    );
  }

  // ── Social buttons ────────────────────────────────────
  Widget buildSocialButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialButton(
          onTap: controller.signUpWithApple,
          child: Image.asset(AppImages.appleLogo, height: 25),
        ),
        const SizedBox(width: 20),
        SocialButton(
          onTap: controller.signUpWithGoogle,
          child: Image.asset(AppImages.googleLogo, height: 25),
        ),
        const SizedBox(width: 20),
        SocialButton(
          onTap: controller.signUpWithFacebook,
          child: Image.asset(AppImages.fbLogo, height: 25),
        ),
      ],
    );
  }

  // ── Sign-in link ──────────────────────────────────────
  Widget buildSignInLink() {
    return GestureDetector(
      onTap: controller.goToSignIn,
      child: RichText(
        text: const TextSpan(
          text: 'Already have an account? ',
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
    );
  }
}