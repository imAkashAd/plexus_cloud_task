import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:plexus_task/core/common/widgets/custom_button.dart';
import 'package:plexus_task/core/common/widgets/text_property.dart';
import 'package:plexus_task/core/utils/constants/colors.dart';
import 'package:plexus_task/features/products/controller/products_controller.dart';
import 'package:plexus_task/features/products/widgets/product_card.dart';
import 'package:plexus_task/features/products/widgets/products_shimmer_grid.dart';

class ProductsGridBody extends StatelessWidget {
  const ProductsGridBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ProductsController>();
    final products = controller.filteredProducts;

    if (controller.isLoading && products.isEmpty) {
      return const ProductsShimmerGrid();
    }

    if (controller.errorMessage != null && products.isEmpty) {
      return Center(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.wifi_off_outlined,
                color: AppColors.redColor,
                size: 48.w,
              ),
              SizedBox(height: 16.h),
              TextProperty(
                text: controller.errorMessage!,
                textColor: ThemeColors.text(context),
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              CustomButton(
                text: "Retry Now",
                width: 140.w,
                onTap: () => controller.fetchProducts(force: true),
              ),
            ],
          ),
        ),
      );
    }

    if (products.isEmpty) {
      return Center(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search_off_outlined,
                color: ThemeColors.subtitle(context),
                size: 48,
              ),
              const SizedBox(height: 16),
              TextProperty(
                text: "No products found matches your criteria.",
                textColor: ThemeColors.subtitle(context),
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
      );
    }

    final crossAxisCount = MediaQuery.of(context).size.width > 600 ? 3 : 2;

    return GridView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 0.64,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(product: products[index]);
      },
    );
  }
}
