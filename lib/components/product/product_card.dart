import 'package:evalys_main/global/theme/colors.dart';
import 'package:evalys_main/global/utils/constants.dart';
import 'package:evalys_main/module/product/views/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shopify_flutter/shopify_flutter.dart';

import '../network_image_with_loader.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    this.image,
    this.brandName,
    this.title,
    this.price,
    this.priceAfetDiscount,
    this.dicountpercent,
    this.press,
    this.product,
  });
  final String? image, brandName, title;
  final double? price;
  final double? priceAfetDiscount;
  final int? dicountpercent;
  final Product? product;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Get.to(
          ProductDetailsScreen(product: product!),
          transition: Transition.cupertino,
          preventDuplicates: false,
        );
      },
      style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
            side: const BorderSide(
              color: AppColors.primary,
              width: 0,
            ),
          ),
          side: const BorderSide(
            color: AppColors.primary,
            width: 0,
          ),
          minimumSize: const Size(140, 220),
          maximumSize: const Size(140, 220),
          padding: const EdgeInsets.all(3)),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.15,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.r),
                    topRight: Radius.circular(8.r),
                  ),
                  child: NetworkImageWithLoader(image ?? "", radius: 2),
                ),
                if (dicountpercent != null)
                  Positioned(
                    right: defaultPadding / 2,
                    top: defaultPadding / 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding / 2),
                      height: 16,
                      decoration: const BoxDecoration(
                        color: errorColor,
                        borderRadius: BorderRadius.all(
                            Radius.circular(defaultBorderRadious)),
                      ),
                      child: Text(
                        "$dicountpercent% off",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding / 2, vertical: defaultPadding / 2),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        maxLines: 1,
                        (brandName ?? '').toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontSize: 8.sp),
                      ),
                      const SizedBox(height: defaultPadding / 2),
                      Text(
                        "$title",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontSize: 12),
                      ),
                      const Spacer(),
                      priceAfetDiscount != null && ((price ?? 0) >= 1)
                          ? Row(
                              children: [
                                Text(
                                  "\$$priceAfetDiscount",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.sp,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: defaultPadding / 4),
                                Text(
                                  "\$$price",
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .color
                                        ?.withOpacity(.7),
                                    fontSize: 10,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            )
                          : Text(
                              "\$$priceAfetDiscount",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                                color: Colors.white,
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
