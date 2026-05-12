import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../utils/app_colors.dart';
import '../utils/app_image.dart';
import 'app_styles.dart';
import 'custom_container.dart';

class TextBorderFields extends StatefulWidget {
  String? hintText;
  String? labelText;
  int minLine, maxLength;
  TextEditingController? textEditingController;
  TextInputAction textInputAction;
  TextInputType textInputType;
  Function? onchange, onclick, onFieldSubmitted;
  bool isEnabled;
  var customValidator;
  var autoFillHint;
  final bool? obscureText;
  final Widget? suffixIcon;
  final bool? autofocus;
  final FocusNode? focusNode;
  final TextAlign textAlign;
  final TextStyle? labelStyle;
  final Widget? prefixIcon;
  final bool isPassword;
  final String? suffixImage;
  final double borderRadius;

  TextBorderFields({
    super.key,
    this.customValidator,
    this.hintText,
    this.labelText,
    this.autoFillHint,
    this.prefixIcon,
    this.minLine = 1,
    this.maxLength = 200,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.textEditingController,
    this.obscureText,
    this.suffixIcon,
    this.onchange,
    this.onclick,
    this.onFieldSubmitted,
    this.focusNode,
    this.autofocus,
    this.isEnabled = true,
    this.isPassword = false,
    this.suffixImage,
    this.textAlign = TextAlign.start,
    this.labelStyle,
    this.borderRadius = 10.0,
  });

  @override
  State<TextBorderFields> createState() => _TextBorderFieldsState();
}

class _TextBorderFieldsState extends State<TextBorderFields> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: widget.textAlign,
      controller: widget.textEditingController,
      minLines: widget.isPassword ? 1 : widget.minLine,
      maxLines: widget.isPassword ? 1 : 10,
      maxLength: widget.maxLength,
      enabled: widget.isEnabled,
      onTap: () => widget.onclick?.call(),
      style: AppStyles.titleText(),
      keyboardType: widget.textInputType,
      textInputAction: widget.textInputAction,
      validator: widget.customValidator,
      autofillHints: widget.autoFillHint,
      obscureText: widget.isPassword ? !_isVisible : false,
      decoration: InputDecoration(
        labelText: widget.labelText,
        prefixIcon: widget.prefixIcon,
        labelStyle:
            widget.labelStyle ?? TextStyle(color: Colors.grey, fontSize: 16),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () => setState(() {
                  _isVisible = !_isVisible;
                }),
                icon: SvgPicture.asset(
                  _isVisible ? AppImages.showIcon : AppImages.hideIcon,
                  color: AppColors.appSoftColor,
                ),
              )
            : widget.suffixIcon,
        suffix: widget.suffixImage == null || widget.suffixImage == ""
            ? null
            : SvgPicture.asset(widget.suffixImage.toString(), height: 20),
        counterText: '',
        hintText: widget.hintText,
        hintStyle: AppStyles.bodyText(color: AppColors.appSoftColor),

        // ✅ Newly added/updated part
        filled: true,
        fillColor: Colors.grey[50],
        contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 14.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.appSoftColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool isPassword;
  final bool isRequired;
  final String? errorText;
  final int? maxLines;
  final int? maxLength;
  final int? errorMaxLines;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final Color? labelColor;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  final TextInputAction textInputAction;
  final void Function(String)? onFieldSubmitted;

  // ✅ New: FocusNode
  final FocusNode? focusNode;

  const CustomTextFormField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.isRequired = false,
    this.errorText,
    this.maxLines = 1,
    this.maxLength,
    this.inputFormatters,
    this.prefixIcon,
    this.labelColor,
    this.validator,
    this.onChanged,
    this.textInputAction = TextInputAction.done,
    this.onFieldSubmitted,
    this.focusNode,
    this.errorMaxLines,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    final bool showPassword = widget.isPassword;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: widget.label,
            style: AppStyles.titleText(
              color: widget.labelColor ?? AppColors.blackColor,
              fontSize: 2.sh,
              fontWeight: FontWeight.w400,
            ),
            children: widget.isRequired
                ? [
                    TextSpan(
                      text: ' *',
                      style: AppStyles.titleText(
                        color: Colors.red,
                        fontSize: 2.sh,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ]
                : [],
          ),
        ),
        SizedBox(height: 1.h),
        TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          // ✅ Added
          obscureText: showPassword ? !_isVisible : false,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          onFieldSubmitted: widget.onFieldSubmitted,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          inputFormatters: widget.inputFormatters,
          validator: widget.validator,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            hintText: widget.hintText,
            counterText: "",
            hintStyle: AppStyles.titleText(
              color: AppColors.blackColor.withOpacity(.6),
              fontSize: 1.8.sh,
              fontWeight: FontWeight.w400,
            ),
            filled: true,
            fillColor: const Color(0xFFF5F5F5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            // contentPadding: EdgeInsets.symmetric(
            //   horizontal: 2.w,
            //   vertical: 2.h,
            // ),
            prefixIcon: widget.prefixIcon,
            suffixIcon: showPassword
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _isVisible = !_isVisible;
                      });
                    },
                    icon: Icon(
                      _isVisible ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey[400],
                      size: 20.sp,
                    ),
                  )
                : null,
            isDense: true,

            errorText: widget.errorText,
            errorMaxLines: widget.errorMaxLines,
            errorStyle: AppStyles.bodyText(
              color: Colors.red,
              fontSize: 1.9.sh,
              fontWeight: FontWeight.w400,
            ).copyWith(height: 1.0),
          ),
        ),
      ],
    );
  }
}

