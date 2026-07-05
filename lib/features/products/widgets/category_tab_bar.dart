import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:plexus_task/core/common/widgets/text_property.dart';
import 'package:plexus_task/core/utils/constants/colors.dart';
import 'package:plexus_task/features/products/controller/products_controller.dart';

class CategoryTabBar extends StatelessWidget {
  const CategoryTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ProductsController>();
    final categories = ['all', ...controller.categories];
    final selectedCat = controller.selectedCategory ?? 'all';

    return SizedBox(
      height: 48.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          final isSelected = cat == selectedCat;

          return GestureDetector(
            onTap: () {
              if (cat == 'all') {
                controller.setSelectedCategory(null);
              } else {
                controller.setSelectedCategory(cat);
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.redColor.withValues(alpha: 0.1)
                          : AppColors.grey500Color.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    child: TextProperty(
                      text: cat == 'all' ? 'ALL' : cat.toUpperCase(),
                      textColor: isSelected
                          ? AppColors.primaryColor
                          : ThemeColors.subtitle(context),
                      fontSize: 12.sp,
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w500,
                    ),
                  ),
                  // SizedBox(height: 6.h),
                  // AnimatedContainer(
                  //   duration: const Duration(milliseconds: 200),
                  //   height: 3.h,
                  //   width: isSelected ? 24.w : 0,
                  //   decoration: BoxDecoration(
                  //     color: AppColors.primaryColor,
                  //     borderRadius: BorderRadius.circular(1.5.r),
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
