import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plexus_task/core/utils/constants/colors.dart';

class CustomTextfield extends StatelessWidget {
  final Color? fillColor;
  final String fieldText;
  final Color? borderColor;
  final bool isPassword;
  final String? prefixIcon;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final int maxLines;
  final Color? hintTextColor;
  final double? borderRadius;

  const CustomTextfield({
    super.key,
    this.fillColor,
    required this.fieldText,
    this.borderColor,
    this.isPassword = false,
    this.prefixIcon,
    this.controller,
    this.onChanged,
    this.maxLines = 1,
    this.hintTextColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isObscure = ValueNotifier<bool>(isPassword);

    return ValueListenableBuilder<bool>(
      valueListenable: isObscure,
      builder: (context, obscureValue, child) {
        return Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
          child: TextField(
            maxLines: maxLines,
            controller: controller,
            onChanged: onChanged,
            obscureText: obscureValue,
            cursorColor: AppColors.grey400Color,
            // cursorColor: ThemeColors.text(context),
            cursorHeight: 20.h,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.grey400Color,
              // color: ThemeColors.text(context),
            ),
            decoration: InputDecoration(
              prefixIcon: prefixIcon != null
                  ? Padding(
                      padding: EdgeInsets.only(left: 12.w, right: 8.w),
                      child: Image.asset(
                        prefixIcon!,
                        height: 16.h,
                        width: 16.w,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          // Fallback icon if asset image is missing
                          return Icon(
                            isPassword
                                ? Icons.lock_outline
                                : Icons.email_outlined,
                            color: AppColors.grey400Color,
                            size: 16.sp,
                          );
                        },
                      ),
                    )
                  : null,
              prefixIconConstraints: BoxConstraints(
                minWidth: 0,
                minHeight: 0,
                maxHeight: 24.h,
              ),
              suffixIconConstraints: BoxConstraints(
                minWidth: 0,
                minHeight: 0,
                maxHeight: 24.h,
              ),
              suffixIcon: isPassword
                  ? Padding(
                      padding: EdgeInsets.only(left: 8.w, right: 12.w),
                      child: GestureDetector(
                        onTap: () => isObscure.value = !isObscure.value,
                        child: Icon(
                          obscureValue
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          size: 16.h,
                          color: AppColors.grey400Color,
                        ),
                      ),
                    )
                  : null,
              isDense: true,
              filled: true,
              fillColor: fillColor ?? Colors.transparent,
              contentPadding: EdgeInsets.symmetric(
                vertical: 14.h,
                horizontal: 14.w,
              ),
              hintText: fieldText,
              hintStyle: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color:
                    hintTextColor ??
                    ThemeColors.text(context).withValues(alpha: 0.6),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 16.r),
                borderSide: BorderSide(
                  color:
                      borderColor ??
                      AppColors.grey500Color.withValues(alpha: 0.5),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 16.r),
                borderSide: BorderSide(
                  color:
                      borderColor ??
                      AppColors.grey500Color.withValues(alpha: 0.5),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