class CustomTextField extends StatefulWidget {
  final String label;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final int? maxLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final IconData? suffixIcon;
  final Widget? suffixWidget;
  final bool isPassword;
  final bool isRequired;
  final Color? labelColor;
  final String? hintText;
  final TextInputType keyboardType;
  final double borderRadius;


  // ⭐ NEW
  final bool readOnly;
  final VoidCallback? onTap;

  // ⭐ NEW — CUSTOM SUFFIX ICON COLOR
  final Color? suffixIconColor;

  const CustomTextField({
    super.key,
    required this.label,
    this.controller,
    this.onChanged,
    this.validator,
    this.maxLines = 1,
    this.maxLength,
    this.inputFormatters,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassword = false,
    this.isRequired = false,
    this.labelColor,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
    this.onTap,
    this.suffixWidget,

    // ⭐ NEW
    this.borderRadius = 12,

    this.suffixIconColor,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    final bool showPassword = widget.isPassword;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: widget.label,
              style: AppStyles.titleText(
                color: widget.labelColor ?? AppColors.blackColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              children: widget.isRequired
                  ? [
                      const TextSpan(
                        text: ' *',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ]
                  : [],
            ),
          ),
          const SizedBox(height: 8),

          TextFormField(
            controller: widget.controller,
            onChanged: widget.onChanged,
            validator: widget.validator,
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            obscureText: showPassword ? !_isVisible : false,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters,
            readOnly: widget.readOnly,
            onTap: widget.onTap,

            decoration: InputDecoration(
              hintText: widget.hintText,
              counterText: widget.maxLength != null ? null : '',
              filled: true,
              fillColor: const Color(0xFFF3F2F2),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide.none,
              ),
              counter: Text(''),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 14,
              ),
              prefixIcon: widget.prefixIcon,

              // ⭐ APPLY CUSTOM SUFFIX COLOR HERE
              suffixIcon: showPassword
                  ? IconButton(
                onPressed: () {
                  setState(() {
                    _isVisible = !_isVisible;
                  });
                },
                icon: Icon(
                  _isVisible ? Icons.visibility_off : Icons.visibility,
                  color: widget.suffixIconColor ?? Colors.grey[400],
                  size: 20,
                ),
              )
                  : widget.suffixWidget,
              isDense: true,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomPhoneTextField extends StatelessWidget {
  final TextEditingController? controller;
  final bool? obscureText;
  final bool autoFocus;
  final String? hintText;
  final Color? hintColor;
  final Color? color;
  final double? fontSize;
  final bool? isTitle;
  final String? title;
  final bool? enabled;
  final bool? isDense;
  final TextAlign? textAlign;
  final TextInputType? inputType;
  final List<TextInputFormatter>? inputFormat;
  final TextInputAction? textInputAction;
  final TextCapitalization? textCapitalization;
  final ValueChanged<String>? onSubmit;
  final ValueChanged<String>? onChange;
  final GestureTapCallback? onTap;
  final FocusNode? focusNode;
  final bool? isMaxLines;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final bool? isError;
  final bool? isHight;
  final bool? borderVisible;

  // final bool? enableInteractiveSelection;
  final bool? containerVisible;
  final Widget? suffix;
  final Widget? prefixIcon;
  final EdgeInsets? padding;

  const CustomPhoneTextField({
    Key? key,
    required this.controller,
    this.obscureText = false,
    this.autoFocus = false,
    this.hintText,
    this.color,
    this.fontSize,
    this.hintColor,
    this.isTitle = false,
    this.title,
    this.enabled = true,
    this.isDense = true,
    this.textAlign = TextAlign.start,
    this.inputType = TextInputType.text,
    this.inputFormat,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization,
    this.onSubmit,
    this.onChange,
    this.onTap,
    this.focusNode,
    this.isMaxLines = false,
    this.maxLength,
    this.minLines,
    this.maxLines = 1,
    this.isError = false,
    // this.enableInteractiveSelection = false,
    this.isHight = true,
    this.borderVisible = true,
    this.containerVisible = true,
    this.suffix,
    this.prefixIcon,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.shortestSide >= 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isTitle!
            ? Text(
                title!,
                style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              )
            : const SizedBox(),
        isTitle! ? SizedBox(height: 1.h) : const SizedBox(),
        containerVisible!
            ? CustomContainer(
                borderRadius: 10,
                height: isTablet ? 6.0.h : 6.0.h,
                borderVisible: borderVisible!,
                errorView: isError,
                isHeight: isHight,
                padding: padding,
                child: Row(
                  children: [
                    Expanded(child: textField()),
                    suffix ?? const SizedBox(),
                    // prefixIcon ?? const SizedBox(),
                  ],
                ),
              )
            : textField(),
      ],
    );
  }

  Widget textField() {
    return TextField(
      controller: controller,
      cursorColor: AppColors.appColor,
      cursorWidth: 2,
      autofocus: autoFocus,
      keyboardType: inputType,
      enabled: enabled,
      obscureText: obscureText!,
      textInputAction: textInputAction,
      onSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      textAlign: textAlign!,
      autocorrect: false,
      focusNode: focusNode,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      maxLines: isMaxLines! ? null : maxLines,
      maxLength: maxLength,
      minLines: minLines,
      inputFormatters: inputFormat,
      style: AppStyles.titleText(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      // style: TextStyle(
      //   fontWeight: FontWeight.w500,
      //   fontSize: fontSize,
      //   fontFamily: "Skolar Cyrillic",
      //   color: color ?? AppColors.blackColor,
      // ),
      decoration: InputDecoration(
        isDense: isDense,
        border: InputBorder.none,
        contentPadding: const EdgeInsets.all(4),
        hintText: hintText,
        icon: prefixIcon,
        counter: null,
        counterText: "",
        hintStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16, // mobile number and all in hint
          color: hintColor ?? AppColors.lightGrey,
          fontFamily: "Skolar Cyrillic",
        ),
      ),
    );
  }
}

class CustomDropdown<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final String? hintText;
  final Color? hintColor;
  final Color? color;
  final double? fontSize;
  final bool? isError;
  final bool? isTitle;
  final String? title;
  final bool? enabled;
  final bool? borderVisible;
  final bool? isHight;
  final Widget? prefixIcon;
  final EdgeInsets? padding;

  const CustomDropdown({
    Key? key,
    required this.items,
    this.value,
    this.onChanged,
    this.hintText,
    this.hintColor,
    this.color,
    this.fontSize,
    this.isError = false,
    this.isTitle = false,
    this.title,
    this.enabled = true,
    this.borderVisible = true,
    this.isHight = true,
    this.prefixIcon,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.shortestSide >= 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Optional Title (same as CustomPhoneTextField)
        if (isTitle!)
          Text(
            title!,
            style: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
            ),
          ),

        // Same CustomContainer as your text field
        CustomContainer(
          borderRadius: 10,
          height: isTablet ? 6.5.h : 6.0.h,
          borderVisible: borderVisible!,
          errorView: isError,
          isHeight: isHight,
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 4),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              dropdownColor: Colors.white,                          // ✅ white background
              borderRadius: BorderRadius.circular(12),
              padding: EdgeInsets.only(left: 8),
              value: value,
              isExpanded: true,
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.grey,
                size: 20,
              ),
              hint: Row(
                children: [
                  if (prefixIcon != null) ...[
                    prefixIcon!,
                    const SizedBox(width: 8),
                  ],
                  // SizedBox(width: 8),
                  Text(
                    hintText ?? 'Select',
                    style: TextStyle(
                      fontSize: fontSize ?? 16,
                      fontWeight: FontWeight.w400,
                      color: hintColor ?? AppColors.lightGrey,
                      fontFamily: "Skolar Cyrillic",
                    ),
                  ),
                ],
              ),
              style: AppStyles.titleText(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              onChanged: enabled! ? onChanged : null,
              items: items,
            ),
          ),
        ),
      ],
    );
  }
}
