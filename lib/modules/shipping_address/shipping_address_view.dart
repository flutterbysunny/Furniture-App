import 'package:flutter/material.dart';
import 'package:furniture_app/modules/shipping_address/shipping_address_controller.dart';
import 'package:get/get.dart';

import '../../app/models/shipping_address_model.dart';
import '../../app/utils/app_colors.dart';
import '../../app/widgets/custom_button.dart';

class ShippingAddressScreen extends GetView<ShippingAddressController> {
  const ShippingAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  buildAppBar(),
                  SizedBox(height: 12,),
                  buildAddressList(),
                  SizedBox(height: 16,),
                  buildAddNewAddress(),
                  SizedBox(height: 100,)
                ],
              ),
            ),
          ),
          buildBottomBar()
        ],
      ),
    );
  }

  // ── AppBar ─────────────────────────────────────────────────────────────────

  Widget buildAppBar() {
    return SafeArea(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          children: [
            buildBackButton(),
            buildAppBarTitle(),
            const SizedBox(width: 40),
          ],
        ),
      ),
    );
  }

  Widget buildBackButton() {
    return GestureDetector(
      onTap: controller.goBack,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFEEEEEE), width: 1.5),
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
        'Shipping Address',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }

  // ── Address List ───────────────────────────────────────────────────────────

  Widget buildAddressList() {
    return Container(
      color: Colors.white,
      child: Column(
        children: List.generate(controller.addresses.length, (i) {
          final addr = controller.addresses[i];
          final isLast = i == controller.addresses.length - 1;
          return Obx(() => _AddressTile(
            address: addr,
            isSelected: controller.tempSelectedId.value == addr.id,
            showDivider: !isLast,
          ));
        }),
      ),
    );
  }

  // ── Add New Address ────────────────────────────────────────────────────────

  Widget buildAddNewAddress() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: controller.addNewAddress,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFCCCCCC), width: 1.2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildAddIcon(),
              const SizedBox(width: 6),
              buildAddLabel(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAddIcon() {
    return Icon(Icons.add, color: AppColors.appColor, size: 18);
  }

  Widget buildAddLabel() {
    return Text(
      'Add New Shipping Address',
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.appColor,
      ),
    );
  }

  // ── Bottom Bar ─────────────────────────────────────────────────────────────

  Widget buildBottomBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
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
      child: buildApplyButton(),
    );
  }

  Widget buildApplyButton() {
    return CustomButton(
      text: 'Apply',
      borderRadius: 50,
      onPressed: controller.applyAddress,
    );
  }
}

// ─── Address Tile ─────────────────────────────────────────────────────────────

class _AddressTile extends GetView<ShippingAddressController> {
  final ShippingAddressModel address;
  final bool isSelected;
  final bool showDivider;

  const _AddressTile({
    required this.address,
    required this.isSelected,
    required this.showDivider,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.selectAddress(address.id),
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          buildTileContent(),
          if (showDivider) buildDivider(),
        ],
      ),
    );
  }

  // ── Tile Content ───────────────────────────────────────────────────────────

  Widget buildTileContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildLocationIcon(),
          const SizedBox(width: 12),
          buildAddressInfo(),
          const SizedBox(width: 12),
          buildRadioCircle(),
        ],
      ),
    );
  }

  Widget buildLocationIcon() {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Icon(
        Icons.location_on_outlined,
        size: 20,
        color: isSelected ? AppColors.appColor : Colors.grey,
      ),
    );
  }

  Widget buildAddressInfo() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildAddressLabel(),
          const SizedBox(height: 3),
          buildFullAddress(),
        ],
      ),
    );
  }

  Widget buildAddressLabel() {
    return Text(
      address.label,
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: isSelected ? Colors.black : Colors.black87,
      ),
    );
  }

  Widget buildFullAddress() {
    return Text(
      address.fullAddress,
      style: const TextStyle(fontSize: 13, color: Colors.grey, height: 1.4),
    );
  }

  Widget buildRadioCircle() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? AppColors.appColor : const Color(0xFFCCCCCC),
          width: isSelected ? 6 : 1.5,
        ),
      ),
    );
  }

  Widget buildDivider() {
    return const Divider(
      height: 1,
      color: Color(0xFFF0F0F0),
      indent: 20,
      endIndent: 20,
    );
  }
}