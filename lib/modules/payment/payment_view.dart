import 'package:flutter/material.dart';
import 'package:furniture_app/app/utils/app_image.dart';
import 'package:furniture_app/modules/payment/payment_controller.dart';
import 'package:get/get.dart';

import '../../app/utils/app_colors.dart';
import '../../app/widgets/custom_button.dart';

class PaymentView extends GetView<PaymentController> {
  const PaymentView({super.key});

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
                  buildAppBar(),
                  buildCase(),
                  SizedBox(height: 16,),
                  buildCardView(),
                  SizedBox(height: 16,),
                  buildPaymentOptions(),
                  SizedBox(height: 100,)
                ],
              ),
            ),
          ),

          // Bottom Bar
          buildBottomBar()
        ],
      ),
    );
  }

  Widget buildCase(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSectionLabel('Cash'),
        buildCard(
          child: Obx(() => PaymentTile(
            icon: Icons.wallet_outlined,
            iconColor: AppColors.appColor,
            label: 'Cash',
            isSelected:
            controller.selectedMethodId.value == 'cash',
            onTap: () => controller.selectMethod('cash'),
          )),
        ),
      ],
    );
  }

  Widget buildCardView(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSectionLabel('Credit & Debit Card'),
        buildCard(
          child: Column(
            children: [
              // Saved cards
              Obx(() => Column(
                children: controller.savedCards.map((card) {
                  final isSelected =
                      controller.selectedMethodId.value ==
                          card.id;
                  return Column(
                    children: [
                      PaymentTile(
                        icon: Icons.credit_card_outlined,
                        iconColor: AppColors.appColor,
                        label:
                        '**** **** **** ${card.lastFour}',
                        subtitle: card.holderName,
                        isSelected: isSelected,
                        onTap: () =>
                            controller.selectMethod(card.id),
                      ),
                      const Divider(
                          height: 1,
                          color: Color(0xFFF0F0F0),
                          indent: 16,
                          endIndent: 16),
                    ],
                  );
                }).toList(),
              )),

              // Add Card row
              GestureDetector(
                onTap: controller.goToAddCard,
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 16),
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color:
                          AppColors.appColor.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.credit_card_outlined,
                            color: AppColors.appColor, size: 20),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text('Add Card',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400)),
                      ),
                      const Icon(Icons.chevron_right_rounded,
                          color: Colors.grey, size: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

 Widget buildPaymentOptions(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSectionLabel('More Payment Options'),
        buildCard(
          child: Obx(() => Column(
            children: [
              PaymentTile(
                customIcon: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image.asset(AppImages.paypalLogo),
                ),
                label: 'Paypal',
                isSelected: controller.selectedMethodId.value ==
                    'paypal',
                onTap: () =>
                    controller.selectMethod('paypal'),
                showDivider: true,
              ),
              PaymentTile(
                customIcon: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image.asset(AppImages.appleLogo),
                ),
                iconColor: Colors.black,
                label: 'Apple Pay',
                isSelected: controller.selectedMethodId.value ==
                    'apple_pay',
                onTap: () =>
                    controller.selectMethod('apple_pay'),
                showDivider: true,
              ),
              PaymentTile(
                customIcon: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image.asset(AppImages.googleLogo),
                ),
                label: 'Google Pay',
                isSelected: controller.selectedMethodId.value ==
                    'google_pay',
                onTap: () =>
                    controller.selectMethod('google_pay'),
              ),
            ],
          )),
        ),
      ],
    );
  }

  Widget buildAppBar() {
    return SafeArea(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            GestureDetector(
              onTap: controller.goBack,
              child: Container(
                width: 40, height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFEEEEEE), width: 1.5),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2))],
                ),
                child: const Icon(Icons.arrow_back_ios_new_rounded, size: 16, color: Colors.black87),
              ),
            ),
            const Expanded(
              child: Text('Payment Methods',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.black)),
            ),
            const SizedBox(width: 40),
          ],
        ),
      ),
    );
  }

  Widget buildSectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
      child: Text(label,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black)),
    );
  }

  Widget buildCard({required Widget child}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            spreadRadius: 2,
            offset: const Offset(0, 6), // depth effect
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.7),
            blurRadius: 4,
            offset: const Offset(-2, -2), // top highlight
          ),
        ],
      ),
      child: child,
    );
  }

  Widget buildBottomBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12, offset: const Offset(0, -4))],
      ),
      child: Obx(() => CustomButton(
        text: 'Confirm Payment',
        borderRadius: 50,
        isLoading: controller.isLoading.value,
        onPressed: controller.confirmPayment,
      )),
    );
  }
}

// ─── Payment Tile ─────────────────────────────────────────────────────────────

class PaymentTile extends StatelessWidget {
  final IconData? icon;
  final Color? iconColor;
  final Widget? customIcon;
  final String label;
  final String? subtitle;
  final bool isSelected;
  final VoidCallback onTap;
  final bool showDivider;

  const PaymentTile({
    this.icon,
    this.iconColor,
    this.customIcon,
    required this.label,
    this.subtitle,
    required this.isSelected,
    required this.onTap,
    this.showDivider = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.appColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: customIcon ??
                        Icon(icon, color: iconColor ?? AppColors.appColor, size: 20),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(label,
                          style: const TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w500)),
                      if (subtitle != null)
                        Text(subtitle!,
                            style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ),
                // Radio
                AnimatedContainer(
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
                ),
              ],
            ),
          ),
        ),
        if (showDivider)
          const Divider(height: 1, color: Color(0xFFF0F0F0), indent: 16, endIndent: 16),
      ],
    );
  }
}