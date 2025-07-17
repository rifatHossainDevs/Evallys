import 'package:evalys_main/module/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../components/product/product_card.dart';
import '../../../global/theme/colors.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding:
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h).copyWith(
            top: 0,
          ),
          color: AppColors.secondary,
          child: Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.r),
                    bottomLeft: Radius.circular(10.r),
                  ),
                  child: TextFormField(
                    controller: homeController.searchController,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    onFieldSubmitted: (value) {
                      String search = homeController.searchController.text;
                      if (search.isNotEmpty) {
                        homeController.searchProduct(search);
                      }
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white.withValues(alpha: .1),
                      filled: true,
                      hintText: 'Search your product',
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  String search = homeController.searchController.text;
                  if (search.isNotEmpty) {
                    homeController.searchProduct(search);
                  }
                },
                child: Container(
                  width: 70.w,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.r),
                      bottomRight: Radius.circular(10.r),
                    ),
                  ),
                  child: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Obx(() {
            return Skeletonizer(
              enabled: (homeController.isSearchLoading.value),
              effect: ShimmerEffect(
                baseColor: Colors.white.withValues(alpha: .05),
                highlightColor: AppColors.white,
                duration: Duration(seconds: 1),
              ),
              child: GridView.builder(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  itemCount: homeController.isSearchLoading.value
                      ? 10
                      : homeController.searchProductList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: Get.width > 600 ? 6 : 3,
                    crossAxisSpacing: 10.w,
                    mainAxisSpacing: 10.h,
                    childAspectRatio: .59,
                  ),
                  itemBuilder: (context, index) {
                    final product =
                        homeController.searchProductList.elementAtOrNull(index);
                    double compareAtPrice = double.tryParse(product
                                ?.productVariants.first.compareAtPrice?.amount
                                .toString() ??
                            "0") ??
                        0;
                    double price = double.tryParse(product
                                ?.productVariants.first.price.amount
                                .toString() ??
                            '0') ??
                        0;
                    int discountPercentage = compareAtPrice > 0
                        ? (((compareAtPrice - price) / compareAtPrice) * 100)
                            .toInt()
                        : 0;
                    return ProductCard(
                      product: product,
                      image: product?.image,
                      brandName: product?.vendor,
                      title: product?.title,
                      price: compareAtPrice,
                      priceAfetDiscount: product?.price,
                      dicountpercent:
                          discountPercentage > 0 ? discountPercentage : null,
                      press: () {
                        Navigator.pushNamed(
                            context, 'productDetailsScreenRoute',
                            arguments: index.isEven);
                      },
                    );
                  }),
            );
          }),
        )
      ],
    );
  }
}
