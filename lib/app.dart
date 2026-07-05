import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:plexus_task/core/services/auth_service.dart';
import 'package:plexus_task/core/utils/theme/theme.dart';
import 'package:plexus_task/features/auth_view/controller/auth_controller.dart';
import 'package:plexus_task/features/products/controller/navigation_controller.dart';
import 'package:plexus_task/features/products/controller/products_controller.dart';
import 'package:plexus_task/features/products/repository/products_repository.dart';
import 'package:plexus_task/routes/app_routes.dart';

class PlexusTask extends StatelessWidget {
  const PlexusTask({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
        ChangeNotifierProvider<AuthController>(
          create: (context) => AuthController(context.read<AuthService>()),
        ),
        Provider<ProductsRepository>(create: (_) => ProductsRepository()),
        ChangeNotifierProvider<ProductsController>(
          create: (context) => ProductsController(context.read<ProductsRepository>()),
        ),
        ChangeNotifierProvider<NavigationController>(
          create: (_) => NavigationController(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp.router(
            title: "FAKE STORE",
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.system, // Follow the phone system setting (Dark / Light)
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            routerConfig: AppRoute.router,
          );
        },
      ),
    );
  }
}
