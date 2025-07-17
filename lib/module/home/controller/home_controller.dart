import 'dart:math';
import 'dart:developer' as log;
import 'package:evalys_main/global/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopify_flutter/mixins/src/shopify_error.dart';
import 'package:shopify_flutter/models/src/cart/inputs/attribute_input/attribute_input.dart'
    show AttributeInput;
import 'package:shopify_flutter/shopify_flutter.dart';

class HomeController extends GetxController {
  TextEditingController searchController = TextEditingController();
  RxInt bottomIndex = RxInt(0);
  RxList<Collection> collections = RxList([]);
  Rxn<Collection> selectHomeCollection = Rxn<Collection>();
  RxList<Product> selectCategoryProduct = RxList([]);
  RxList<Product> searchProductList = RxList([]);
  final signInKey = GlobalKey<FormBuilderState>();
  final signUpKey = GlobalKey<FormBuilderState>();
  // home
  RxList<Product> products = RxList([]);
  RxList<Product> popularProducts = RxList([]);
  RxList<Product> featuredProducts = RxList([]);
  RxList<Product> trendingProducts = RxList([]);
  RxList<Product> bestSellingProducts = RxList([]);
  final shopifyStore = ShopifyStore.instance;
  ShopifyAuth shopifyAuth = ShopifyAuth.instance;
  Rxn<ShopifyUser> currentUser = Rxn<ShopifyUser>();

  @override
  void onInit() {
    super.onInit();
    checkCurrentUser();
    Future.microtask(() async {
      await fetchPopularProduct();
      await fetchNewProduct();
      await fetchCollections();
    });
    searchProduct(['tshart', 'tv', 'pant', 'home', 'new'][Random().nextInt(4)]);
  }

  Future<void> fetchNewProduct() async {
    try {
      final product = await shopifyStore.getAllProducts();
      products.value = product;
      log.log('product: ${product.length}');
    } catch (e) {
      log.log("fetchNewProduct$e");
    }
  }

  Future<void> fetchPopularProduct() async {
    try {
      final product = await shopifyStore.getNProducts(10);
      popularProducts.value = product ?? [];
      log.log('popularProducts: ${product?.length}');
    } catch (e) {
      log.log(e.toString());
    }
  }

  Future<void> fetchCollections() async {
    collections.clear();
    try {
      collections.value = await shopifyStore.getAllCollections();
      selectHomeCollection.value = collections.first;
      Set<int> selectedIndices = {};
      Random random = Random();
      while (selectedIndices.length < 3) {
        selectedIndices.add(random.nextInt(collections.length));
      }
      List<int> uniqueIndices = selectedIndices.toList();
      await fetchBestSellingProducts(
          catID: collections.elementAtOrNull(uniqueIndices[0])?.id);
      await fetchTrendingProducts(
          catID: collections.elementAtOrNull(uniqueIndices[1])?.id);
      await fetchFeaturedProducts(
          catID: collections.elementAtOrNull(uniqueIndices[2])?.id);
      await fetchSelectCategoryProducts();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> fetchSelectCategoryProducts() async {
    log.log("${selectHomeCollection.toJson()}");
    selectCategoryProduct.clear();
    try {
      selectCategoryProduct.value =
          await shopifyStore.getAllProductsFromCollectionById(
        selectHomeCollection.value?.id ?? '',
      );
    } catch (e) {
      log.log(e.toString());
    }
  }

  Future<void> fetchBestSellingProducts({required catID}) async {
    try {
      final product = await shopifyStore.getAllProductsFromCollectionById(
        catID,
      );
      bestSellingProducts.value = product;
    } catch (e) {
      log.log(e.toString());
    }
  }

  Future<void> fetchFeaturedProducts({required catID}) async {
    try {
      final product = await shopifyStore.getAllProductsFromCollectionById(
        catID,
      );
      featuredProducts.value = product;
    } catch (e) {
      log.log(e.toString());
    }
  }

  Future<void> fetchTrendingProducts({required catID}) async {
    try {
      final product = await shopifyStore.getAllProductsFromCollectionById(
        catID,
      );
      trendingProducts.value = product;
    } catch (e) {
      log.log(e.toString());
    }
  }

  RxBool isSearchLoading = RxBool(false);
  Future<void> searchProduct(String query) async {
    isSearchLoading.value = true;
    searchProductList.value = [];
    try {
      final searchResult = await shopifyStore.searchProducts(query);
      searchProductList.value = searchResult ?? [];
      isSearchLoading.value = false;
    } catch (e) {
      isSearchLoading.value = false;
      debugPrint(e.toString());
    }
  }

  //login
  RxBool isLogInLoading = RxBool(false);
  Future<void> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    isLogInLoading.value = true;
    try {
      final user = await shopifyAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      currentUser.value = user;
      isLogInLoading.value = false;
      bottomIndex.value = 4;
      final pref = await SharedPreferences.getInstance();
      await pref.remove('cartId');
      checkCurrentUser();
      Get.back();
    } catch (e) {
      isLogInLoading.value = false;
      AlertToast.errorToast(message: e.toString());
      log.log(e.toString());
    }
  }

  ///-----------SignUp---------------//
  RxBool isSignUpLoading = RxBool(false);
  signUpWithEmailPassword({
    required String email,
    required String password,
    required String phone,
    required String firstName,
    required String lastName,
  }) async {
    isSignUpLoading.value = true;
    try {
      final user = await shopifyAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
        phone: phone,
        firstName: firstName,
        lastName: lastName,
      );
      log.log('user: ${user.toJson()}');
      currentUser.value = user;
      bottomIndex.value = 4;
      isSignUpLoading.value = false;
      checkCurrentUser();
      Get.back();
      Get.back();
    } catch (e) {
      isSignUpLoading.value = false;
      AlertToast.errorToast(message: e.toString());

      log.log(e.toString());
    }
  }

