import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../utils/app_colors.dart';

class CustomContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final double? horizontalPadding;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? containerColor;
  final bool? errorView;
  final bool? successView;
  final double? borderRadius;
  final bool? circleView;
  final bool? boxShadowVisible;
  final bool? borderVisible;
  final bool? isHeight;
  final Widget? child;
  final bool? isSuccess;

  const CustomContainer({
    Key? key,
    this.height,
    this.width,
    this.horizontalPadding,
    this.padding,
    this.margin,
    this.containerColor,
    this.errorView = false,
    this.isSuccess = false,
    this.successView = false,
    this.borderRadius,
    this.circleView = false,
    this.boxShadowVisible = false,
    this.borderVisible = false,
    this.isHeight = true,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height:  height,
      width: width,
      alignment: Alignment.center,
      padding: padding ?? EdgeInsets.symmetric(horizontal: horizontalPadding ?? (circleView! ? 0 : 0.8.h)),
      margin: margin ?? EdgeInsets.symmetric(vertical: horizontalPadding ?? (circleView! ? 0 : 1.4.h)),
      decoration: BoxDecoration(
        color: containerColor ?? AppColors.whiteColor,
        borderRadius: circleView! ? null : BorderRadius.circular(borderRadius ?? 10.6.h),
        border: borderVisible!
            ? Border.all(
          color:  errorView! ? AppColors.errorColor : AppColors.appColor,
          width: 2,
        )
            : null,
        shape: circleView! ? BoxShape.circle : BoxShape.rectangle,
        boxShadow: boxShadowVisible!
            ? [
          BoxShadow(
            color: AppColors.lightGrey,
            blurRadius: 8,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ]
            : null,
      ),
      child: child,
    );
  }
}
