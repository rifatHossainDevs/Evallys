import 'package:evalys_main/global/utils/constants.dart';
import 'package:evalys_main/module/home/widget/header_widget.dart';
import 'package:evalys_main/module/home/widget/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopify_flutter/shopify_flutter.dart';

import '../../../components/product/product_card.dart';

class PopularProducts extends StatelessWidget {
  final RxList<Product> products;
  const PopularProducts({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: defaultPadding / 2),
        const HeaderWidget(title: 'Popular Products'),
        SizedBox(
          height: 220,
          child: Obx(() {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                // Find products on models/ProductModel.dart
                itemCount: products.length,
                itemBuilder: (context, index) {
                  double compareAtPrice = double.tryParse(products[index]
                              .productVariants
                              .first
                              .compareAtPrice
                              ?.amount
                              .toString() ??
                          "0") ??
                      0;
                  double price = double.tryParse(products[index]
                          .productVariants
                          .first
                          .price
                          .amount
                          .toString()) ??
                      0;
                  int discountPercentage = compareAtPrice > 0
                      ? (((compareAtPrice - price) / compareAtPrice) * 100)
                          .toInt()
                      : 0;
                  return Padding(
                    padding: EdgeInsets.only(
                      left: defaultPadding,
                      right: index == products.length - 1 ? defaultPadding : 0,
                    ),
                    child: ProductCard(
                      product: products[index],
                      image: products[index].image,
                      brandName: products[index].vendor,
                      title: products[index].title,
                      price: compareAtPrice,
                      priceAfetDiscount: products[index].price,
                      dicountpercent:
                          discountPercentage > 0 ? discountPercentage : null,
                      press: () {
                        Navigator.pushNamed(
                            context, 'productDetailsScreenRoute',
                            arguments: index.isEven);
                      },
                    ),
                  );
                });
          }),
        )
      ],
    );
  }
}
