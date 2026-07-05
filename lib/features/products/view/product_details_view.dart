import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:plexus_task/core/common/widgets/custom_button.dart';
import 'package:plexus_task/core/common/widgets/text_property.dart';
import 'package:plexus_task/core/utils/constants/colors.dart';
import 'package:plexus_task/features/products/models/product_model.dart';
import 'package:plexus_task/features/products/controller/products_controller.dart';

class ProductDetailsView extends StatelessWidget {
  final int productId;
  final ProductModel? product;

  const ProductDetailsView({super.key, required this.productId, this.product});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ProductsController>();
    final currentProduct =
        product ??
        controller.products.firstWhere(
          (p) => p.id == productId,
          orElse: () => throw Exception("Product not found"),
        );

    final isFav = controller.isFavorite(currentProduct.id);

    return Scaffold(
      backgroundColor: ThemeColors.background(context),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            margin: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: ThemeColors.card(context),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: ThemeColors.text(context),
              size: 16,
            ),
          ),
        ),
        title: TextProperty(
          text: "Product Details",
          textColor: ThemeColors.text(context),
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () => controller.toggleFavorite(currentProduct.id),
            child: Container(
              margin: EdgeInsets.only(right: 16.w),
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: ThemeColors.card(context),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                color: isFav
                    ? AppColors.primaryColor
                    : ThemeColors.text(context),
                size: 20.w,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        bottom: true,
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(bottom: 120.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),
                  Center(
                    child: Container(
                      height: 320.h,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      padding: EdgeInsets.all(24.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 15.r,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Hero(
                        tag: 'product_image_${currentProduct.id}',
                        child: CachedNetworkImage(
                          imageUrl: currentProduct.image,
                          fit: BoxFit.contain,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            ),
                          ),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.broken_image_outlined,
                            color: AppColors.greyColor,
                            size: 48,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withValues(
                              alpha: 0.1,
                            ),
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: AppColors.primaryColor.withValues(
                                alpha: 0.3,
                              ),
                            ),
                          ),
                          child: TextProperty(
                            text: currentProduct.category.toUpperCase(),
                            textColor: AppColors.primaryColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        TextProperty(
                          text: currentProduct.title,
                          textColor: ThemeColors.text(context),
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w700,
                          lineHeight: 1.25,
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextProperty(
                              text:
                                  '\$${currentProduct.price.toStringAsFixed(2)}',
                              textColor: AppColors.yellowColor,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w800,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 6.h,
                              ),
                              decoration: BoxDecoration(
                                color: ThemeColors.card(context),
                                borderRadius: BorderRadius.circular(16.r),
                                border: Border.all(
                                  color: ThemeColors.border(context),
                                  width: 1.w,
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: AppColors.yellowColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: 4.w),
                                  TextProperty(
                                    text: '${currentProduct.rating.rate}',
                                    textColor: ThemeColors.text(context),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  SizedBox(width: 4.w),
                                  TextProperty(
                                    text:
                                        '(${currentProduct.rating.count} reviews)',
                                    textColor: ThemeColors.subtitle(context),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24.h),
                        Container(
                          height: 1,
                          color: ThemeColors.border(
                            context,
                          ).withValues(alpha: 0.5),
                          width: double.infinity,
                        ),
                        SizedBox(height: 24.h),
                        TextProperty(
                          text: "Description",
                          textColor: ThemeColors.text(context),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(height: 8.h),
                        TextProperty(
                          text: currentProduct.description,
                          textColor: ThemeColors.subtitle(context),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          lineHeight: 1.5,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h),
                decoration: BoxDecoration(
                  color: ThemeColors.background(context),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.5),
                      blurRadius: 10.r,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: CustomButton(
                  text: "Buy Now",
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: TextProperty(
                          text: "Added ${currentProduct.title} to cart!",
                          textColor: AppColors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        backgroundColor: AppColors.yellowColor,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
