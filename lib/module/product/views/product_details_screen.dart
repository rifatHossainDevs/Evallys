import 'dart:developer' as log;
import 'package:evalys_main/components/cart_button.dart';
import 'package:evalys_main/components/custom_modal_bottom_sheet.dart';
import 'package:evalys_main/global/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shopify_flutter/shopify_flutter.dart';
import '../../../components/product/product_card.dart';
import '../controller/product_controller.dart';
import 'components/notify_me_card.dart';
import 'components/product_images.dart';
import 'components/product_info.dart';
import 'product_buy_now_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;
  const ProductDetailsScreen({super.key, this.isProductAvailable = true, required this.product});

  final bool isProductAvailable;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  List<Product> relatedProduct = [];
  late ProductController productController;
  @override
  void initState() {
    productController = Get.put(ProductController(), tag: widget.product.id);
    Future.delayed(Duration.zero, () async {
      final shopifyStore = ShopifyStore.instance;
      final productRelated = await shopifyStore.getProductRecommendations(widget.product.id);
      relatedProduct = productRelated ?? [];
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        surfaceTintColor: Colors.transparent,
      ),
      bottomNavigationBar: widget.isProductAvailable
          ? CartButton(
              price: widget.product.price.toStringAsFixed(2),
              press: () {
                customModalBottomSheet(
                  context,
                  height: MediaQuery.of(context).size.height * 0.92,
                  child: ProductBuyNowScreen(product: widget.product, productController: productController),
                );
              },
            )
          :

          /// If profuct is not available then show [NotifyMeCard]
          NotifyMeCard(
              isNotify: false,
              onChanged: (value) {},
            ),
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: true,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              floating: true,
              title: Text(
                widget.product.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset("assets/icons/Bookmark.svg",
                      color: Theme.of(context).textTheme.bodyLarge!.color),
                ),
              ],
            ),
            SliverPadding(
              padding: EdgeInsets.only(top: 10.h),
              sliver: ProductImages(
                images: widget.product.images.map((e) => e.originalSrc).toList(),
              ),
            ),
            ProductInfo(
              brand: widget.product.vendor,
              title: widget.product.title,
              isAvailable: widget.isProductAvailable,
              description: "${widget.product.descriptionHtml}",
              price: widget.product.price,
              currencyCode: widget.product.productVariants.first.price.currencyCode,
            ),
            SliverPadding(
              padding: const EdgeInsets.all(defaultPadding),
              sliver: SliverToBoxAdapter(
                child: Text(
                  "You may also like",
                  style: Theme.of(context).textTheme.titleSmall!,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: relatedProduct.length,
                  itemBuilder: (context, index) {
                    double compareAtPrice = double.tryParse(
                            relatedProduct[index].productVariants.first.compareAtPrice?.amount.toString() ?? "0") ??
                        0;
                    double price =
                        double.tryParse(relatedProduct[index].productVariants.first.price.amount.toString()) ?? 0;
                    int discountPercentage =
                        compareAtPrice > 0 ? (((compareAtPrice - price) / compareAtPrice) * 100).toInt() : 0;

                    return Padding(
                      padding: EdgeInsets.only(left: defaultPadding, right: index == 4 ? defaultPadding : 0),
                      child: ProductCard(
                        product: relatedProduct[index],
                        image: relatedProduct[index].image,
                        brandName: relatedProduct[index].vendor,
                        title: relatedProduct[index].title,
                        price: compareAtPrice,
                        priceAfetDiscount: relatedProduct[index].price,
                        dicountpercent: discountPercentage > 0 ? discountPercentage : null,
                        press: () {},
                      ),
                    );
                  },
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: defaultPadding),
            )
          ],
        ),
      ),
    );
  }
}
