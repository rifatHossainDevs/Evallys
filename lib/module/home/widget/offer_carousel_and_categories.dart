import 'package:evalys_main/components/skleton/others/categories_skelton.dart';
import 'package:evalys_main/module/home/widget/categories.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopify_flutter/shopify_flutter.dart';
import '../../../components/skleton/others/offers_skelton.dart';
import 'header_widget.dart';
import 'offers_carousel.dart';

class OffersCarouselAndCategories extends StatelessWidget {
  final RxList<Collection> collections;
  final RxList<Product> products;
  const OffersCarouselAndCategories({
    super.key,
    required this.collections,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // While loading use 👇
        Obx(() => products.isEmpty
            ? const OffersSkelton()
            : OffersCarousel(products: products.take(5).toList())),

        const HeaderWidget(
          title: "Categories",
        ),

        Obx(() {
          return collections.isEmpty
              ? const CategoriesSkelton()
              : Categories(
                  collections: collections,
                );
        }),
      ],
    );
  }
}
