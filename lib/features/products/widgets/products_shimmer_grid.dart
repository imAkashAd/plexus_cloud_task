import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plexus_task/core/utils/constants/colors.dart';

class ProductsShimmerGrid extends StatelessWidget {
  const ProductsShimmerGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final cardColor = ThemeColors.card(context);
    final borderColor = ThemeColors.border(context).withValues(alpha: 0.3);
    final shimmerColor = ThemeColors.isDark(context) 
        ? AppColors.grey500Color.withValues(alpha: 0.1)
        : AppColors.grey500Color.withValues(alpha: 0.05);

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 0.64,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: cardColor.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: borderColor,
              width: 1.w,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 130.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: shimmerColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16.r),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 10.h,
                      width: 60.w,
                      color: shimmerColor,
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      height: 12.h,
                      width: double.infinity,
                      color: shimmerColor,
                    ),
                    SizedBox(height: 4.h),
                    Container(
                      height: 12.h,
                      width: 100.w,
                      color: shimmerColor,
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 12.h,
                          width: 40.w,
                          color: shimmerColor,
                        ),
                        Container(
                          height: 12.h,
                          width: 30.w,
                          color: shimmerColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
