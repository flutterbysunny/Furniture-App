import 'package:country_calling_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:furniture_app/modules/profile/profile_controller.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../app/utils/app_colors.dart';
import '../../app/utils/app_image.dart';
import '../../app/widgets/custom_button.dart';
import '../../app/widgets/custom_container.dart';
import '../../app/widgets/custom_textfields.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                buildTitle(),
                SizedBox(height: 25,),
                buildImagePicker(),
                SizedBox(height: 32,),
                buildNameField(),
                SizedBox(height: 4,),
                buildPhoneField(),
                SizedBox(height: 8,),
                buildGenderDropdown(),
                SizedBox(height: 36,),
                buildCompleteButton(),
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
    return const Column(
      children: [
        Center(
          child: Text(
            'Complete Your Profile',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(height: 10),
        Center(
          child: Text(
            "Don't worry, only you can see your personal\ndata. No one else will be able to see it.",
            style: TextStyle(fontSize: 13, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  // ── Profile image picker ──────────────────────────────
  Widget buildImagePicker() {
    return Center(
      child: GestureDetector(
        onTap: controller.pickImage,
        child: SizedBox(
          width: 110,
          height: 110,
          child: Stack(
            children: [
              _buildAvatar(),
              _buildEditBadge(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Obx(
          () => Container(
        width: 105,
        height: 105,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFFF3F2F2),
          image: controller.selectedImage.value != null
              ? DecorationImage(
            image: FileImage(controller.selectedImage.value!),
            fit: BoxFit.cover,
          )
              : null,
        ),
        child: controller.selectedImage.value == null
            ? const Icon(
          Icons.person,
          size: 60,
          color: Color(0xFF3B6B5E),
        )
            : null,
      ),
    );
  }

  Widget _buildEditBadge() {
    return Positioned(
      bottom: 12,
      right: 2,
      child: Container(
        width: 32,
        height: 32,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF3B6B5E),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            "assets/images/pickedIcon.png",
            height: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // ── Name field ────────────────────────────────────────
  Widget buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Name',
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
          ),
        ),
        CustomPhoneTextField(
          borderVisible: false,
          controller: controller.nameController,
          hintText: 'Enter Name',
          inputType: TextInputType.name,
          isError: controller.phoneNumberError!.value,
          hintColor: controller.nameError!.value
              ? AppColors.errorColor
              : AppColors.grey,
          color: controller.nameError!.value
              ? AppColors.errorColor
              : AppColors.black,
        ),
      ],
    );
  }

  // ── Phone number field ────────────────────────────────
  Widget buildPhoneField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Phone Number',
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
          ),
        ),
        Row(
          children: [
            _buildCountryCodePicker(),
            SizedBox(width: 1.h),
            Expanded(child: _buildPhoneInput()),
          ],
        ),
      ],
    );
  }

  Widget _buildCountryCodePicker() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: controller.showCountryCodePicker,
      child: GetBuilder<ProfileController>(
        builder: (_) {
          return CustomContainer(
            height: 6.0.h,
            borderRadius: 10,
            width: 90,
            borderVisible: false,
            horizontalPadding: 1.2.h,
            child: controller.selectedCountry == null
                ? const SizedBox()
                : Row(
              children: [
                ClipOval(
                  child: Image.asset(
                    controller.selectedCountry!.flag,
                    package: countryCodePackageName,
                    width: 7.4.w,
                    height: 3.4.h,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 1.2.h),
                Image.asset(
                  AppImages.downArrow,
                  width: 1.6.h,
                  color: Colors.black,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPhoneInput() {
    return Obx(
          () => CustomPhoneTextField(
        borderVisible: false,
        hintText: "Enter Number",
        textInputAction: TextInputAction.done,
        maxLength: 10,
        inputFormat: [FilteringTextInputFormatter.digitsOnly],
        inputType: TextInputType.phone,
        controller: controller.phoneNumberController,
        isError: controller.phoneNumberError!.value,
        hintColor: controller.phoneNumberError!.value
            ? AppColors.errorColor
            : AppColors.grey,
        color: controller.phoneNumberError!.value
            ? AppColors.errorColor
            : AppColors.black,
      ),
    );
  }

  // ── Gender dropdown ───────────────────────────────────
  Widget buildGenderDropdown() {
    return Obx(
          () => CustomDropdown<String>(
        borderVisible: false,
        hintColor: AppColors.grey,
        value: controller.selectedGender.value.isEmpty
            ? null
            : controller.selectedGender.value,
        hintText: 'Select Gender',
        isError: false,
        isTitle: true,
        title: 'Gender',
        items: ['Male', 'Female', 'Other']
            .map((g) => DropdownMenuItem(value: g, child: Text(g)))
            .toList(),
        onChanged: (val) {
          if (val != null) controller.selectedGender.value = val;
        },
      ),
    );
  }

  // ── Complete Profile button ───────────────────────────
  Widget buildCompleteButton() {
    return Obx(
          () => CustomButton(
        text: 'Complete Profile',
        borderRadius: 50,
        backgroundColor: const Color(0xFF3B6B5E),
        isLoading: controller.isLoading.value,
        onPressed: controller.completeProfile,
      ),
    );
  }
}