import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../modules/checkout/checkout_controller.dart';
import '../../utils/app_colors.dart';

class ShippingSheet extends GetView<CheckoutController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                  color: const Color(0xFFDDDDDD),
                  borderRadius: BorderRadius.circular(2)),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Select Shipping Type',
              style: TextStyle(
                  fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black)),
          const SizedBox(height: 12),
          Obx(() => Column(
            children: controller.shippingTypes.map((type) {
              final isSelected = controller.selectedShippingId.value == type.id;
              return GestureDetector(
                onTap: () => controller.selectShipping(type.id),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.appColor.withOpacity(0.06)
                        : const Color(0xFFF8F8F8),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.appColor
                          : Colors.transparent,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.inventory_2_outlined,
                          color: isSelected
                              ? AppColors.appColor
                              : Colors.grey,
                          size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(type.name,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: isSelected
                                            ? AppColors.appColor
                                            : Colors.black)),
                                const SizedBox(width: 8),
                                if (type.price == 0)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.green.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Text('Free',
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.green,
                                            fontWeight: FontWeight.w500)),
                                  )
                                else
                                  Text('+\$${type.price.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.grey)),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                                'Est. Arrival: ${type.estimatedArrival}',
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                      ),
                      if (isSelected)
                        Icon(Icons.check_circle,
                            color: AppColors.appColor, size: 20),
                    ],
                  ),
                ),
              );
            }).toList(),
          )),
        ],
      ),
    );
  }
}