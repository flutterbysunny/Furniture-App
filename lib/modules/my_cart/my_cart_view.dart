// import 'package:flutter/material.dart';
// import 'package:furniture_app/app/widgets/custom_textfields.dart';
// import 'package:get/get.dart';
//
// import '../../app/models/cart_item_model.dart';
// import '../../app/utils/app_colors.dart';
// import '../../app/widgets/custom_button.dart';
// import 'my_cart_controller.dart';
//
// class MyCartView extends GetView<MyCartController> {
//   MyCartView({super.key});
//
//   var cartController = Get.put(MyCartController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(
//         children: [
//           // ── AppBar ──
//           buildAppBar(),
//
//           // ── Cart List ──
//           Expanded(
//             child: Obx(
//               () => controller.cartItems.isEmpty
//                   ? buildEmptyCart()
//                   : ListView.builder(
//                       padding: const EdgeInsets.only(top: 0, bottom: 8),
//                       itemCount: controller.cartItems.length,
//                       itemBuilder: (_, index) {
//                         final item = controller.cartItems[index];
//                         return CartItemTile(item: item);
//                       },
//                     ),
//             ),
//           ),
//
//           // ── Bottom Summary + Checkout ──
//           buildBottomSection(),
//         ],
//       ),
//     );
//   }
//
//   // ── AppBar ─────────────────────────────────────────────────────────────────
//
//   Widget buildAppBar() {
//     return SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
//         child: Row(
//           children: [
//             GestureDetector(
//               onTap: cartController.goBack,
//               child: Container(
//                 width: 40,
//                 height: 35,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   shape: BoxShape.circle,
//                   border: Border.all(
//                     color: const Color(0xFFEEEEEE),
//                     width: 1.5,
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.05),
//                       blurRadius: 8,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: const Icon(
//                   Icons.arrow_back_ios_new_rounded,
//                   size: 16,
//                   color: Colors.black87,
//                 ),
//               ),
//             ),
//             const Expanded(
//               child: Text(
//                 'My Cart',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 17,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//             const SizedBox(width: 40), // balance
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ── Empty Cart ──────────────────────────────────────────────────────────────
//
//   Widget buildEmptyCart() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: const [
//           Icon(Icons.shopping_bag_outlined, size: 72, color: Color(0xFFCCCCCC)),
//           SizedBox(height: 16),
//           Text(
//             'Your cart is empty',
//             style: TextStyle(fontSize: 16, color: Colors.grey),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // ── Bottom Section ──────────────────────────────────────────────────────────
//
//   Widget buildBottomSection() {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.07),
//             blurRadius: 16,
//             offset: const Offset(0, -4),
//           ),
//         ],
//       ),
//       padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           // Promo Code Row
//           CustomTextField(
//             borderRadius: 30,
//             controller: controller.promoController,
//             label: '',
//             hintText: "Enter promo code",
//             suffixWidget: GestureDetector(
//               onTap: controller.applyPromo,
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                 decoration: BoxDecoration(
//                   color: AppColors.appColor,
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 child: const Text(
//                   'Apply',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 13,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//
//           const SizedBox(height: 20),
//
//           // Price Rows
//           Obx(
//             () => Column(
//               children: [
//                 _PriceRow(
//                   label: 'Sub-Total',
//                   value: '\$${controller.subTotal.toStringAsFixed(2)}',
//                 ),
//                 const SizedBox(height: 10),
//                 _PriceRow(
//                   label: 'Delivery Fee',
//                   value: '\$${controller.deliveryFee.toStringAsFixed(2)}',
//                 ),
//                 const SizedBox(height: 10),
//                 _PriceRow(
//                   label: 'Discount',
//                   value: '-\$${controller.discount.toStringAsFixed(2)}',
//                   valueColor: Colors.red,
//                 ),
//                 const Divider(height: 24, color: Color(0xFFF0F0F0)),
//                 _PriceRow(
//                   label: 'Total Cost',
//                   value: '\$${controller.totalCost.toStringAsFixed(2)}',
//                   isBold: true,
//                 ),
//               ],
//             ),
//           ),
//
//           const SizedBox(height: 20),
//
//           // Proceed to Checkout
//           CustomButton(
//             text: 'Proceed to Checkout',
//             borderRadius: 50,
//             onPressed: controller.proceedToCheckout,
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // ─── Cart Item Tile (Swipeable) ───────────────────────────────────────────────
//
// class CartItemTile extends GetView<MyCartController> {
//   final CartItemModel item;
//
//   const CartItemTile({required this.item});
//
//   @override
//   Widget build(BuildContext context) {
//     return Dismissible(
//       key: ValueKey(item.id),
//       direction: DismissDirection.endToStart,
//       confirmDismiss: (_) async {
//         controller.confirmDelete(item); // ← yahan change karo
//         return false;
//       },
//       background: Container(
//         alignment: Alignment.centerRight,
//         margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
//         decoration: BoxDecoration(
//           color: const Color(0xFFFFE5E5),
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: const Padding(
//           padding: EdgeInsets.only(right: 20),
//           child: Icon(
//             Icons.delete_outline_rounded,
//             color: Colors.red,
//             size: 28,
//           ),
//         ),
//       ),
//       child: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 10,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             // Product Image
//             Container(
//               width: 72,
//               height: 72,
//               decoration: BoxDecoration(
//                 color: const Color(0xFFF3F2F2),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(12),
//                 child: Image.network(
//                   item.imagePath,
//                   fit: BoxFit.contain,
//                   errorBuilder: (_, __, ___) => const Icon(
//                     Icons.chair,
//                     size: 40,
//                     color: Color(0xFFAAAAAA),
//                   ),
//                 ),
//               ),
//             ),
//
//             const SizedBox(width: 12),
//
//             // Name + Category + Price
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     item.name,
//                     style: const TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black,
//                     ),
//                   ),
//                   const SizedBox(height: 2),
//                   Text(
//                     item.category,
//                     style: const TextStyle(fontSize: 12, color: Colors.grey),
//                   ),
//                   const SizedBox(height: 6),
//                   Obx(
//                     () => Text(
//                       '\$${item.totalPrice.toStringAsFixed(2)}',
//                       style: const TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             // Quantity Controller
//             _QuantityWidget(item: item),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // ─── Quantity Widget ──────────────────────────────────────────────────────────
//
// class _QuantityWidget extends GetView<MyCartController> {
//   final CartItemModel item;
//
//   const _QuantityWidget({required this.item});
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           // Minus
//           GestureDetector(
//             onTap: () => controller.decrement(item),
//             child: Container(
//               width: 28,
//               height: 28,
//               decoration: BoxDecoration(
//                 color: const Color(0xFFF3F2F2),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: const Icon(Icons.remove, size: 16, color: Colors.black54),
//             ),
//           ),
//
//           const SizedBox(width: 10),
//
//           // Count
//           Text(
//             '${item.quantity.value}',
//             style: const TextStyle(
//               fontSize: 15,
//               fontWeight: FontWeight.w600,
//               color: Colors.black,
//             ),
//           ),
//
//           const SizedBox(width: 10),
//
//           // Plus
//           GestureDetector(
//             onTap: () => controller.increment(item),
//             child: Container(
//               width: 28,
//               height: 28,
//               decoration: BoxDecoration(
//                 color: AppColors.appColor,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: const Icon(Icons.add, size: 16, color: Colors.white),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // ─── Price Row Widget ─────────────────────────────────────────────────────────
//
// class _PriceRow extends StatelessWidget {
//   final String label;
//   final String value;
//   final Color? valueColor;
//   final bool isBold;
//
//   const _PriceRow({
//     required this.label,
//     required this.value,
//     this.valueColor,
//     this.isBold = false,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: isBold ? 15 : 13,
//             color: isBold ? Colors.black : Colors.grey,
//             fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
//           ),
//         ),
//         Text(
//           value,
//           style: TextStyle(
//             fontSize: isBold ? 15 : 13,
//             color: valueColor ?? (isBold ? Colors.black : Colors.black87),
//             fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:furniture_app/app/widgets/custom_textfields.dart';
import 'package:get/get.dart';

import '../../app/models/cart_item_model.dart';
import '../../app/utils/app_colors.dart';
import '../../app/widgets/custom_button.dart';
import 'my_cart_controller.dart';

class MyCartView extends GetView<MyCartController> {
  MyCartView({super.key});

  var cartController = Get.put(MyCartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
         buildAppBar(),
          buildCartList(),
          buildBottomSection()
        ],
      ),
    );
  }

  // ── AppBar ─────────────────────────────────────────────────────────────────

  Widget buildAppBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Row(
          children: [
            buildBackButton(),
            buildAppBarTitle(),
            const SizedBox(width: 40), // balance
          ],
        ),
      ),
    );
  }

  Widget buildBackButton() {
    return GestureDetector(
      onTap: cartController.goBack,
      child: Container(
        width: 40,
        height: 35,
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
        child: const Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 16,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget buildAppBarTitle() {
    return const Expanded(
      child: Text(
        'My Cart',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }

  // ── Cart List ──────────────────────────────────────────────────────────────

  Widget buildCartList() {
    return Expanded(
      child: Obx(
            () => controller.cartItems.isEmpty
            ? buildEmptyCart()
            : buildCartListView(),
      ),
    );
  }

  Widget buildCartListView() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 0, bottom: 8),
      itemCount: controller.cartItems.length,
      itemBuilder: (_, index) {
        final item = controller.cartItems[index];
        return CartItemTile(item: item);
      },
    );
  }

  Widget buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.shopping_bag_outlined, size: 72, color: Color(0xFFCCCCCC)),
          SizedBox(height: 16),
          Text(
            'Your cart is empty',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // ── Bottom Section ─────────────────────────────────────────────────────────

  Widget buildBottomSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildPromoCodeField(),
          SizedBox(height: 20,),
          buildPriceSummary(),
          SizedBox(height: 20,),
          buildCheckoutButton()
        ],
      ),
    );
  }

  Widget buildPromoCodeField() {
    return CustomTextField(
      borderRadius: 30,
      controller: controller.promoController,
      label: '',
      hintText: "Enter promo code",
      suffixWidget: GestureDetector(
        onTap: controller.applyPromo,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
            color: AppColors.appColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Text(
            'Apply',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPriceSummary() {
    return Obx(
          () => Column(
        children: [
          _PriceRow(
            label: 'Sub-Total',
            value: '\$${controller.subTotal.toStringAsFixed(2)}',
          ),
          const SizedBox(height: 10),
          _PriceRow(
            label: 'Delivery Fee',
            value: '\$${controller.deliveryFee.toStringAsFixed(2)}',
          ),
          const SizedBox(height: 10),
          _PriceRow(
            label: 'Discount',
            value: '-\$${controller.discount.toStringAsFixed(2)}',
            valueColor: Colors.red,
          ),
          const Divider(height: 24, color: Color(0xFFF0F0F0)),
          _PriceRow(
            label: 'Total Cost',
            value: '\$${controller.totalCost.toStringAsFixed(2)}',
            isBold: true,
          ),
        ],
      ),
    );
  }

  Widget buildCheckoutButton() {
    return CustomButton(
      text: 'Proceed to Checkout',
      borderRadius: 50,
      onPressed: controller.proceedToCheckout,
    );
  }
}

// ─── Cart Item Tile (Swipeable) ───────────────────────────────────────────────

class CartItemTile extends GetView<MyCartController> {
  final CartItemModel item;

  const CartItemTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(item.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) async {
        controller.confirmDelete(item);
        return false;
      },
      background: buildSwipeBackground(),
      child: buildItemCard(),
    );
  }

  // ── Swipe Background ───────────────────────────────────────────────────────

  Widget buildSwipeBackground() {
    return Container(
      alignment: Alignment.centerRight,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE5E5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Padding(
        padding: EdgeInsets.only(right: 20),
        child: Icon(
          Icons.delete_outline_rounded,
          color: Colors.red,
          size: 28,
        ),
      ),
    );
  }

  // ── Item Card ──────────────────────────────────────────────────────────────

  Widget buildItemCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          buildProductImage(),
          const SizedBox(width: 12),
          buildProductInfo(),
          _QuantityWidget(item: item),
        ],
      ),
    );
  }

  Widget buildProductImage() {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        color: const Color(0xFFF3F2F2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          item.imagePath,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => const Icon(
            Icons.chair,
            size: 40,
            color: Color(0xFFAAAAAA),
          ),
        ),
      ),
    );
  }

  Widget buildProductInfo() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildProductName(),
          const SizedBox(height: 2),
          buildProductCategory(),
          const SizedBox(height: 6),
          buildProductPrice(),
        ],
      ),
    );
  }

  Widget buildProductName() {
    return Text(
      item.name,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    );
  }

  Widget buildProductCategory() {
    return Text(
      item.category,
      style: const TextStyle(fontSize: 12, color: Colors.grey),
    );
  }

  Widget buildProductPrice() {
    return Obx(
          () => Text(
        '\$${item.totalPrice.toStringAsFixed(2)}',
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}

// ─── Quantity Widget ──────────────────────────────────────────────────────────

class _QuantityWidget extends GetView<MyCartController> {
  final CartItemModel item;

  const _QuantityWidget({required this.item});

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildDecrementButton(),
          const SizedBox(width: 10),
          buildQuantityCount(),
          const SizedBox(width: 10),
          buildIncrementButton(),
        ],
      ),
    );
  }

  Widget buildDecrementButton() {
    return GestureDetector(
      onTap: () => controller.decrement(item),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: const Color(0xFFF3F2F2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.remove, size: 16, color: Colors.black54),
      ),
    );
  }

  Widget buildQuantityCount() {
    return Text(
      '${item.quantity.value}',
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    );
  }

  Widget buildIncrementButton() {
    return GestureDetector(
      onTap: () => controller.increment(item),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: AppColors.appColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.add, size: 16, color: Colors.white),
      ),
    );
  }
}

// ─── Price Row Widget ─────────────────────────────────────────────────────────

class _PriceRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final bool isBold;

  const _PriceRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildLabel(),
        buildValue(),
      ],
    );
  }

  Widget buildLabel() {
    return Text(
      label,
      style: TextStyle(
        fontSize: isBold ? 15 : 13,
        color: isBold ? Colors.black : Colors.grey,
        fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
      ),
    );
  }

  Widget buildValue() {
    return Text(
      value,
      style: TextStyle(
        fontSize: isBold ? 15 : 13,
        color: valueColor ?? (isBold ? Colors.black : Colors.black87),
        fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
      ),
    );
  }
}