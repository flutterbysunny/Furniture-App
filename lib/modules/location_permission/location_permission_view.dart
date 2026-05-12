import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/widgets/custom_button.dart';
import 'location_permission_controller.dart';

class LocationPermissionView extends GetView<LocationPermissionController> {
  const LocationPermissionView({super.key});

  // ── Root ──────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(flex: 2,),
              buildLocationIcon(),
              SizedBox(height: 36,),
              buildTitle(),
              SizedBox(height: 48,),
              buildAllowButton(),
              SizedBox(height: 20,),
              buildManualLocationLink(),
              Spacer(flex: 3,)

            ],
          ),
        ),
      ),
    );
  }

  // ── Location icon ─────────────────────────────────────
  Widget buildLocationIcon() {
    return Container(
      width: 100,
      height: 100,
      decoration: const BoxDecoration(
        color: Color(0xFFF3F2F2),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.location_on,
        size: 48,
        color: Color(0xFF3B6B5E),
      ),
    );
  }

  // ── Title + subtitle ──────────────────────────────────
  Widget buildTitle() {
    return const Column(
      children: [
        Text(
          'What is Your Location?',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12),
        Text(
          'We need to know your location in order to suggest\nnearby services.',
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // ── Allow location button ─────────────────────────────
  Widget buildAllowButton() {
    return Obx(
          () => CustomButton(
        text: 'Allow Location Access',
        borderRadius: 50,
        backgroundColor: const Color(0xFF3B6B5E),
        isLoading: controller.isLoading.value,
        onPressed: controller.allowLocationAccess,
      ),
    );
  }

  // ── Enter location manually link ──────────────────────
  Widget buildManualLocationLink() {
    return GestureDetector(
      onTap: controller.enterLocationManually,
      child: const Text(
        'Enter Location Manually',
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}