import 'dart:developer';
import 'package:evalys_main/global/theme/colors.dart';
import 'package:evalys_main/module/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../components/product/product_card.dart';

class CategoryContent extends StatelessWidget {
  const CategoryContent({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.secondary,
            ),
            child: Obx(() {
              return ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                separatorBuilder: (context, index) => 10.verticalSpace,
                itemCount: homeController.collections.value.length,
                itemBuilder: (context, index) {
                  return Obx(() {
                    return Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10.h, horizontal: 4.w),
                      decoration: BoxDecoration(
                        color: homeController.selectHomeCollection.value ==
                                homeController.collections[index]
                            ? Colors.white
                            : Colors.white.withValues(alpha: .1),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: InkWell(
                        onTap: () {
                          homeController.selectHomeCollection.value =
                              homeController.collections[index];
                          homeController.fetchSelectCategoryProducts();
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // NetworkImageWithLoader(
                            //     homeController.collections[index].imageUrl),
                            Text(
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              homeController.collections[index].title,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color:
                                    homeController.selectHomeCollection.value ==
                                            homeController.collections[index]
                                        ? Colors.black
                                        : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
                },
              );
            }),
          ),
        ),
        Expanded(
          flex: 6,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Obx(() {
              return GridView.builder(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  itemCount: homeController.selectCategoryProduct.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: Get.width > 600 ? 4 : 2,
                    crossAxisSpacing: 10.w,
                    mainAxisSpacing: 10.h,
                    childAspectRatio: .61,
                  ),
                  itemBuilder: (context, index) {
                    final product = homeController.selectCategoryProduct[index];
                    double compareAtPrice = double.tryParse(product
                                .productVariants.first.compareAtPrice?.amount
                                .toString() ??
                            "0") ??
                        0;
                    double price = double.tryParse(product
                            .productVariants.first.price.amount
                            .toString()) ??
                        0;
                    int discountPercentage = compareAtPrice > 0
                        ? (((compareAtPrice - price) / compareAtPrice) * 100)
                            .toInt()
                        : 0;
                    return ProductCard(
                      product: product,
                      image: product.image,
                      brandName: product.vendor,
                      title: product.title,
                      price: compareAtPrice,
                      priceAfetDiscount: product.price,
                      dicountpercent:
                          discountPercentage > 0 ? discountPercentage : null,
                      press: () {
                        Navigator.pushNamed(
                            context, 'productDetailsScreenRoute',
                            arguments: index.isEven);
                      },
                    );
                  });
            }),
          ),
        )
      ],
    );
  }
}
