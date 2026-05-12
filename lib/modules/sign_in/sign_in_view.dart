import 'package:flutter/material.dart';
import 'package:furniture_app/app/utils/app_image.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../app/utils/app_colors.dart';
import '../../app/widgets/app_styles.dart';
import '../../app/widgets/custom_button.dart';
import '../../app/widgets/custom_textfields.dart';
import '../../app/widgets/social_button.dart';
import 'sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({super.key});

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
                SizedBox(height: 40,),
                buildEmailField(),
                buildPasswordField(),
                buildForgotPassword(),
                SizedBox(height: 28,),
                buildSignInButton(),
                SizedBox(height: 30,),
                buildDivider(),
                SizedBox(height: 24,),
                buildSocialButtons(),
                SizedBox(height: 32,),
                buildSignUpLink(),
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
          'Sign In',
          style: AppStyles.titleText(
            color: AppColors.blackColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "Hi! Welcome back, you've been missed",
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
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

  // ── Password field ────────────────────────────────────
  Widget buildPasswordField() {
    return CustomTextField(
      label: 'Password',
      controller: controller.passwordController,
      hintText: '••••••••••••••••',
      isPassword: true,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Please enter your password';
        return null;
      },
    );
  }

  // ── Forgot password ───────────────────────────────────
  Widget buildForgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: controller.forgotPassword,
        child: const Text(
          'Forgot Password?',
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFF3B6B5E),
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.underline,
            decorationColor: Color(0xFF3B6B5E),
          ),
        ),
      ),
    );
  }

  // ── Sign-in button ────────────────────────────────────
  Widget buildSignInButton() {
    return Obx(
          () => CustomButton(
        text: 'Sign In',
        borderRadius: 50,
        backgroundColor: const Color(0xFF3B6B5E),
        isLoading: controller.isLoading.value,
        onPressed: controller.signIn,
      ),
    );
  }

  // ── "Or sign in with" divider ─────────────────────────
  Widget buildDivider() {
    return Row(
      children: const [
        Expanded(child: Divider(color: Color(0xFFDDDDDD))),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'Or sign in with',
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
          onTap: controller.signInWithApple,
          child: Image.asset(AppImages.appleLogo, height: 25),
        ),
        const SizedBox(width: 20),
        SocialButton(
          onTap: controller.signInWithGoogle,
          child: Image.asset(AppImages.googleLogo, height: 25),
        ),
        const SizedBox(width: 20),
        SocialButton(
          onTap: controller.signInWithFacebook,
          child: Image.asset(AppImages.fbLogo, height: 25),
        ),
      ],
    );
  }

  // ── Sign-up link ──────────────────────────────────────
  Widget buildSignUpLink() {
    return GestureDetector(
      onTap: controller.goToSignUp,
      child: RichText(
        text: const TextSpan(
          text: "Don't have an account? ",
          style: TextStyle(fontSize: 14, color: Colors.black87),
          children: [
            TextSpan(
              text: 'Sign Up',
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

