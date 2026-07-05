import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plexus_task/core/common/widgets/text_property.dart';
import 'package:plexus_task/core/utils/constants/colors.dart';
import 'package:plexus_task/core/utils/constants/icon_path.dart';

class AuthTitleAppbar extends StatelessWidget {
  final bool isLoginPage;
  final String title;
  final String subtitle;

  const AuthTitleAppbar({
    required this.isLoginPage,
    required this.title,
    required this.subtitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isLoginPage == false)
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Image.asset(
              IconPath.backButton,
              width: 24.w,
              height: 24.h,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.arrow_back_ios_new,
                  color: ThemeColors.text(context),
                  size: 20.w,
                );
              },
            ),
          ),
        Expanded(
          child: Column(
            children: [
              TextProperty(
                text: title,
                fontSize: 36.sp,
                fontWeight: FontWeight.w700,
                textColor: ThemeColors.text(context),
              ),
              SizedBox(height: 8.h),
              TextProperty(
                text: subtitle,
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
                textColor: ThemeColors.subtitle(context),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}