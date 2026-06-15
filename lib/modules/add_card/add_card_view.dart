import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../app/utils/app_colors.dart';
import '../../app/widgets/custom_button.dart';
import 'add_card_controller.dart';

class AddCardView extends GetView<AddCardController> {
  const AddCardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildAppBar(),
                    buildCardPreview(),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildHolderName(),
                          SizedBox(height: 16,),
                          buildCardNumberField(),
                          SizedBox(height: 16,),
                          buildCv(),
                          SizedBox(height: 20,),
                          buildSaveCard(),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Button
          buildBottom()
        ],
      ),
    );
  }

 Widget buildBottom(){
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, -4),
          )
        ],
      ),
      child: Obx(
            () => CustomButton(
          text: 'Add Card',
          borderRadius: 50,
          isLoading: controller.isLoading.value,
          onPressed: controller.addCard,
        ),
      ),
    );
  }

 Widget buildCv(){
    return Row(
      children: [
        Expanded(child: buildExpiryField()),
        const SizedBox(width: 16),
        Expanded(child: buildCvvField()),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────
  // APP BAR
  // ─────────────────────────────────────────────────────────────

  Widget buildAppBar() {
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
                    color: const Color(0xFFEEEEEE),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    )
                  ],
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 16,
                  color: Colors.black87,
                ),
              ),
            ),
            const Expanded(
              child: Text(
                'Add Card',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(width: 40),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────
  // CARD PREVIEW
  // ─────────────────────────────────────────────────────────────

  Widget buildCardPreview() {
    return Obx(
          () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          width: double.infinity,
          height: 220,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.appColor,
                AppColors.appColor.withOpacity(0.7),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.appColor.withOpacity(0.35),
                blurRadius: 20,
                spreadRadius: 1,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                top: -30,
                right: -20,
                child: Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.08),
                  ),
                ),
              ),

              Positioned(
                top: 40,
                right: 60,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.06),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text(
                          'VISA',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    Text(
                      controller.previewNumber.value,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2,
                      ),
                    ),

                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Card holder name',
                              style: TextStyle(
                                color: Colors.white60,
                                fontSize: 11,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              controller.previewName.value,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(width: 32),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Expiry date',
                              style: TextStyle(
                                color: Colors.white60,
                                fontSize: 11,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              controller.previewExpiry.value,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),

                        const Spacer(),

                        const Icon(
                          Icons.credit_card,
                          color: Colors.white60,
                          size: 28,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────
  // HOLDER NAME
  // ─────────────────────────────────────────────────────────────

  Widget buildHolderName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        fieldLabel('Card Holder Name'),
        const SizedBox(height: 8),
        buildTextField(
          controller: controller.nameController,
          hint: 'Esther Howard',
          onChanged: controller.onNameChanged,
          validator: (v) => v == null || v.trim().isEmpty
              ? 'Enter card holder name'
              : null,
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────
  // CARD NUMBER
  // ─────────────────────────────────────────────────────────────

  Widget buildCardNumberField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        fieldLabel('Card Number'),
        const SizedBox(height: 8),
        buildTextField(
          controller: controller.numberController,
          hint: '4716 9627 1635 8047',
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            _CardNumberFormatter(),
          ],
          onChanged: controller.onNumberChanged,
          validator: (v) {
            final clean = (v ?? '').replaceAll(' ', '');
            if (clean.length != 16) {
              return 'Enter valid 16-digit card number';
            }
            return null;
          },
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────
  // EXPIRY FIELD
  // ─────────────────────────────────────────────────────────────

  Widget buildExpiryField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        fieldLabel('Expiry Date'),
        const SizedBox(height: 8),
        buildTextField(
          controller: controller.expiryController,
          hint: '02/30',
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            _ExpiryFormatter(),
          ],
          onChanged: controller.onExpiryChanged,
          validator: (v) {
            if (v == null || v.trim().length < 5) {
              return 'Enter valid expiry';
            }
            return null;
          },
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────
  // CVV FIELD
  // ─────────────────────────────────────────────────────────────

  Widget buildCvvField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        fieldLabel('CVV'),
        const SizedBox(height: 8),
        buildTextField(
          controller: controller.cvvController,
          hint: '000',
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(3),
          ],
          obscureText: true,
          validator: (v) {
            if (v == null || v.trim().length < 3) {
              return 'Enter valid CVV';
            }
            return null;
          },
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────
  // SAVE CARD
  // ─────────────────────────────────────────────────────────────

  Widget buildSaveCard() {
    return Obx(
          () => GestureDetector(
        onTap: () => controller.saveCard.toggle(),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: controller.saveCard.value
                    ? AppColors.appColor
                    : Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: controller.saveCard.value
                      ? AppColors.appColor
                      : const Color(0xFFCCCCCC),
                  width: 2,
                ),
              ),
              child: controller.saveCard.value
                  ? const Icon(
                Icons.check,
                size: 14,
                color: Colors.white,
              )
                  : null,
            ),
            const SizedBox(width: 10),
            const Text(
              'Save Card',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────
  // FIELD LABEL
  // ─────────────────────────────────────────────────────────────

  Widget fieldLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────
  // COMMON TEXTFIELD
  // ─────────────────────────────────────────────────────────────

  Widget buildTextField({
    required TextEditingController controller,
    required String hint,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    void Function(String)? onChanged,
    String? Function(String?)? validator,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      validator: validator,
      obscureText: obscureText,
      style: const TextStyle(
        fontSize: 14,
        color: Colors.black87,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 14,
        ),
        filled: true,
        fillColor: const Color(0xFFF3F2F2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        isDense: true,
        counterText: '',
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// CARD NUMBER FORMATTER
// ─────────────────────────────────────────────────────────────

class _CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final text = newValue.text.replaceAll(' ', '');

    if (text.length > 16) return oldValue;

    final buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      if (i != 0 && i % 4 == 0) {
        buffer.write(' ');
      }
      buffer.write(text[i]);
    }

    final formatted = buffer.toString();

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(
        offset: formatted.length,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// EXPIRY FORMATTER
// ─────────────────────────────────────────────────────────────

class _ExpiryFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    var text = newValue.text.replaceAll('/', '');

    if (text.length > 4) {
      text = text.substring(0, 4);
    }

    final buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      if (i == 2) {
        buffer.write('/');
      }
      buffer.write(text[i]);
    }

    final formatted = buffer.toString();

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(
        offset: formatted.length,
      ),
    );
  }
}