  //======= checkCurrentUser =========//
  void checkCurrentUser() {
    isCartLoading.value = true;
    shopifyAuth.currentUser().then((value) async {
      currentUser.value = value;
      if (value != null) {
        final pref = await SharedPreferences.getInstance();
        String? cartId = pref.getString('cartId');
        if (cartId != null) {
          cart.value = await shopifyCart.getCartById(cartId);
          logCartInfo(cart.value!);
          isCartLoading.value = false;
        } else {
          createCart();
        }
      }
    });
  }

  final ShopifyCart shopifyCart = ShopifyCart.instance;
  RxBool isCartLoading = RxBool(false);
  Rx<Cart?> cart = Rx<Cart?>(null);
  void createCart() async {
    String? accessToken = await ShopifyAuth.instance.currentCustomerAccessToken;
    final CartInput cartInput = CartInput(
      buyerIdentity: CartBuyerIdentityInput(
        email: currentUser.value?.email ?? '',
        customerAccessToken: accessToken,
      ),
    );
    try {
      cart.value = await shopifyCart.createCart(cartInput);
      final pref = await SharedPreferences.getInstance();
      pref.setString('cartId', cart.value?.id ?? '');
      logCartInfo(cart.value!);
      isCartLoading.value = false;
    } on ShopifyException catch (error) {
      isCartLoading.value = false;
      log.log('createCart ShopifyException: $error');
      AlertToast.successToast(
        message: error.errors?[0]["message"] ?? 'Error creating cart',
      );
    } catch (error) {
      isCartLoading.value = false;
      log.log('createCart Error: $error');
    }
  }

  void logCartInfo(Cart cart) {
    log.log('log => cart id: ${cart.id}');
    log.log('log => cart attributes: ${cart.attributes}');
    for (final line in cart.lines) {
      log.log('log => line attributes: ${line.attributes}');
    }
  }

  void addLineItemToCart(
      Product product, ProductVariant selectedVariant) async {
    HomeController homeController = Get.find();
    final cartLineInput = CartLineUpdateInput(
      quantity: 1,
      merchandiseId: product.productVariants.first.id,
      attributes: [
        ...(selectedVariant.selectedOptions ?? []).map(
          (e) => AttributeInput(
            key: e.name,
            value: e.value,
          ),
        )
      ],
    );
    // try {
    try {
      final updatedCart = await shopifyCart.addLineItemsToCart(
        cartId: homeController.cart.value?.id ?? "",
        cartLineInputs: [cartLineInput],
      );

      homeController.cart.value = updatedCart;
      AlertToast.successToast(message: 'Added ${product.title} to cart');
    } on ShopifyException catch (error) {
      log.log('addLineItemToCart ShopifyException: $error');
      AlertToast.successToast(
        message: error.errors?[0]["message"] ?? 'Error adding item to cart',
      );
    } catch (error) {
      log.log('addLineItemToCart Error: $error');
    }
  }

  void onCartItemUpdate() async {
    getCartById(cart.value?.id ?? "");
  }

  void getCartById(String cartId) async {
    try {
      final cartResponse = await shopifyCart.getCartById(cartId);

      cart.value = cartResponse;

      logCartInfo(cart.value!);
    } on ShopifyException catch (error) {
      AlertToast.successToast(
        message: error.errors?[0]["message"] ?? 'Error retrieving cart',
      );
    } catch (error) {
      log.log('getCartById Error: $error');
    }
  }

  // ///-- address --///
  // ShopifyCustomer shopifyCustomer = ShopifyCustomer.instance;
  // fetchUserAllAddress() async {
  //   try {
  //     final address = await shopifyCustomer.customerAddressCreate();
  //     log.log('address: ${address.length}');
  //     return address;
  //   } catch (e) {
  //     log.log(e.toString());
  //     return [];
  //   }
  // }
}
