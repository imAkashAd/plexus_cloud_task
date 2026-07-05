import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:plexus_task/core/common/widgets/custom_button.dart';
import 'package:plexus_task/core/common/widgets/text_property.dart';
import 'package:plexus_task/core/utils/constants/colors.dart';
import 'package:plexus_task/features/products/controller/products_controller.dart';
import 'package:plexus_task/features/products/widgets/filter_choice_chip.dart';

class FilterDialog extends StatelessWidget {
  const FilterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ProductsController>();

    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 40.h),
      decoration: BoxDecoration(
        color: ThemeColors.card(context),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        border: Border.all(color: ThemeColors.border(context), width: 1.w),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextProperty(
                text: "Filters & Sorting",
                textColor: ThemeColors.text(context),
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
              GestureDetector(
                onTap: () {
                  controller.setSelectedCategory(null);
                  controller.setSortBy('none');
                  Navigator.pop(context);
                },
                child: const TextProperty(
                  text: "Reset All",
                  textColor: AppColors.primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          TextProperty(
            text: "Sort By",
            textColor: ThemeColors.subtitle(context),
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              FilterChoiceChip(
                label: "Default",
                selected: controller.sortBy == 'none',
                onSelected: () => controller.setSortBy('none'),
              ),
              FilterChoiceChip(
                label: "Price: Low to High",
                selected: controller.sortBy == 'priceAsc',
                onSelected: () => controller.setSortBy('priceAsc'),
              ),
              FilterChoiceChip(
                label: "Price: High to Low",
                selected: controller.sortBy == 'priceDesc',
                onSelected: () => controller.setSortBy('priceDesc'),
              ),
              FilterChoiceChip(
                label: "Highest Rated",
                selected: controller.sortBy == 'rating',
                onSelected: () => controller.setSortBy('rating'),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          TextProperty(
            text: "Categories",
            textColor: ThemeColors.subtitle(context),
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              FilterChoiceChip(
                label: "All Products",
                selected: controller.selectedCategory == null,
                onSelected: () => controller.setSelectedCategory(null),
              ),
              ...controller.categories.map((cat) {
                return FilterChoiceChip(
                  label: cat,
                  selected: controller.selectedCategory == cat,
                  onSelected: () => controller.setSelectedCategory(cat),
                );
              }),
            ],
          ),
          SizedBox(height: 40.h),
          CustomButton(
            text: "Apply Filters",
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
