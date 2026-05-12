import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'dart:async';

import '../../app/models/location_model.dart';

class LocationSearchController extends GetxController {
  final searchController = TextEditingController().obs;
  final searchFocus = FocusNode();
  final searchResults = <LocationResult>[].obs;
  final isSearching = false.obs;
  final isLoadingCurrentLocation = false.obs;
  final searchText = ''.obs;

  Timer? _debounce;

  // ✅ Dummy Location Data
  final List<LocationResult> _allLocations = [
    LocationResult(title: 'Connaught Place', subtitle: 'New Delhi, Delhi, India', latitude: 28.6315, longitude: 77.2167),
    LocationResult(title: 'India Gate', subtitle: 'Rajpath, New Delhi, Delhi, India', latitude: 28.6129, longitude: 77.2295),
    LocationResult(title: 'Lajpat Nagar', subtitle: 'South Delhi, Delhi, India', latitude: 28.5677, longitude: 77.2433),
    LocationResult(title: 'Karol Bagh', subtitle: 'Central Delhi, Delhi, India', latitude: 28.6519, longitude: 77.1909),
    LocationResult(title: 'Dwarka Sector 21', subtitle: 'West Delhi, Delhi, India', latitude: 28.5528, longitude: 77.0588),
    LocationResult(title: 'Saket', subtitle: 'South Delhi, Delhi, India', latitude: 28.5244, longitude: 77.2090),
    LocationResult(title: 'Rohini Sector 3', subtitle: 'North West Delhi, Delhi, India', latitude: 28.7041, longitude: 77.1025),
    LocationResult(title: 'Vasant Kunj', subtitle: 'South West Delhi, Delhi, India', latitude: 28.5200, longitude: 77.1577),

    LocationResult(title: 'Bandra West', subtitle: 'Mumbai, Maharashtra, India', latitude: 19.0596, longitude: 72.8295),
    LocationResult(title: 'Andheri East', subtitle: 'Mumbai, Maharashtra, India', latitude: 19.1136, longitude: 72.8697),
    LocationResult(title: 'Powai', subtitle: 'Mumbai, Maharashtra, India', latitude: 19.1176, longitude: 72.9060),
    LocationResult(title: 'Juhu Beach', subtitle: 'Juhu, Mumbai, Maharashtra, India', latitude: 19.0883, longitude: 72.8264),
    LocationResult(title: 'Colaba', subtitle: 'South Mumbai, Maharashtra, India', latitude: 18.9067, longitude: 72.8147),
    LocationResult(title: 'Dadar', subtitle: 'Mumbai, Maharashtra, India', latitude: 19.0178, longitude: 72.8478),

    LocationResult(title: 'Koramangala', subtitle: 'Bangalore, Karnataka, India', latitude: 12.9279, longitude: 77.6271),
    LocationResult(title: 'Indiranagar', subtitle: 'Bangalore, Karnataka, India', latitude: 12.9784, longitude: 77.6408),
    LocationResult(title: 'Whitefield', subtitle: 'Bangalore, Karnataka, India', latitude: 12.9698, longitude: 77.7499),
    LocationResult(title: 'HSR Layout', subtitle: 'Bangalore, Karnataka, India', latitude: 12.9081, longitude: 77.6476),
    LocationResult(title: 'Electronic City', subtitle: 'Bangalore, Karnataka, India', latitude: 12.8399, longitude: 77.6770),

    LocationResult(title: 'Banjara Hills', subtitle: 'Hyderabad, Telangana, India', latitude: 17.4126, longitude: 78.4483),
    LocationResult(title: 'Jubilee Hills', subtitle: 'Hyderabad, Telangana, India', latitude: 17.4326, longitude: 78.4071),
    LocationResult(title: 'Gachibowli', subtitle: 'Hyderabad, Telangana, India', latitude: 17.4401, longitude: 78.3489),
    LocationResult(title: 'HITEC City', subtitle: 'Hyderabad, Telangana, India', latitude: 17.4474, longitude: 78.3762),

    LocationResult(title: 'Anna Nagar', subtitle: 'Chennai, Tamil Nadu, India', latitude: 13.0891, longitude: 80.2103),
    LocationResult(title: 'T Nagar', subtitle: 'Chennai, Tamil Nadu, India', latitude: 13.0418, longitude: 80.2341),
    LocationResult(title: 'Velachery', subtitle: 'Chennai, Tamil Nadu, India', latitude: 12.9815, longitude: 80.2180),
    LocationResult(title: 'Adyar', subtitle: 'Chennai, Tamil Nadu, India', latitude: 13.0012, longitude: 80.2565),

    LocationResult(title: 'Aundh', subtitle: 'Pune, Maharashtra, India', latitude: 18.5590, longitude: 73.8076),
    LocationResult(title: 'Kothrud', subtitle: 'Pune, Maharashtra, India', latitude: 18.5074, longitude: 73.8077),
    LocationResult(title: 'Viman Nagar', subtitle: 'Pune, Maharashtra, India', latitude: 18.5679, longitude: 73.9143),
    LocationResult(title: 'Hinjewadi', subtitle: 'Pune, Maharashtra, India', latitude: 18.5912, longitude: 73.7389),

    LocationResult(title: 'Satellite', subtitle: 'Ahmedabad, Gujarat, India', latitude: 23.0308, longitude: 72.5124),
    LocationResult(title: 'Navrangpura', subtitle: 'Ahmedabad, Gujarat, India', latitude: 23.0395, longitude: 72.5603),
    LocationResult(title: 'Bopal', subtitle: 'Ahmedabad, Gujarat, India', latitude: 23.0258, longitude: 72.4696),
    LocationResult(title: 'SG Highway', subtitle: 'Ahmedabad, Gujarat, India', latitude: 23.0180, longitude: 72.5070),
    LocationResult(title: 'Prahlad Nagar', subtitle: 'Ahmedabad, Gujarat, India', latitude: 23.0154, longitude: 72.5072),
  ];

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(milliseconds: 300), () {
      searchFocus.requestFocus();
    });
  }

  void onSearchChanged(String query) {
    searchText.value = query;
    _debounce?.cancel();

    if (query.trim().isEmpty) {
      searchResults.clear();
      return;
    }

    // Loading feel ke liye thoda delay
    isSearching.value = true;
    _debounce = Timer(const Duration(milliseconds: 300), () {
      _searchLocally(query.trim().toLowerCase());
    });
  }

  void _searchLocally(String query) {
    final filtered = _allLocations.where((loc) {
      return loc.title.toLowerCase().contains(query) ||
          loc.subtitle.toLowerCase().contains(query);
    }).take(6).toList();

    searchResults.assignAll(filtered);
    isSearching.value = false;
  }

  void clearSearch() {
    searchController.value.clear();
    searchText.value = '';
    searchResults.clear();
    searchFocus.requestFocus();
  }

  void onLocationSelected(LocationResult result) {
    Get.back(result: result);
  }

  Future<void> useCurrentLocation() async {
    isLoadingCurrentLocation.value = true;
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _showLocationServiceDialog();
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return;
      }

      if (permission == LocationPermission.deniedForever) {
        _showPermissionDialog();
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Nearest dummy location dhundo
      LocationResult? nearest = _findNearest(position.latitude, position.longitude);

      if (nearest != null) {
        onLocationSelected(LocationResult(
          title: 'Current Location',
          subtitle: nearest.subtitle,
          latitude: position.latitude,
          longitude: position.longitude,
        ));
      }
    } catch (e) {
      Get.snackbar(
        'Error', 'Could not get current location.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
    } finally {
      isLoadingCurrentLocation.value = false;
    }
  }

  // Nearest location calculate karo (simple distance formula)
  LocationResult? _findNearest(double lat, double lng) {
    if (_allLocations.isEmpty) return null;
    return _allLocations.reduce((a, b) {
      final da = _dist(lat, lng, a.latitude, a.longitude);
      final db = _dist(lat, lng, b.latitude, b.longitude);
      return da < db ? a : b;
    });
  }

  double _dist(double lat1, double lng1, double lat2, double lng2) {
    return (lat1 - lat2) * (lat1 - lat2) + (lng1 - lng2) * (lng1 - lng2);
  }

  void _showLocationServiceDialog() {
    isLoadingCurrentLocation.value = false;
    Get.dialog(AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text('Location Services Disabled'),
      content: const Text('Please enable location services in device settings.'),
      actions: [
        TextButton(onPressed: Get.back, child: const Text('Cancel', style: TextStyle(color: Colors.grey))),
        TextButton(
          onPressed: () async { Get.back(); await Geolocator.openLocationSettings(); },
          child: const Text('Settings', style: TextStyle(color: Color(0xFF3B6B5E))),
        ),
      ],
    ));
  }

  void _showPermissionDialog() {
    isLoadingCurrentLocation.value = false;
    Get.dialog(AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text('Permission Required'),
      content: const Text('Location permission permanently denied. Enable from app settings.'),
      actions: [
        TextButton(onPressed: Get.back, child: const Text('Cancel', style: TextStyle(color: Colors.grey))),
        TextButton(
          onPressed: () async { Get.back(); await Geolocator.openAppSettings(); },
          child: const Text('Settings', style: TextStyle(color: Color(0xFF3B6B5E))),
        ),
      ],
    ));
  }

  void goBack() => Get.back();

  @override
  void onClose() {
    _debounce?.cancel();
    searchController.value.dispose();
    searchFocus.dispose();
    super.onClose();
  }
}