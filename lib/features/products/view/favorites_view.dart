import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:plexus_task/core/common/widgets/text_property.dart';
import 'package:plexus_task/core/utils/constants/colors.dart';
import 'package:plexus_task/features/products/controller/products_controller.dart';
import 'package:plexus_task/features/products/widgets/product_card.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ProductsController>();
    final favorites = controller.favoriteProducts;

    return Scaffold(
      backgroundColor: ThemeColors.background(context),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              TextProperty(
                text: "MY FAVORITES",
                textColor: AppColors.primaryColor,
                fontSize: 24.sp,
                fontWeight: FontWeight.w900,
              ),
              TextProperty(
                text: "Your curated selection of saved items",
                textColor: ThemeColors.subtitle(context),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 24.h),
              Expanded(
                child: favorites.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.favorite_border,
                              color: ThemeColors.subtitle(context).withValues(
                                alpha: 0.5,
                              ),
                              size: 64.w,
                            ),
                            SizedBox(height: 16.h),
                            TextProperty(
                              text: "No Favorites Yet",
                              textColor: ThemeColors.text(context),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            SizedBox(height: 8.h),
                            TextProperty(
                              text: "Items you save will appear here",
                              textColor: ThemeColors.subtitle(context),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    : GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              MediaQuery.of(context).size.width > 600 ? 3 : 2,
                          crossAxisSpacing: 12.w,
                          mainAxisSpacing: 12.h,
                          childAspectRatio: 0.64,
                        ),
                        itemCount: favorites.length,
                        itemBuilder: (context, index) {
                          return ProductCard(product: favorites[index]);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
