import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plexus_task/core/utils/constants/colors.dart';
import 'package:plexus_task/core/utils/constants/icon_path.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double? dividerHeight;
  final Color? backgroundColor;
  final Color? dividerColor;
  final String? title;
  final String? middleTitle;
  final bool? homePage;
  final Color? titleColor;
  final Color? backButtonColor;
  final Color? middleTitleColor;
  final bool showEditButton;
  final VoidCallback? onEditTap;
  final String? rightButtonText;
  final String? rightButtonIcon;
  final Color? iconColor;
  final VoidCallback? onTap;

  const CustomAppBar({
    super.key,
    this.backgroundColor,
    this.dividerColor,
    this.title,
    this.middleTitle,
    this.dividerHeight,
    this.homePage,
    this.titleColor,
    this.backButtonColor,
    this.middleTitleColor,
    this.showEditButton = false,
    this.onEditTap,
    this.rightButtonText,
    this.rightButtonIcon,
    this.iconColor,
    this.onTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 50.h,
        bottom: 16.h,
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.defaultBackgroundColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (homePage == false)
            GestureDetector(
              onTap: onTap ?? () {
                Navigator.of(context).pop();
              },
              child: Image.asset(
                IconPath.backButton,
                width: 24.w,
                height: 24.h,
                color: backButtonColor ?? AppColors.whiteColor,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.arrow_back_ios_new,
                    color: backButtonColor ?? AppColors.whiteColor,
                    size: 20.w,
                  );
                },
              ),
            ),
          if (title != null) ...[
            SizedBox(width: 16.w),
            Text(
              title!,
              style: TextStyle(
                fontFamily: 'ProximaNova',
                fontSize: 24.sp,
                fontWeight: FontWeight.w500,
                color: titleColor ?? AppColors.whiteColor,
              ),
            ),
          ],
          if (middleTitle != null)
            Expanded(
              child: Text(
                middleTitle!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'ProximaNova',
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                  color: middleTitleColor ?? AppColors.whiteColor,
                ),
              ),
            )
          else
            const Spacer(),
          if (showEditButton || rightButtonText != null)
            GestureDetector(
              onTap: onEditTap,
              child: Row(
                children: [
                  if (rightButtonIcon != null)
                    Image.asset(
                      rightButtonIcon!,
                      height: 20.sp,
                      color: iconColor ?? AppColors.primaryTextColor,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.edit,
                          color: iconColor ?? AppColors.primaryTextColor,
                          size: 18.sp,
                        );
                      },
                    ),
                  if (rightButtonIcon != null && rightButtonText != null)
                    SizedBox(width: 4.w),
                  if (rightButtonText != null)
                    Text(
                      rightButtonText!,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.whiteColor,
                      ),
                    ),
                ],
              ),
            )
          else if (homePage == true)
            GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.settings_outlined,
                color: iconColor ?? AppColors.primaryTextColor,
              ),
            )
          else
            SizedBox(width: 30.w),
        ],
      ),
    );
  }
}
