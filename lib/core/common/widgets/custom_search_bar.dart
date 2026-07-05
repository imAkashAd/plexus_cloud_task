import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plexus_task/core/utils/constants/colors.dart';

class CustomSearchBar extends StatelessWidget {
  final double? boxtHeight;
  final double? fontSize;
  final Color? fillColor;
  final String hintText;
  final Color? iconColor;
  final bool showBorder;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final double? borderRadius;
  final bool isShadowNeed;
  final Color? borderColor;

  const CustomSearchBar({
    super.key,
    required this.hintText,
    this.boxtHeight,
    this.fillColor,
    this.iconColor,
    this.fontSize,
    this.showBorder = true,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.borderRadius,
    this.isShadowNeed = false,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: boxtHeight ?? 44.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        style: TextStyle(
          fontFamily: 'Inter',
          color: ThemeColors.text(context),
          fontSize: fontSize ?? 16.sp,
        ),
        cursorColor: ThemeColors.text(context),
        cursorHeight: 16.h,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: fillColor ?? Colors.transparent,
          hintStyle: TextStyle(
            fontFamily: 'Inter',
            color: AppColors.grey500Color,
            fontSize: fontSize ?? 14.sp,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 10.h,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: iconColor ?? AppColors.grey400Color,
            size: 20.w,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
            borderSide: showBorder
                ? BorderSide(
                    color:
                        borderColor ??
                        AppColors.grey500Color.withValues(alpha: 0.3),
                  )
                : BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
            borderSide: showBorder
                ? BorderSide(color: borderColor ?? AppColors.primaryColor)
                : BorderSide.none,
          ),
        ),
      ),
    );
  }
}
