import 'package:flutter/material.dart';
import 'package:furniture_app/modules/product_details/product_details_controller.dart';
import 'package:get/get.dart';

import '../../app/routes/app_routes.dart';
import '../../app/utils/app_colors.dart';
import '../../app/widgets/custom_button.dart';
import '../../app/widgets/rotation_view.dart';

class ProductDetailView extends GetView<ProductDetailController> {
  const ProductDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildImageSection(),
                  buildDetailsCard(),
                ],
              ),
            ),
          ),
          buildBottomBar()
        ],
      ),
    );
  }

  // ───────────────────────────────────────────────────────────────────────────
  // IMAGE SECTION
  // ───────────────────────────────────────────────────────────────────────────

  Widget buildImageSection() {
    return Container(
      color: const Color(0xFFF3F2F2),
      child: Column(
        children: [
          SizedBox(height: 52,),
          buildAppBar(),
          SizedBox(height: 16,),
          buildMainImage(),
          SizedBox(height: 14,),
          buildOpicity(),
          SizedBox(height: 20,)

        ],
      ),
    );
  }

  buildAppBar(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _CircleBtn(
            onTap: controller.goBack,
            child: const Icon(Icons.arrow_back_ios_new_rounded,
                size: 16, color: Colors.black87),
          ),
          const Text(
            'Product Details',
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ),
          Obx(() => _CircleBtn(
            onTap: controller.toggleFavorite,
            child: Icon(
              controller.isFavorite.value
                  ? Icons.favorite
                  : Icons.favorite_outline,
              size: 20,
              color: controller.isFavorite.value
                  ? Colors.red
                  : Colors.black87,
            ),
          )),
        ],
      ),
    );
  }

  buildMainImage(){
    return Obx(() {
      // ── 360° Mode ──────────────────────────────────────────────────
      if (controller.is360Mode.value) {
        return SizedBox(
          height: 290,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ThreeSixtyViewer(
                frames: controller.frames360,
                height: 400,
              ),

              // ── Color filter in 360° mode ──
              // Note: Real 360° app mein color change = alag set of frames
              // Abhi sirf indicator dikhate hain
              if (controller.selectedColorIndex.value != 0)
                Positioned(
                  top: 6,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: controller.selectedColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color:
                        controller.selectedColor.withOpacity(0.4),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: controller.selectedColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          controller.selectedColorName,
                          style: TextStyle(
                              fontSize: 10,
                              color: controller.selectedColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),

              // ── 360° Exit button ──
              Positioned(
                bottom: 10,
                child: _build360ToggleBtn(),
              ),
            ],
          ),
        );
      }

      // ── Normal Mode ────────────────────────────────────────────────
      final colorIndex = controller.selectedColorIndex.value;
      final isOriginal = colorIndex == 0;
      final filterColor = controller.selectedColor;

      Widget productImage = Image.network(
        controller.galleryImages.isNotEmpty
            ? controller.galleryImages[
        controller.selectedImageIndex.value]
            : controller.product.imagePath,
        fit: BoxFit.contain,
        height: 220,
        loadingBuilder: (_, child, prog) {
          if (prog == null) return child;
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF3B6B5E),
              strokeWidth: 2,
            ),
          );
        },
        errorBuilder: (_, __, ___) => const Icon(
          Icons.chair,
          size: 120,
          color: Color(0xFFAAAAAA),
        ),
      );

      if (!isOriginal) {
        productImage = ColorFiltered(
          colorFilter: ColorFilter.mode(
            filterColor.withOpacity(0.45),
            BlendMode.srcATop,
          ),
          child: productImage,
        );
      }

      return SizedBox(
        height: 290,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Shadow ellipse
            Positioned(
              bottom: 36,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 200,
                height: 16,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color:
                    controller.selectedColor.withOpacity(0.4),
                    width: 1.5,
                  ),
                ),
              ),
            ),

            // Product image with color filter + animation
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: SizedBox(
                  key: ValueKey(colorIndex),
                  child: productImage,
                ),
              ),
            ),

            // ── 360° Enter button ──
            Positioned(
              bottom: 14,
              child: _build360ToggleBtn(),
            ),
          ],
        ),
      );
    });
  }

  buildOpicity(){
    return  Obx(() => AnimatedOpacity(
      duration: const Duration(milliseconds: 250),
      opacity: controller.is360Mode.value ? 0.35 : 1.0,
      child: IgnorePointer(
        ignoring: controller.is360Mode.value,
        child: _buildThumbnailRow(),
      ),
    ));
  }

  // ── 360° Toggle Button (shared between both modes) ──────────────────────
  Widget _build360ToggleBtn() {
    return Obx(() {
      final active = controller.is360Mode.value;
      return GestureDetector(
        onTap: controller.toggle360Mode,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color:
            active ? Colors.black87 : AppColors.appColor,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: (active ? Colors.black : AppColors.appColor)
                    .withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                active
                    ? Icons.image_outlined
                    : Icons.threesixty_rounded,
                color: Colors.white,
                size: 16,
              ),
              const SizedBox(width: 6),
              Text(
                active ? 'Normal View' : '360° View',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildThumbnailRow() {
    return Obx(() {
      final images = controller.galleryImages;
      final maxV = ProductDetailController.maxVisibleThumbnails;
      final visibleCount = images.length > maxV ? maxV : images.length;
      final extra = controller.extraImageCount;

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              ...List.generate(visibleCount, (i) {
                final isSelected =
                    controller.selectedImageIndex.value == i;
                return GestureDetector(
                  onTap: () => controller.onThumbnailTap(i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(right: 8),
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F2F2),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.appColor
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        images[i],
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => Icon(
                          Icons.chair,
                          size: 26,
                          color: isSelected
                              ? AppColors.appColor
                              : const Color(0xFFAAAAAA),
                        ),
                      ),
                    ),
                  ),
                );
              }),

              // +N tile
              if (extra > 0)
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.55),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      '+$extra',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }

  // ───────────────────────────────────────────────────────────────────────────
  // DETAILS CARD
  // ───────────────────────────────────────────────────────────────────────────

  Widget buildDetailsCard() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildCategoryAndRating(),
          SizedBox(height: 6,),
          buildProductName(),
          SizedBox(height: 16,),
          Divider(color: AppColors.dividerColor,),
          SizedBox(height: 12,),
          buildProductDetails(),
          SizedBox(height: 16,),
          Divider(color: AppColors.dividerColor,),
          SizedBox(height: 12,),
          buildColorLabel(),
          SizedBox(height: 12,),
          buildColorSelector(),
          SizedBox(height: 12,),
          SizedBox(height: 24,)


        ],
      ),
    );
  }

