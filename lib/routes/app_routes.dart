import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plexus_task/core/services/storage_service.dart';
import 'package:plexus_task/features/auth_view/view/get_started_view.dart';
import 'package:plexus_task/features/auth_view/view/login_view.dart';
import 'package:plexus_task/features/auth_view/view/otp_verification_view.dart';
import 'package:plexus_task/features/auth_view/view/sign_up_view.dart';
import 'package:plexus_task/features/products/view/main_navigation_layout.dart';
import 'package:plexus_task/features/products/view/product_details_view.dart';
import 'package:plexus_task/features/products/models/product_model.dart';

class AppRoute {
  static const String getStarted = '/getStarted';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String otp = '/otp';
  static const String dashboard = '/dashboard';
  static const String productDetails = '/product-details';

  static final GoRouter router = GoRouter(
    initialLocation: getStarted,
    redirect: (context, state) {
      final isLoggedIn = StorageService.isLoggedIn();
      final goingToAuth =
          state.matchedLocation == login ||
          state.matchedLocation == signup ||
          state.matchedLocation == getStarted ||
          state.matchedLocation == otp;

      if (!isLoggedIn && !goingToAuth) {
        return getStarted;
      }
      if (isLoggedIn && goingToAuth) {
        return dashboard;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: getStarted,
        builder: (context, state) => const GetStartedView(),
      ),
      GoRoute(path: login, builder: (context, state) => const LoginView()),
      GoRoute(path: signup, builder: (context, state) => const SignUpView()),
      GoRoute(
        path: otp,
        builder: (context, state) => const OtpVerificationView(),
      ),
      GoRoute(
        path: dashboard,
        builder: (context, state) => const MainNavigationLayout(),
      ),
      GoRoute(
        path: '$productDetails/:id',
        builder: (context, state) {
          final idString = state.pathParameters['id'] ?? '';
          final id = int.tryParse(idString) ?? 0;
          final extra = state.extra;
          ProductModel? product;
          if (extra is ProductModel) {
            product = extra;
          } else if (extra is Map<String, dynamic>) {
            product = ProductModel.fromJson(extra);
          }
          return ProductDetailsView(productId: id, product: product);
        },
      ),
    ],
  );
}
