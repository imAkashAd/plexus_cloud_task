import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:plexus_task/core/common/widgets/text_property.dart';
import 'package:plexus_task/core/utils/constants/colors.dart';
import 'package:plexus_task/features/products/models/product_model.dart';
import 'package:plexus_task/features/products/controller/products_controller.dart';
import 'package:plexus_task/routes/app_routes.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(
          '${AppRoute.productDetails}/${product.id}',
          extra: product,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: ThemeColors.card(context),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: ThemeColors.border(context).withValues(alpha: 0.5),
            width: 1.w,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with Favorite Toggle overlay
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16.r),
                  ),
                  child: Container(
                    color: Colors.white,
                    height: 180.h,
                    width: double.infinity,
                    padding: EdgeInsets.all(10.w),
                    child: CachedNetworkImage(
                      imageUrl: product.image,
                      fit: BoxFit.contain,
                      placeholder: (context, url) => const Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                            strokeWidth: 2,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.broken_image_outlined,
                        color: AppColors.grey400Color,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: Consumer<ProductsController>(
                    builder: (context, controller, child) {
                      final isFav = controller.isFavorite(product.id);
                      return GestureDetector(
                        onTap: () => controller.toggleFavorite(product.id),
                        child: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: isFav
                              ? AppColors.primaryColor
                              : AppColors.grey400Color,
                          size: 16.w,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            // Product Information
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextProperty(
                          text: product.category.toUpperCase(),
                          textColor: AppColors.primaryColor,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        SizedBox(height: 4.h),
                        TextProperty(
                          text: product.title,
                          textColor: ThemeColors.text(context),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextProperty(
                          text: '\$${product.price.toStringAsFixed(2)}',
                          textColor: AppColors.redColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: AppColors.orangeColor,
                              size: 14,
                            ),
                            SizedBox(width: 2.w),
                            TextProperty(
                              text: product.rating.rate.toString(),
                              textColor: ThemeColors.subtitle(context),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
