import 'package:flutter/material.dart';
import 'package:furniture_app/app/routes/app_routes.dart';
import 'package:furniture_app/app/utils/app_colors.dart';
import 'package:furniture_app/app/widgets/custom_button.dart';
import 'package:get/get.dart';

import '../../app/models/banner_model.dart';
import '../../app/utils/app_image.dart';
import 'home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 56,),
            buildHeader(),
            SizedBox(height: 16,),
            buildSearchBar(),
            SizedBox(height: 20,),
            buildBannerSlider(),
            SizedBox(height: 24,),
            buildSectionHeader("Category", controller.onSeeAllCategories),
            SizedBox(height: 16,),
            buildCategories(),
            SizedBox(height: 24,),
            buildFlashSaleHeader(),
            SizedBox(height: 12,),
            buildFilterChips(),
            SizedBox(height: 16,),
            buildProductGrid()

          ],
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: controller.onLocationTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Location',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Image.asset(
                      AppImages.locationIcon,
                      height: 18,
                      color: AppColors.appColor,
                    ),
                    // Icon(Icons.location_on, color: Color(0xFF3B6B5E), size: 18),
                    SizedBox(width: 4),
                    Text(
                      'New York, USA',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.black,
                      size: 18,
                    ),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: controller.onNotificationTap,
            child: Stack(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFEEEEEE),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      AppImages.bellIcon,
                      height: 20,
                      color: AppColors.black,
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 10,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: (){
                Get.toNamed(AppRoutes.productSearchScreen);
              },
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F2F2),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 14),
                    Image.asset(
                      AppImages.searchIcon,
                      color: AppColors.appColor,
                      height: 22,
                    ),
                    // Icon(Icons.search_rounded, color: Colors.grey, size: 22),
                    SizedBox(width: 8),
                    Text(
                      'Search Workout, Trainer',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: controller.onFilterTap,
            child: Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.appColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                  AppImages.filterIcon,
                  height: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBannerSlider() {
    return Column(
      children: [
        SizedBox(
          height: 170,
          child: PageView.builder(
            controller: controller.bannerPageController,
            onPageChanged: controller.onBannerChanged,
            itemCount: controller.banners.length,
            itemBuilder: (_, index) =>
                _BannerCard(banner: controller.banners[index]),
          ),
        ),
        const SizedBox(height: 12),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              controller.banners.length,
              (i) => AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: controller.currentBanner.value == i ? 20 : 7,
                height: 7,
                decoration: BoxDecoration(
                  color: controller.currentBanner.value == i
                      ? const Color(0xFF3B6B5E)
                      : const Color(0xFFCCCCCC),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSectionHeader(String title, VoidCallback onSeeAll) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          GestureDetector(
            onTap: onSeeAll,
            child: const Text(
              'See All',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategories() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: controller.categories.length,
        itemBuilder: (_, index) {
          final cat = controller.categories[index];
          return GestureDetector(
            onTap: () => controller.onCategoryTap(index),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Container(
                    width: 62,
                    height: 62,
                    decoration: const BoxDecoration(
                      color: Color(0xFFf2f3f3),
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Image.asset(
                        cat.image,
                        color: AppColors.appColor,
                        height: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    cat.name,
                    style: const TextStyle(fontSize: 12, color: Colors.black87),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildFlashSaleHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Flash Sale',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Obx(
            () => Row(
              children: [
                const Text(
                  'Closing in : ',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                _TimerBox(value: controller.hours.value),
                const Text(
                  ' : ',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                _TimerBox(value: controller.minutes.value),
                const Text(
                  ' : ',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                _TimerBox(value: controller.seconds.value),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFilterChips() {
    return SizedBox(
      height: 38,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: controller.filters.length,
        itemBuilder: (_, index) {
          final filter = controller.filters[index];

          return Obx(() {
            final isSelected = controller.selectedFilter.value == filter;

            return GestureDetector(
              onTap: () => controller.selectedFilter.value = filter,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.appColor : Color(0xFFf2f3f3),
                  borderRadius: BorderRadius.circular(20),
                  // border: Border.all(
                  //   color: isSelected
                  //       ? const Color(0xFF3B6B5E)
                  //       : const Color(0xFFDDDDDD),
                  // ),
                ),
                child: Center(
                  child: Text(
                    filter,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }

  Widget buildProductGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          childAspectRatio: 0.78,
        ),
        itemBuilder: (_, index) {
          final product = controller.products[index];
          final isFav = controller.favoriteIds.contains(index);
          return GestureDetector(
            onTap: () => controller.onProductTap(index),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF8F8F8),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                          child: Container(
                            width: double.infinity,
                            color: const Color(
                              0xffd1d1d1,
                            ).withValues(alpha: 0.2),

                            // Replace with:
                            child: Image.network(
                              product.imagePath,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '\$${product.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Obx(() {
                      final isFav = controller.favoriteIds.contains(index);

                      return GestureDetector(
                        onTap: () => controller.toggleFavorite(index),
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: Center(
                            child: AnimatedScale(
                              scale: isFav ? 1.2 : 1.0,
                              duration: const Duration(milliseconds: 200),
                              child: Image.asset(
                                isFav
                                    ? AppImages.likeSelected
                                    : AppImages.likeIc,
                                width: 16,
                                color: isFav
                                    ? AppColors.appColor
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ─── Banner Card ──────────────────────────────────────────────────────────────

class _BannerCard extends StatelessWidget {
  final BannerModel banner;

  const _BannerCard({required this.banner});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: banner.bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    banner.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    banner.subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 14),
                  CustomButton(
                    width: 120,
                    height: 45,
                    onPressed: () {},
                    child: Text(
                      banner.buttonText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Image.network(banner.imagePath, fit: BoxFit.contain, height: 120),
          // const Padding(
          //   padding: EdgeInsets.only(right: 16),
          //   child: Icon(Icons.chair, size: 90, color: Color(0xFFAAAAAA)),
          // ),
        ],
      ),
    );
  }
}

// ─── Timer Box ────────────────────────────────────────────────────────────────

class _TimerBox extends StatelessWidget {
  final int value;

  const _TimerBox({required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 22,
      decoration: BoxDecoration(
        color: const Color(0xFFF3F2F2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
          value.toString().padLeft(2, '0'),
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Color(0xFF3B6B5E),
          ),
        ),
      ),
    );
  }
}
