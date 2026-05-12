import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../utils/app_colors.dart';


class CustomButton extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final double horizontalPadding;
  final bool? showGradient;
  final AlignmentGeometry? gradientAlignmentBegin;
  final AlignmentGeometry? gradientAlignmentEnd;
  final List<Color>? gradientColors;
  final double? borderRadius;
  final BorderSide borderSide;
  final double? elevation;
  final Color? overlayColor;
  final Color? shadowColor;
  final bool? disableButton;
  final VoidCallback onPressed;
  final VoidCallback? onLongPress;
  final Widget? child;
  final double? widgetSpace;
  final MainAxisAlignment? widgetMainAxis;
  final IconData? icon;
  final Color? iconColor;
  final String? image;
  final double? imageSize;
  final Color? imageColor;
  final String? text;
  final Color? color;
  final TextStyle? style;
  final bool? isLoading;

  const CustomButton({
    Key? key,
    this.height,
    this.width,
    this.backgroundColor,
    this.horizontalPadding = 0,
    this.showGradient = false,
    this.gradientAlignmentBegin,
    this.gradientAlignmentEnd,
    this.gradientColors,
    this.borderRadius,
    this.borderSide = BorderSide.none,
    this.elevation,
    this.overlayColor,
    this.shadowColor,
    this.disableButton,
    this.onLongPress,
    required this.onPressed,
    this.child,
    this.widgetSpace,
    this.widgetMainAxis,
    this.icon,
    this.iconColor,
    this.image,
    this.imageSize,
    this.imageColor,
    this.text,
    this.color,
    this.style,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 6.5.h,
      width: width ?? MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: showGradient == true
          ? Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 10.5),
          gradient: LinearGradient(
            begin: gradientAlignmentBegin ?? Alignment.topLeft,
            end: gradientAlignmentEnd ?? Alignment.bottomRight,
            colors: gradientColors ??
                [
                  AppColors.appColor,
                  AppColors.appSoftColor,
                ],
          ),
        ),
        child: elevatedButton(context),
      )
          : elevatedButton(context),
    );
  }

  Widget elevatedButton(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            side: borderSide,
            borderRadius: BorderRadius.circular(borderRadius ?? 10.5),
          ),
        ),
        elevation: MaterialStateProperty.all(elevation),
        overlayColor: MaterialStateProperty.resolveWith((states) {
          return states.contains(MaterialState.pressed) ? overlayColor ?? AppColors.blackColor.withOpacity(0.14) : null;
        }),
        shadowColor: MaterialStateProperty.all(showGradient == true ? AppColors.transparentColor : shadowColor),
        backgroundColor: MaterialStateProperty.all(
          showGradient == true ? AppColors.transparentColor : backgroundColor ?? (disableButton != true ? AppColors.appColor : Theme.of(context).disabledColor),
        ),
      ),
      onPressed: disableButton != true ? onPressed : null,
      onLongPress: onLongPress,
      child: isLoading!
          ? SizedBox(
        height: 3.h,
        width: 3.h,
        child: CircularProgressIndicator(
          color: AppColors.whiteColor,
          strokeWidth: 2.4,
        ),
      )
          : child ??
          Row(
            mainAxisAlignment: widgetMainAxis ?? MainAxisAlignment.center,
            children: [
              if (icon != null)
                Row(

                  children: [
                    Icon(
                      icon,
                      color: iconColor ?? AppColors.whiteColor,
                      size: 24,
                    ),
                    SizedBox(width: widgetSpace ?? 10)
                  ],
                )
              else
                const SizedBox(),
              if (image != null && image != "")
                Row(

                  children: [
                    Image.asset(
                      image!,
                      height: imageSize ?? 22,
                      color: imageColor,
                    ),
                    SizedBox(width: widgetSpace ?? 10)
                  ],
                )
              else
                const SizedBox(),
              if (text != null && text != "")
                Text(
                  text!,
                  textAlign: TextAlign.center,
                  style: style ??
                      TextStyle(
                          color: color ?? AppColors.whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: "Skolar Cyrillic"
                      ),
                )
              else
                const SizedBox(),
            ],
          ),
    );
  }
}

