import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  static const Color defaultBackgroundColor = Color(0xFF020618);
  static const Color primaryColor = Color(0xFFCD1C18);
  static const Color defaultBorderColor = Color(0xFF333333);
  static const Color secondaryBackgroundColor = Color(0xFFEFEFEF);
  static const Color black = Color(0xFF000000);

  //text colors
  static const Color primaryTextColor = Color(0xFF121212);
  static const Color rateBackColor = Color(0xFF1B1C27);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color grey100Color = Color(0xFFF3F4F6);
  static const Color grey200Color = Color(0xFFE2E8F0);
  static const Color grey400Color = Color(0xFF94A3B8);
  static const Color grey500Color = Color(0xFF64748B);
  static const Color hintTextColor = Color(0xFFC0C0C0);
  static const Color greenColor = Color(0xFF34C759);
  static const Color orangeColor = Color(0xFFFF8D28);
  static const Color redColor = Color(0xFFFF383C);
  static const Color lightRedColor = Color(0xFFDE6764);
  static const Color greyColor = Color(0xFFC0C0C0);
  static const Color lightGreyColor = Color(0xFFE0E0E0);
  static const Color blueColor = Color(0xFF4F39F6);
  static const Color switchColor = Color(0xFF8883E1);
  static const Color grayButtonColor = Color(0xFFEBEBEB);
  static const Color yellowColor = Color(0xFFFBD367);
  static const Color darkGreyColor = Color(0xFF969490);
  static const Color lightBlueColor = Color(0xFF615FFF);
  static const Color firstChatColor = Color(0xFFD9E1F4);
  static const Color secondChatColor = Color(0xFFB0C1E9);
  static const Color containerColor = Color(0xFF1C1C26);
  static const Color borderColor = Color(0xFF334155);
  static const Color gradientBorderColor1 = Color(0xFFB48037);
  static const Color gradientyBorderColor2 = Color(0xFFFBD367);
}

class ThemeColors {
  static bool isDark(BuildContext context) => Theme.of(context).brightness == Brightness.dark;

  static Color background(BuildContext context) => isDark(context) ? const Color(0xFF020618) : const Color(0xFFF8FAFC);
  static Color card(BuildContext context) => isDark(context) ? const Color(0xFF1C1C26) : const Color(0xFFFFFFFF);
  static Color text(BuildContext context) => isDark(context) ? const Color(0xFFFFFFFF) : const Color(0xFF0F172A);
  static Color subtitle(BuildContext context) => isDark(context) ? const Color(0xFF94A3B8) : const Color(0xFF64748B);
  static Color border(BuildContext context) => isDark(context) ? const Color(0xFF334155) : const Color(0xFFE2E8F0);

  static Decoration authDecoration(BuildContext context) {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: isDark(context)
            ? const [Color(0xFF0F0202), Color(0xFF020618)]
            : const [Color(0xFFFFF2F2), Color(0xFFF8FAFC)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    );
  }
}
