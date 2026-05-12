import 'dart:io';

import 'package:country_calling_code_picker/country.dart';
import 'package:country_calling_code_picker/functions.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/app/utils/app_colors.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../app/utils/app_utils.dart';
import '../../app/widgets/profile_picked.dart';

class ProfileController extends GetxController {
  final nameController = TextEditingController();
  Country? selectedCountry;
  TextEditingController phoneNumberController = TextEditingController();
  RxBool? phoneNumberError = false.obs;
  RxBool? nameError = false.obs;
  final formKey = GlobalKey<FormState>();
  Utils utils = Utils();

  final isLoading = false.obs;
  final selectedImage = Rxn<File>();
  final selectedCountryCode = '+91'.obs;
  final selectedGender = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    initCountry();
    super.onInit();
  }

  void initCountry() async {
    final countries = await getCountries(Get.context!);
    selectedCountry = countries.firstWhere(
          (c) => c.countryCode == 'IN',
      orElse: () => countries.first,
    );
    update();
  }

  final List<String> genderOptions = ['Male', 'Female', 'Other'];

  final ImagePicker _picker = ImagePicker();

  void pickImage() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Drag Handle ──
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFE0E0E0),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),

            // ── Title ──
            const Text(
              'Profile Photo',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Choose how you want to add your photo',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 28),

            // ── Options Row ──
            Row(
              children: [
                // Camera Option
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                      pickFromSource(ImageSource.camera);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFFEEEEEE),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 52,
                            height: 52,
                            decoration: const BoxDecoration(
                              color: Color(0xFF3B6B5E),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt_rounded,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Camera',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Take a new photo',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 14),

                // Gallery Option
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                      pickFromSource(ImageSource.gallery);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFFEEEEEE),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 52,
                            height: 52,
                            decoration: const BoxDecoration(
                              color: Color(0xFF3B6B5E),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.photo_library_rounded,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Gallery',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Choose from library',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // ── Remove Photo ──
            if (selectedImage.value != null) ...[
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  selectedImage.value = null;
                  Get.back();
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFEEEE),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.delete_outline_rounded,
                          color: Colors.red, size: 18),
                      SizedBox(width: 8),
                      Text(
                        'Remove Photo',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],

            const SizedBox(height: 12),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Future<void> pickFromSource(ImageSource source) async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 800,
      );
      if (picked != null) {
        selectedImage.value = File(picked.path);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Could not pick image. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  void showGenderPicker() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Gender',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            ...genderOptions.map(
              (g) => ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(g, style: const TextStyle(fontSize: 15)),
                trailing: Obx(
                  () => selectedGender.value == g
                      ? const Icon(Icons.check_circle, color: Color(0xFF3B6B5E))
                      : const SizedBox(),
                ),
                onTap: () {
                  selectedGender.value = g;
                  Get.back();
                },
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void showCountryCodePicker() async {
    final country = await showCountryPickerSheet(
      Get.context!,
      title: Text(
        "Choose Country",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.appColor,
        ),
      ),
      cancelWidget: Positioned(
        right: 8,
        top: 10,
        bottom: 0,
        child: GestureDetector(
          onTap: () {
            Navigator.pop(Get.context!);
          },
          child: Text(
            "Cancel",
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.appColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
    //  onPressed: () => Navigator.pop(Get.context!),
    if (country != null) {
      selectedCountry = country;
      update();
    }
  }

  void completeProfile() async {
    if (formKey.currentState!.validate()) {
      if (selectedGender.value.isEmpty) {
        utils.showErrorSnackBar(
          context: Get.context!,
          message: "Please select your gender to continue.",
        );
        return;
      }
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 2));
      isLoading.value = false;
      utils.showSnackBar(
        context: Get.context!,
        message: "Profile completed successfully 🎉",
      );
      // TODO: Navigate to home screen
      // Get.offAllNamed('/home');
    }
  }

  void goBack() => Get.back();

  @override
  void onClose() {
    nameController.dispose();
    phoneNumberController.dispose();
    super.onClose();
  }
}
