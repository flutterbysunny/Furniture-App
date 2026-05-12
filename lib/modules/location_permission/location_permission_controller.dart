import 'package:flutter/material.dart';
import 'package:furniture_app/app/routes/app_routes.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../app/utils/app_utils.dart';

class LocationPermissionController extends GetxController {
  final isLoading = false.obs;
  Utils utils = Utils();


  Future<void> allowLocationAccess() async {
    isLoading.value = true;

    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        isLoading.value = false;
        _showLocationDisabledDialog();
        return;
      }

      // Check permission status
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          isLoading.value = false;
          _showPermissionDeniedSnackbar();
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        isLoading.value = false;
        _showPermissionDeniedForeverDialog();
        return;
      }

      // Permission granted — get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      isLoading.value = false;

      // TODO: Save position & navigate to home
      // Get.offAllNamed('/home');

      utils.showSnackBar(
        context: Get.context!,
        titles: "Location Found!",
        message: "Lat: ${position.latitude.toStringAsFixed(4)}, Lng: ${position.longitude.toStringAsFixed(4)}",
      );

      // Get.snackbar(
      //   'Location Found!',
      //   'Lat: ${position.latitude.toStringAsFixed(4)}, Lng: ${position.longitude.toStringAsFixed(4)}',
      //   snackPosition: SnackPosition.BOTTOM,
      //   backgroundColor: const Color(0xFF3B6B5E),
      //   colorText: Colors.white,
      //   margin: const EdgeInsets.all(16),
      //   borderRadius: 12,
      //   icon: const Icon(Icons.location_on, color: Colors.white),
      // );
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Could not get location. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
    }
  }

  void enterLocationManually() {
    // TODO: Navigate to manual location entry screen
    // Get.toNamed('/manual-location');
    Get.toNamed(AppRoutes.enterLocationScreen);
  }

  void _showLocationDisabledDialog() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Location Services Disabled'),
        content: const Text(
          'Please enable location services in your device settings to continue.',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel',
                style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () async {
              Get.back();
              await Geolocator.openLocationSettings();
            },
            child: const Text('Open Settings',
                style: TextStyle(color: Color(0xFF3B6B5E))),
          ),
        ],
      ),
    );
  }

  void _showPermissionDeniedSnackbar() {
    Get.snackbar(
      'Permission Denied',
      'Location permission was denied. Please allow it to continue.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void _showPermissionDeniedForeverDialog() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Permission Required'),
        content: const Text(
          'Location permission is permanently denied. Please enable it from app settings.',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel',
                style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () async {
              Get.back();
              await Geolocator.openAppSettings();
            },
            child: const Text('Open Settings',
                style: TextStyle(color: Color(0xFF3B6B5E))),
          ),
        ],
      ),
    );
  }
}