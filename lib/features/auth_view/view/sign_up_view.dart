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

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<AuthController>();

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
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
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
                    isLoginPage: false,
                    title: 'Create an Account',
                    subtitle: 'Sign up to explore the premium catalog.',
                  ),
                  SizedBox(height: 40.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextProperty(
                      text: "User name",
                      textColor: ThemeColors.text(context),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  CustomTextfield(
                    fillColor: ThemeColors.card(context),
                    borderColor: ThemeColors.border(context),
                    borderRadius: 8.r,
                    prefixIcon: IconPath.nameicon,
                    fieldText: 'Enter your username',
                    controller: controller.usernameController,
                  ),
                  SizedBox(height: 16.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextProperty(
                      text: "Email",
                      textColor: ThemeColors.text(context),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  CustomTextfield(
                    fillColor: ThemeColors.card(context),
                    borderColor: ThemeColors.border(context),
                    borderRadius: 8.r,
                    prefixIcon: IconPath.mailIcon,
                    fieldText: 'Enter your email',
                    controller: controller.emailController,
                  ),
                  SizedBox(height: 16.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextProperty(
                      text: "Password",
                      textColor: ThemeColors.text(context),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  CustomTextfield(
                    fillColor: ThemeColors.card(context),
                    borderColor: ThemeColors.border(context),
                    borderRadius: 8.r,
                    isPassword: true,
                    prefixIcon: IconPath.lockIcon,
                    fieldText: 'Enter your password',
                    controller: controller.passwordController,
                  ),
                  SizedBox(height: 60.h),
                  Consumer<AuthController>(
                    builder: (context, authController, child) {
                      return CustomButton(
                        borderColor: Colors.transparent,
                        isShadowNeed: false,
                        icon: Icons.arrow_forward_rounded,
                        iconSize: 20.w,
                        text: authController.isSignupLoading
                            ? "Signing up..."
                            : "Sign Up",
                        onTap: () async {
                          if (!authController.isLoading) {
                            final success = await authController.signup(
                              context,
                            );
                            if (success && context.mounted) {
                              context.push(AppRoute.otp);
                            }
                          }
                        },
                      );
                    },
                  ),
                  SizedBox(height: 32.h),
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
                    text: "Continue with Google",
                    fontWeight: FontWeight.w400,
                    height: 24.h,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Apple sign-in is visual only. Please use the form.",
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 32.h),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Already have an account?   ",
                          style: TextStyle(
                            color: ThemeColors.subtitle(context),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Inter',
                          ),
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.go(AppRoute.login);
                            },
                          text: "Sign In",
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
