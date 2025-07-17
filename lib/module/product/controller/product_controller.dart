import 'dart:developer';

import 'package:evalys_main/module/home/controller/home_controller.dart';
import 'package:get/get.dart';
import 'package:shopify_flutter/mixins/src/shopify_error.dart';
import 'package:shopify_flutter/models/src/cart/inputs/attribute_input/attribute_input.dart';
import 'package:shopify_flutter/shopify_flutter.dart';

import '../../../global/utils/helper.dart';

class ProductController extends GetxController {
  Rxn<ProductVariant> selectedVariant = Rxn<ProductVariant>();
  final ShopifyStore shopifyStore = ShopifyStore.instance;
  final ShopifyCart shopifyCart = ShopifyCart.instance;
  HomeController homeController = Get.put(HomeController());
  Cart? cart;
}
