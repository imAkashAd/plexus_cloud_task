import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:plexus_task/core/services/auth_service.dart';
import 'package:plexus_task/core/utils/constants/colors.dart';
import 'package:plexus_task/features/products/controller/navigation_controller.dart';
import 'package:plexus_task/features/products/view/dashboard_view.dart';
import 'package:plexus_task/features/products/view/favorites_view.dart';
import 'package:plexus_task/routes/app_routes.dart';

class MainNavigationLayout extends StatelessWidget {
  const MainNavigationLayout({super.key});

  static const List<Widget> _views = [DashboardView(), FavoritesView()];

  @override
  Widget build(BuildContext context) {
    final navController = context.watch<NavigationController>();

    return Scaffold(
      backgroundColor: ThemeColors.background(context),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: _views[navController.currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: ThemeColors.border(context).withValues(alpha: .3),
              width: 1.w,
            ),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: ThemeColors.card(context),
          currentIndex: navController.currentIndex,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: ThemeColors.subtitle(context),
          selectedLabelStyle: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            fontSize: 12.sp,
          ),
          unselectedLabelStyle: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            fontSize: 11.sp,
          ),
          onTap: (index) {
            if (index == 2) {
              _showLogoutDialog(context);
            } else {
              navController.setIndex(index);
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_rounded),
              label: 'Catalog',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_rounded),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.logout_rounded),
              label: 'Logout',
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: ThemeColors.card(context),
          title: Text(
            "Logout",
            style: TextStyle(
              color: ThemeColors.text(context),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            "Are you sure you want to log out of your session?",
            style: TextStyle(color: ThemeColors.subtitle(context)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Cancel",
                style: TextStyle(color: ThemeColors.subtitle(context)),
              ),
            ),
            TextButton(
              onPressed: () {
                context.read<AuthService>().logout();
                Navigator.pop(context);
                context.go(AppRoute.login);
              },
              child: const Text(
                "Logout",
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
