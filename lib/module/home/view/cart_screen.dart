import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:evalys_main/global/theme/colors.dart';
import 'package:evalys_main/module/home/controller/home_controller.dart';
import 'package:evalys_main/module/home/view/checkout_page.dart';
import 'package:evalys_main/module/home/view/empty_cart.dart';
import 'package:evalys_main/module/product/views/product_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shopify_flutter/models/src/cart/attribute/attribute.dart';
import 'package:shopify_flutter/models/src/cart/lines/line/line.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController cartController = Get.find();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Cart',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Obx(
            () => (cartController.cart.value?.lines ?? []).isNotEmpty
                ? IconButton(
                    onPressed: () {
                      // cartController.removeAllCartItems();
                    },
                    icon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          CupertinoIcons.delete,
                          size: 18.sp,
                          color: AppColors.white,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'Clear All',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  )
                : Center(),
          ),
          SizedBox(width: 16.w),
        ],
      ),
      bottomNavigationBar: Obx(() {
        return (cartController.cart.value?.lines ?? []).isEmpty &&
                !cartController.isCartLoading.value
            ? const SizedBox()
            : AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h)
                    .copyWith(
                  bottom: 15.h + MediaQuery.of(context).viewInsets.bottom,
                ),
                decoration: const BoxDecoration(
                  color: AppColors.secondary,
                ),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PaymentSummary(),
                  ],
                ),
              );
      }),
      body: Obx(() {
        return (cartController.cart.value?.lines ?? []).isEmpty &&
                !cartController.isCartLoading.value
            ? const EmptyCart()
            : RefreshIndicator(
                color: AppColors.white,
                backgroundColor: AppColors.primary,
                onRefresh: () async {
                  cartController.checkCurrentUser();
                },
                child: ListView(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
                  children: [
                    Obx(() {
                      return Text(
                        'Total ${(cartController.cart.value?.lines ?? []).length} items',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    }),
                    10.verticalSpace,
                    Obx(() {
                      return Skeletonizer(
                        enabled: cartController.isCartLoading.value,
                        effect: ShimmerEffect(
                          baseColor: Colors.white.withValues(alpha: .05),
                          highlightColor: AppColors.white,
                          duration: const Duration(seconds: 1),
                        ),
                        child: ListView.separated(
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 10.h),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: cartController.isCartLoading.value
                              ? 10
                              : (cartController.cart.value?.lines ?? []).length,
                          itemBuilder: (context, index) {
                            Line? cartItem =
                                (cartController.cart.value?.lines ?? [])
                                    .elementAtOrNull(index);
                            return _cartItem(
                              cartItem: cartItem,
                              cartController: cartController,
                            );
                          },
                        ),
                      );
                    }),
                  ],
                ),
              );
      }),
    );
  }

  Widget _cartItem({Line? cartItem, required HomeController cartController}) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        InkWell(
          onTap: () {
            Get.to(
              ProductDetailsScreen(
                product: cartItem!.merchandise!.product!,
              ),
              transition: Transition.cupertino,
              preventDuplicates: false,
            );
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 10.h),
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Image.network(
                    cartItem?.merchandise?.product?.image ?? "",
                    width: 90.w,
                    height: 80.h,
                    fit: BoxFit.cover,
                  ),
                ),
                10.horizontalSpace,
                Expanded(
                  flex: 3,
                  child: Column(
                    spacing: 2.h,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cartItem?.merchandise?.product?.title ??
                            'No Product Name Found',
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        cartItem?.attributes?.firstOrNull?.value ?? '-',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.white,
                        ),
                      ),
                      2.verticalSpace,
                      Wrap(
                        spacing: 10.w,
                        runSpacing: 10.h,
                        children: List.generate(
                          (cartItem?.attributes ?? []).length,
                          (index) {
                            Attribute? spec =
                                (cartItem?.attributes ?? [])[index];
                            return IntrinsicWidth(
                              child: Container(
                                height: 34.h,
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                decoration: BoxDecoration(
                                  color: Get.theme.scaffoldBackgroundColor,
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(
                                      color: Get.theme.disabledColor),
                                ),
                                child: Center(
                                  child: Text(
                                    spec?.value.toString() ?? "-",
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                2.horizontalSpace,
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AnimatedFlipCounter(
                        duration: const Duration(milliseconds: 500),
                        thousandSeparator: ',',
                        suffix: '${cartItem?.merchandise?.price.currencyCode} ',
                        value: (cartItem?.cost?.totalAmount.amount ?? 0) *
                            (cartItem?.quantity ?? 1),
                        textStyle: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                      ),
                      5.verticalSpace,
                      Container(
                        height: 45.h,
                        margin: EdgeInsets.only(right: 5.w),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFF1F1F1)),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  // cartController.updateCartItemQty(
                                  //     variantId: cartItem?.variant?.id ?? "",
                                  //     qty: (cartItem?.qty ?? 1) - 1);
                                },
                                child: Icon(
                                  size: 25.sp,
                                  Icons.remove,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                            2.horizontalSpace,
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    left: BorderSide(
                                      color:
                                          Colors.black.withValues(alpha: 0.2),
                                      width: 1.w,
                                    ),
                                    right: BorderSide(
                                      color:
                                          Colors.black.withValues(alpha: 0.2),
                                      width: 1.w,
                                    ),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    '${cartItem?.quantity ?? 0}',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            2.horizontalSpace,
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  // cartController.updateCartItemQty(
                                  //     variantId: cartItem?.variant?.id ?? "",
                                  //     qty: (cartItem?.qty ?? 1) + 1);
                                },
                                child: Icon(
                                  size: 25.sp,
                                  Icons.add,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: -20.h,
          right: -10.w,
          child: InkWell(
            onTap: () {
              // cartController.removeCartItem(
              //     variantId: cartItem?.variant?.id ?? "");
            },
            child: Card(
              shape: const CircleBorder(),
              color: AppColors.red,
              child: Padding(
                padding: EdgeInsets.all(2.r),
                child: const Icon(Icons.close),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PaymentSummary extends StatelessWidget {
  const PaymentSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController cartController = Get.find();

    return Obx(() {
      double subtotal = (cartController.cart.value?.lines ?? []).fold(
          0,
          (sum, item) =>
              sum +
              (item.cost?.totalAmount.amount ?? 0) * (item.quantity ?? 1));
      double total = subtotal;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          10.verticalSpace,
          Center(
            child: MaterialButton(
              onPressed: () {
                Get.to(() => const CheckoutPage(), transition: Transition.fade);
              },
              splashColor: AppColors.white,
              color: AppColors.dark,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r)),
              child: Container(
                height: 55.h,
                width: Get.width * .8,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: AnimatedFlipCounter(
                        fractionDigits: 2,
                        duration: const Duration(milliseconds: 500),
                        thousandSeparator: ',',
                        suffix:
                            '${(cartController.cart.value?.lines ?? []).first.merchandise?.price.currencyCode} ',
                        value: total,
                        textStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 12.h),
                      width: 1.w,
                      color: AppColors.whiteLight,
                    ),
                    Center(
                      child: Text(
                        " Checkout Process",
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
