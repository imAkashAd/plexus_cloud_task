import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:plexus_task/core/common/widgets/custom_button.dart';
import 'package:plexus_task/core/common/widgets/text_property.dart';
import 'package:plexus_task/core/utils/constants/colors.dart';
import 'package:plexus_task/core/utils/constants/image_path.dart';
import 'package:plexus_task/routes/app_routes.dart';

class GetStartedView extends StatelessWidget {
  const GetStartedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient (Fallback if asset doesn't exist)
          Container(
            decoration: ThemeColors.authDecoration(context),
          ),
          // Try loading background image
          Image.asset(
            ImagePath.backgroundimage,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            errorBuilder: (context, error, stackTrace) {
              return const SizedBox.shrink(); // Silent fallback to gradient
            },
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(24.w, 0.h, 24.w, 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Center(
                    child: Image.asset(
                      ImagePath.applogo,
                      width: 200,
                      filterQuality: FilterQuality.high,
                      errorBuilder: (context, error, stackTrace) {
                        return TextProperty(
                          text: 'FAKE STORE',
                          textColor: AppColors.primaryColor,
                          fontSize: 36.sp,
                          fontWeight: FontWeight.w900,
                        );
                      },
                    ),
                  ),
                  const Spacer(),
                  Center(
                    child: TextProperty(
                      text: 'Explore Premium Products',
                      textColor: ThemeColors.text(context),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Center(
                    child: TextProperty(
                      text: 'Explore premium products, search by keyword, view favorites, and filter by categories instantly.',
                      textColor: ThemeColors.subtitle(context),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  CustomButton(
                    text: 'Get Started',
                    onTap: () {
                      context.push(AppRoute.signup);
                    },
                    icon: Icons.arrow_forward_rounded,
                    iconSize: 20.w,
                    borderColor: ThemeColors.border(context).withValues(alpha: 0.1),
                    isShadowNeed: true,
                  ),
                  SizedBox(height: 16.h),
                  CustomButton(
                    text: 'Sign In',
                    onTap: () {
                      context.push(AppRoute.login);
                    },
                    iconSize: 20.w,
                    color: ThemeColors.card(context),
                    textColor: ThemeColors.text(context),
                    borderColor: ThemeColors.border(context),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
