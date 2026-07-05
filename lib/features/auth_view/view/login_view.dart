import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:plexus_task/core/common/widgets/custom_button.dart';
import 'package:plexus_task/core/common/widgets/custom_textfield.dart';
import 'package:plexus_task/core/common/widgets/text_property.dart';
import 'package:plexus_task/core/utils/constants/colors.dart';
import 'package:plexus_task/core/utils/constants/icon_path.dart';
import 'package:plexus_task/core/utils/constants/image_path.dart';
import 'package:plexus_task/features/auth_view/controller/auth_controller.dart';
import 'package:plexus_task/features/auth_view/widgets/auth_title_appbar.dart';
import 'package:plexus_task/routes/app_routes.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = context.read<AuthController>();

    return Scaffold(
      backgroundColor: ThemeColors.background(context),
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Container(
            decoration: ThemeColors.authDecoration(context),
          ),
          Image.asset(
            ImagePath.backgroundimage,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            errorBuilder: (context, error, stackTrace) =>
                const SizedBox.shrink(),
          ),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Padding(
              padding: EdgeInsets.fromLTRB(24.w, 84.h, 24.w, 48.h),
              child: Column(
                children: [
                  const AuthTitleAppbar(
                    isLoginPage: true,
                    title: 'Welcome Back',
                    subtitle:
                        'Log in to explore and purchase premium products.',
                  ),
                  SizedBox(height: 40.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextProperty(
                      text: "Email / Username",
                      textColor: ThemeColors.text(context),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  CustomTextfield(
                    fillColor: ThemeColors.card(context),
                    borderColor: ThemeColors.border(context),
                    borderRadius: 8.r,
                    isPassword: false,
                    prefixIcon: IconPath.mailIcon,
                    fieldText: 'Enter email or FakeStore user (e.g. mor_2314)',
                    controller: authController.emailController,
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextProperty(
                        text: "Password",
                        textColor: ThemeColors.text(context),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Tip: Use FakeStore account 'mor_2314' and password '83r5^_' to call API.",
                              ),
                              backgroundColor: Colors.blueAccent,
                            ),
                          );
                        },
                        child: const TextProperty(
                          text: "Hint?",
                          fontSize: 14,
                          textColor: AppColors.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  CustomTextfield(
                    fillColor: ThemeColors.card(context),
                    borderColor: ThemeColors.border(context),
                    isPassword: true,
                    borderRadius: 8.r,
                    prefixIcon: IconPath.lockIcon,
                    fieldText: 'Enter password',
                    controller: authController.passwordController,
                  ),
                  SizedBox(height: 60.h),
                  Consumer<AuthController>(
                    builder: (context, controller, child) {
                      return CustomButton(
                        borderColor: Colors.transparent,
                        isShadowNeed: false,
                        text: controller.isLoginLoading
                            ? "Signing in..."
                            : "Sign In",
                        icon: Icons.arrow_forward,
                        iconSize: 20.w,
                        onTap: () async {
                          if (!controller.isLoading) {
                            final success = await controller.login(context);
                            if (success && context.mounted) {
                              context.go(AppRoute.dashboard);
                            }
                          }
                        },
                      );
                    },
                  ),
                  SizedBox(height: 40.h),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: ThemeColors.border(context).withValues(alpha: 0.3),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      TextProperty(
                        text: "Or continue with",
                        fontSize: 14.sp,
                        textColor: ThemeColors.subtitle(context),
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: ThemeColors.border(context).withValues(alpha: 0.3),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32.h),
                  CustomButton(
                    borderColor: ThemeColors.border(context),
                    color: ThemeColors.card(context),
                    textColor: ThemeColors.text(context),
                    isShadowNeed: false,
                    text: "Continue with google",
                    fontWeight: FontWeight.w400,
                    height: 24.h,
                    onTap: () async {
                      authController.emailController.text = "mor_2314";
                      authController.passwordController.text = "83r5^_";
                      final success = await authController.login(context);
                      if (success && context.mounted) {
                        context.go(AppRoute.dashboard);
                      }
                    },
                  ),
                  SizedBox(height: 32.h),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Don't have an account?   ",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            color: ThemeColors.subtitle(context),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.push(AppRoute.signup);
                            },
                          text: " Sign Up",
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            color: AppColors.primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
