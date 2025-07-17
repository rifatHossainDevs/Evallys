import 'package:evalys_main/components/product/product_card.dart';
import 'package:evalys_main/global/utils/constants.dart';
import 'package:evalys_main/module/home/widget/header_widget.dart';
import 'package:evalys_main/module/home/widget/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:shopify_flutter/models/src/product/product.dart';

class BestSellers extends StatelessWidget {
  final String title;
  final List<Product> products;
  const BestSellers({
    super.key,
    required this.products,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderWidget(title: title),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            // Find demoBestSellersProducts on models/ProductModel.dart
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
                  ? (((compareAtPrice - price) / compareAtPrice) * 100).toInt()
                  : 0;
              return Padding(
                padding: EdgeInsets.only(
                  left: defaultPadding,
                  right: index == demoBestSellersProducts.length - 1
                      ? defaultPadding
                      : 0,
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
                    Navigator.pushNamed(context, 'productDetailsScreenRoute',
                        arguments: index.isEven);
                  },
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
