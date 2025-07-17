import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:evalys_main/components/cart_button.dart';
import 'package:evalys_main/components/network_image_with_loader.dart';
import 'package:evalys_main/components/product/product_card.dart';
import 'package:evalys_main/global/theme/colors.dart';
import 'package:evalys_main/global/utils/constants.dart';
import 'package:evalys_main/module/home/controller/home_controller.dart';
import 'package:evalys_main/module/product/views/added_to_cart_message_screen.dart';
import 'package:evalys_main/module/product/views/components/product_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shopify_flutter/shopify_flutter.dart';
import '../../../components/custom_modal_bottom_sheet.dart';
import '../controller/product_controller.dart';
import 'components/product_quantity.dart';
import 'components/selected_colors.dart';
import 'components/selected_size.dart';
import 'components/unit_price.dart';

class ProductBuyNowScreen extends StatefulWidget {
  final Product product;
  final ProductController productController;
  const ProductBuyNowScreen({super.key, required this.product, required this.productController});

  @override
  _ProductBuyNowScreenState createState() => _ProductBuyNowScreenState();
}

class _ProductBuyNowScreenState extends State<ProductBuyNowScreen> {
  ProductVariant? selectedVariant;
  HomeController homeController = Get.put(HomeController());
  @override
  void initState() {
    selectedVariant = widget.product.productVariants.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CartButton(
        price: (selectedVariant?.price.amount ?? 0).toStringAsFixed(2),
        title: "Add to cart",
        subTitle: "Total price",
        press: () {
          homeController.addLineItemToCart(widget.product, widget.productController.selectedVariant.value!);
        },
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2, vertical: defaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const BackButton(),
                Expanded(
                  child: Text(
                    maxLines: 1,
                    widget.product.title,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset("assets/icons/Bookmark.svg",
                      color: Theme.of(context).textTheme.bodyLarge!.color),
                ),
              ],
            ),
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: AspectRatio(
                      aspectRatio: 1.7,
                      child: NetworkImageWithLoader(widget.product.image),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(defaultPadding),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: UnitPrice(
                            price: (selectedVariant?.price.amount ?? 0),
                          ),
                        ),
                        ProductQuantity(
                          numOfItem: 2,
                          onIncrement: () {},
                          onDecrement: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                ProductVariantSelector(
                  product: widget.product,
                ),
                const SliverToBoxAdapter(child: Divider()),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ProductVariantSelector extends StatefulWidget {
  final Product product;

  const ProductVariantSelector({super.key, required this.product});

  @override
  _ProductVariantSelectorState createState() => _ProductVariantSelectorState();
}

class _ProductVariantSelectorState extends State<ProductVariantSelector> {
  Map<String, String> selectedOptions = {}; // Store selected options (e.g., {"Size": "M", "Color": "Red"})
  ProductVariant? selectedVariant;

  @override
  Widget build(BuildContext context) {
    final productController = Get.put(ProductController(), tag: widget.product.id);
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Loop through product options (e.g., Size, Color)
            ...widget.product.options.map((option) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Select ${option.name}",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: option.values.map((value) {
                        bool isSelected = selectedOptions[option.name] == value;

                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedOptions[option.name] = value;

                              selectedVariant =
                                  findVariantBySelectedOptions(widget.product.productVariants, selectedOptions);
                              productController.selectedVariant.value = selectedVariant;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.green : AppColors.secondary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Text(value),
                          ),
                        );
                      }).toList(),
                    )
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  /// Find a variant that matches all selected options
  ProductVariant? findVariantBySelectedOptions(List<ProductVariant> variants, Map<String, String> selectedOptions) {
    log('Finding variant for: $selectedOptions');
    return variants.firstWhereOrNull((variant) {
      // Ensure every selected option is present in the variant
      return selectedOptions.entries.every((entry) {
        return variant.selectedOptions?.any((opt) => opt.name == entry.key && opt.value == entry.value) ?? false;
      });
    });
  }
}
