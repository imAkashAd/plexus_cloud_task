import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plexus_task/core/utils/constants/colors.dart';

class CustomButton extends StatelessWidget {
  final Color? imageColor;
  final BorderRadius? borderRadius;
  final Color? iconColor;
  final IconData? icon;
  final Color? borderColor;
  final String text;
  final String? iconImagePath;
  final Color? color;
  final Color? textColor;
  final VoidCallback onTap;
  final double? fontSize;
  final double? width;
  final double? height;
  final double? iconSize;
  final double? buttonHeight;
  final double? buttonWidth;
  final String? prefixIcon;
  final String? fontFamily;
  final String? rightIconPath;
  final bool? isShadowNeed;
  final EdgeInsets? padding;
  final FontWeight? fontWeight;

  const CustomButton({
    this.imageColor,
    this.borderRadius,
    this.iconColor,
    super.key,
    required this.text,
    required this.onTap,
    this.iconImagePath,
    this.color,
    this.textColor,
    this.fontSize,
    this.borderColor,
    this.icon,
    this.width,
    this.height,
    this.iconSize,
    this.buttonHeight,
    this.buttonWidth,
    this.prefixIcon,
    this.fontFamily,
    this.isShadowNeed = false,
    this.padding,
    this.fontWeight,
    this.rightIconPath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: buttonWidth,
        // height: 40.h,
        padding: padding ?? EdgeInsets.only(
          top: 16.h,
          bottom: 16.h,
          left: 10.w,
          right: 10.w,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor ?? Colors.transparent,
            width: 1.w,
          ), 
          boxShadow: isShadowNeed == true ? [
            BoxShadow(
              color: AppColors.primaryColor.withAlpha(76),
              blurRadius: 12.r,
              offset: Offset(0, 4),
            )
            
          ] : [],
          borderRadius: borderRadius ?? BorderRadius.circular(16.r),
          color: color ?? AppColors.primaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconImagePath != null)
              Image.asset(
                iconImagePath!,
                height: height,
                width: width,
                color: imageColor,
              ),
            if (iconImagePath != null) SizedBox(width: 8.h),

            // ignore: unnecessary_null_comparison
            if (text != null)
              Text(
                text,
                style: TextStyle(
                  fontFamily: fontFamily ?? 'Inter',
                  fontWeight: fontWeight ?? FontWeight.w700,
                  fontSize: fontSize ?? 16.sp,
                  color: textColor ?? Colors.white,
                ),
              ),
            if (rightIconPath != null)
              Row(
                children: [
                  SizedBox(width: 8.w),
                  Image.asset(rightIconPath!, width: iconSize, height: iconSize, color: iconColor,),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
