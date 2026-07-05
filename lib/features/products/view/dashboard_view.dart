import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:plexus_task/core/common/widgets/custom_search_bar.dart';
import 'package:plexus_task/core/common/widgets/text_property.dart';
import 'package:plexus_task/core/utils/constants/colors.dart';
import 'package:plexus_task/features/products/controller/products_controller.dart';
import 'package:plexus_task/features/products/widgets/filter_dialog.dart';
import 'package:plexus_task/features/products/widgets/products_grid_body.dart';
import 'package:plexus_task/features/products/widgets/category_tab_bar.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductsController>().fetchProducts();
    });

    final controller = context.watch<ProductsController>();

    return Scaffold(
      backgroundColor: ThemeColors.background(context),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextProperty(
                        text: "FAKE STORE CATALOG",
                        textColor: AppColors.primaryColor,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w900,
                      ),
                      TextProperty(
                        text: "Find what matches your style",
                        textColor: ThemeColors.subtitle(context),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => const FilterDialog(),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: ThemeColors.card(context),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: ThemeColors.border(context),
                          width: 1.w,
                        ),
                      ),
                      child: Icon(
                        Icons.tune,
                        color:
                            controller.selectedCategory != null ||
                                controller.sortBy != 'none'
                            ? AppColors.primaryColor
                            : ThemeColors.text(context),
                        size: 20.w,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              CustomSearchBar(
                hintText: "Search products...",
                fillColor: ThemeColors.card(context),
                borderColor: ThemeColors.border(context),
                iconColor: ThemeColors.subtitle(context),
                onChanged: (value) {
                  controller.setSearchQuery(value);
                },
              ),
              SizedBox(height: 12.h),
              const CategoryTabBar(),
              SizedBox(height: 12.h),
              if (controller.sortBy != 'none')
                Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: Row(
                    children: [
                      TextProperty(
                        text: "Active Filters: ",
                        textColor: ThemeColors.subtitle(context),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(width: 4.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.yellowColor.withValues(
                            alpha: 0.15,
                          ),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: AppColors.yellowColor.withValues(
                              alpha: 0.4,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            TextProperty(
                              text: controller.sortBy == 'priceAsc'
                                  ? "Price: Low-High"
                                  : controller.sortBy == 'priceDesc'
                                  ? "Price: High-Low"
                                  : "Rating",
                              textColor: AppColors.yellowColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                            ),
                            SizedBox(width: 4.w),
                            GestureDetector(
                              onTap: () => controller.setSortBy('none'),
                              child: const Icon(
                                Icons.close,
                                color: AppColors.yellowColor,
                                size: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              Expanded(
                child: RefreshIndicator(
                  color: AppColors.primaryColor,
                  backgroundColor: ThemeColors.card(context),
                  onRefresh: () => controller.fetchProducts(force: true),
                  child: const ProductsGridBody(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