// ── 1. Category & Rating ─────────────────────────────────────────────────────
  Widget buildCategoryAndRating() {
    return GestureDetector(
      onTap: (){
        Get.toNamed(AppRoutes.reviewScreen);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Arm Chair',
            style: TextStyle(fontSize: 13, color: Colors.grey),
          ),
          Row(
            children: const [
              Icon(Icons.star_rounded, color: Colors.orange, size: 18),
              SizedBox(width: 4),
              Text(
                '4.5',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

// ── 2. Product Name ───────────────────────────────────────────────────────────
  Widget buildProductName() {
    return Text(
      controller.product.name,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

// ── 3. Product Details (expandable description) ───────────────────────────────
  Widget buildProductDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Product Details',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Obx(() {
          const full =
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam quis nostrud exercitation ullamco laboris.';
          final expanded = controller.isExpanded.value;
          const maxC = 100;
          final display = expanded ? full : '${full.substring(0, maxC)}...';

          return RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 13, color: Colors.grey, height: 1.6),
              children: [
                TextSpan(text: display),
                WidgetSpan(
                  child: GestureDetector(
                    onTap: controller.toggleExpanded,
                    child: Text(
                      expanded ? 'Show less' : ' Read more',
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.appColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

// ── 4. Color Label ────────────────────────────────────────────────────────────
  Widget buildColorLabel() {
    return Obx(
          () => RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 15, color: Colors.black),
          children: [
            const TextSpan(
              text: 'Select Color : ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: controller.selectedColorName,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

// ── 5. Color Selector ─────────────────────────────────────────────────────────
  Widget buildColorSelector() {
    return Obx(
          () => Row(
        children: List.generate(controller.colors.length, (i) {
          final isSelected = controller.selectedColorIndex.value == i;
          final color = controller.colors[i];

          return GestureDetector(
            onTap: () => controller.onColorSelect(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 10),
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
                border: Border.all(
                  color: isSelected ? Colors.black45 : Colors.transparent,
                  width: 2.5,
                ),
                boxShadow: isSelected
                    ? [
                  BoxShadow(
                    color: color.withOpacity(0.4),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
                    : [],
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
          );
        }),
      ),
    );
  }



  // ───────────────────────────────────────────────────────────────────────────
  // BOTTOM BAR
  // ───────────────────────────────────────────────────────────────────────────

  Widget buildBottomBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Total Price
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Total Price',
                  style:
                  TextStyle(fontSize: 12, color: Colors.grey)),
              const SizedBox(height: 2),
              Text(
                '\$${controller.product.price.toStringAsFixed(2)}',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ],
          ),

          const SizedBox(width: 20),

          // Add to Cart Button
          Expanded(
            child: Obx(() => CustomButton(
              height: 52,
              borderRadius: 50,
              isLoading: controller.isAddingToCart.value,
              onPressed: controller.addToCart,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.shopping_bag_outlined,
                      color: Colors.white, size: 20),
                  SizedBox(width: 8),
                  Text('Add to Cart',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                ],
              ),
            )),
          ),
        ],
      ),
    );
  }
}

// ─── Helper widget ────────────────────────────────────────────────────────────

class _CircleBtn extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  const _CircleBtn({required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 8,
                offset: const Offset(0, 2))
          ],
        ),
        child: Center(child: child),
      ),
    );
  }
}