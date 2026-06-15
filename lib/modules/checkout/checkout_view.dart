import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/models/cart_item_model.dart';
import '../../app/utils/app_colors.dart';
import '../../app/widgets/custom_button.dart';
import 'checkout_controller.dart';


class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({super.key});

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
                  _buildAppBar(),
                  _buildShippingAddress(),
                  _buildDivider(),
                  _buildShippingType(),
                  _buildDivider(),
                  _buildOrderList(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  // ── AppBar ──────────────────────────────────────────────────────────────────

  Widget _buildAppBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            GestureDetector(
              onTap: controller.goBack,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: const Color(0xFFEEEEEE), width: 1.5),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2))
                  ],
                ),
                child: const Icon(Icons.arrow_back_ios_new_rounded,
                    size: 16, color: Colors.black87),
              ),
            ),
            const Expanded(
              child: Text('Checkout',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
            ),
            const SizedBox(width: 40),
          ],
        ),
      ),
    );
  }

  // ── Shipping Address ────────────────────────────────────────────────────────

  Widget _buildShippingAddress() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Shipping Address',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          const SizedBox(height: 14),
          Obx(() => Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.location_on_outlined,
                  size: 20, color: Colors.black54),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.selectedAddress.label,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      controller.selectedAddress.fullAddress,
                      style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          height: 1.4),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: controller.changeAddress,
                child: Text('CHANGE',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.appColor,
                        letterSpacing: 0.5)),
              ),
            ],
          )),
        ],
      ),
    );
  }

  // ── Shipping Type ───────────────────────────────────────────────────────────

  Widget _buildShippingType() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Choose Shipping Type',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          const SizedBox(height: 14),
          Obx(() => Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.inventory_2_outlined,
                  size: 20, color: Colors.black54),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.selectedShipping.name,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Estimated Arrival  ${controller.selectedShipping.estimatedArrival}',
                      style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          height: 1.4),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: controller.changeShipping,
                child: Text('CHANGE',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.appColor,
                        letterSpacing: 0.5)),
              ),
            ],
          )),
        ],
      ),
    );
  }

  // ── Order List ──────────────────────────────────────────────────────────────

  Widget _buildOrderList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Order List',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          const SizedBox(height: 12),
          Obx(() => Column(
            children: controller.orderItems
                .map((item) => _OrderItemTile(item: item))
                .toList(),
          )),
        ],
      ),
    );
  }

  // ── Divider ─────────────────────────────────────────────────────────────────

  Widget _buildDivider() {
    return const Divider(height: 1, color: Color(0xFFF0F0F0));
  }

  // ── Bottom Bar ──────────────────────────────────────────────────────────────

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, -4))
        ],
      ),
      child: Obx(() => CustomButton(
        text: 'Continue to Payment',
        borderRadius: 50,
        isLoading: controller.isLoading.value,
        onPressed: controller.continueToPayment,
      )),
    );
  }
}

// ─── Order Item Tile ──────────────────────────────────────────────────────────

class _OrderItemTile extends StatelessWidget {
  final CartItemModel item;

  const _OrderItemTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              // Image
              Container(
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
                    errorBuilder: (_, __, ___) => const Icon(Icons.chair,
                        size: 36, color: Color(0xFFAAAAAA)),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.name,
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black)),
                    const SizedBox(height: 3),
                    Text(item.category,
                        style: const TextStyle(
                            fontSize: 12, color: Colors.grey)),
                    const SizedBox(height: 5),
                    Obx(() => Text(
                      '\$${item.totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1, color: Color(0xFFF0F0F0)),
      ],
    );
  }
}
