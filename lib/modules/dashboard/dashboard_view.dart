import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:furniture_app/app/utils/app_colors.dart';
import 'package:furniture_app/app/utils/app_image.dart';
import 'package:get/get.dart';

import 'dashboard_controller.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBody: true,
        body: Obx(() => IndexedStack(
          index: controller.currentIndex.value,
          children: controller.tabs,
        )),
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}

// ─── Custom Bottom Nav Bar ────────────────────────────────────────────────────

class BottomNavBar extends GetView<DashboardController> {
  const BottomNavBar({super.key});

  // 🔥 Model for images
  static  final List<NavItem> _items = [
    NavItem(
      selected: AppImages.homeIc,
      unselected: AppImages.homeSelected,
    ),
    NavItem(
      selected: AppImages.shopIc,
      unselected: AppImages.shopSelected,
    ),
    NavItem(
      selected: AppImages.likeIc,
      unselected: AppImages.likeSelected,
    ),
    NavItem(
      selected: AppImages.chatIc,
      unselected: AppImages.chatSelected,
    ),
    NavItem(
      selected: AppImages.userIc,
      unselected: AppImages.userSelect,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
        height: 75,
        decoration: BoxDecoration(
          color: AppColors.bottomColor,
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(_items.length, (index) {
              final isSelected = controller.currentIndex.value == index;

              return GestureDetector(
                onTap: () => controller.onNavTap(index),
                behavior: HitTestBehavior.opaque,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  width: isSelected ? 52 : 44,
                  height: isSelected ? 52 : 44,
                  decoration: BoxDecoration(
                    color:
                    isSelected ? Colors.white : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset(
                      isSelected
                          ? _items[index].unselected
                          : _items[index].selected,
                      width: isSelected ? 26 : 22,
                      height: isSelected ? 26 : 22,
                      color: isSelected
                          ? AppColors.appColor : AppColors.white,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class NavItem {
  final String selected;
  final String unselected;

  NavItem({required this.selected, required this.unselected});
}