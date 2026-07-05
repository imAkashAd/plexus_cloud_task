import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:plexus_task/core/common/widgets/custom_app_bar.dart';
import 'package:plexus_task/core/common/widgets/custom_button.dart';
import 'package:plexus_task/core/common/widgets/text_property.dart';
import 'package:plexus_task/core/utils/constants/colors.dart';
import 'package:plexus_task/core/utils/constants/image_path.dart';
import 'package:plexus_task/features/auth_view/controller/auth_controller.dart';
import 'package:plexus_task/routes/app_routes.dart';

class OtpVerificationView extends StatelessWidget {
  const OtpVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<AuthController>();
    final email = controller.emailController.text.isNotEmpty
        ? controller.emailController.text
        : 'your email';

    return Scaffold(
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
          const CustomAppBar(title: 'OTP Verification', homePage: false),
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 120.h, 16.w, 48.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                TextProperty(
                  text: 'Check Your Email',
                  textColor: ThemeColors.text(context),
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.h),
                TextProperty(
                  text:
                      'We sent a verification code to \n$email. Enter the code below.',
                  textColor: ThemeColors.subtitle(context),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 46.h),
                Center(
                  child: OtpTextField(
                    cursorColor: ThemeColors.text(context),
                    numberOfFields: 4,
                    enabledBorderColor: ThemeColors.border(context),
                    borderColor: ThemeColors.border(context),
                    focusedBorderColor: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(16.r),
                    fieldHeight: 56.h,
                    fieldWidth: 56.w,
                    showFieldAsBox: true,
                    filled: true,
                    fillColor: Colors.transparent,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    textStyle: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: ThemeColors.text(context),
                      height: 1.h,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                    onSubmit: (value) {
                      controller.otpController.text = value;
                    },
                  ),
                ),
                SizedBox(height: 16.h),
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Didn\'t receive the code?',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            color: ThemeColors.subtitle(context),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const TextSpan(text: ' '),
                        TextSpan(
                          text: 'Resend',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("OTP Resent successfully!"),
                                ),
                              );
                            },
                          style: TextStyle(
                            fontFamily: 'Inter',
                            color: AppColors.redColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Consumer<AuthController>(
                  builder: (context, authController, child) {
                    return CustomButton(
                      borderColor: Colors.transparent,
                      text: authController.isOtpLoading
                          ? 'Verifying...'
                          : 'Verify Code',
                      icon: Icons.arrow_forward,
                      iconSize: 20.w,
                      onTap: () async {
                        if (!authController.isLoading) {
                          final success = await authController.verifyOtp(
                            context,
                          );
                          if (success && context.mounted) {
                            context.go(AppRoute.login);
                          }
                        }
                      },
                    );
                  },
                ),
                SizedBox(height: 16.h),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
