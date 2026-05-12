import 'package:flutter/material.dart';
import 'package:furniture_app/app/utils/app_image.dart';
import 'package:get/get.dart';
import '../../app/utils/app_colors.dart';
import '../../app/widgets/wishlist_widgets/wishlist_card.dart';
import 'my_wishlist_controller.dart';

class MyWishlistView extends GetView<WishlistController> {
   MyWishlistView({super.key});

   final WishlistController controller = Get.put(WishlistController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildAppBar(),
            SizedBox(height: 16,),
            buildCategoryFilter(),
            SizedBox(height: 16,),
            Expanded(child: buildGrid()),
          ],
        ),
      ),
    );
  }

  // ── AppBar ──────────────────────────────────────────────────────────────────

  Widget buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Center(
        child: Text(
          'My Wishlist',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.black),
        ),
      ),
    );
  }

  // ── Category Filter Chips ───────────────────────────────────────────────────

   Widget buildCategoryFilter() {
     return SizedBox(
       height: 38,
       child: ListView.builder(
         scrollDirection: Axis.horizontal,
         padding: const EdgeInsets.symmetric(horizontal: 20),
         itemCount: controller.categories.length,
         itemBuilder: (_, i) {
           final cat = controller.categories[i];

           // ✅ Har chip ka apna Obx — sirf wahi rebuild hoga
           return Obx(() {
             final isSelected = controller.selectedCategory.value == cat;
             return GestureDetector(
               onTap: () => controller.selectCategory(cat),
               child: AnimatedContainer(
                 duration: const Duration(milliseconds: 200),
                 margin: const EdgeInsets.only(right: 10),
                 padding: const EdgeInsets.symmetric(horizontal: 20),
                 decoration: BoxDecoration(
                   color: isSelected ? AppColors.appColor : Colors.white,
                   borderRadius: BorderRadius.circular(20),
                   border: Border.all(
                     color: isSelected
                         ? AppColors.appColor
                         : const Color(0xFFDDDDDD),
                   ),
                 ),
                 child: Center(
                   child: Text(
                     cat,
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
  // ── Product Grid ────────────────────────────────────────────────────────────

  Widget buildGrid() {
    return Obx(() {
      final items = controller.filteredItems; // ✅ Ab reactive hai

      if (items.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              Image.asset(AppImages.likeIc,height: 64, color: Color(0xFFCCCCCC)),
              // Icon(Icons.favorite_outline, size: 64, color: Color(0xFFCCCCCC)),
              SizedBox(height: 16),
              Text('No items in this category',
                  style: TextStyle(fontSize: 15, color: Colors.grey)),
            ],
          ),
        );
      }

      return GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 14,
          childAspectRatio: 0.72,
        ),
        itemBuilder: (_, index) {
          final item = items[index];
          return WishlistCard(item: item);
        },
      );
    });
  }
}

// ─── Wishlist Card ────────────────────────────────────────────────────────────

