import 'dart:developer';

import 'package:evalys_main/components/network_image_with_loader.dart';
import 'package:evalys_main/module/home/controller/home_controller.dart';
import 'package:evalys_main/module/product/views/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shopify_flutter/models/src/cart/lines/line/line.dart';

class CartTab extends StatelessWidget {
  const CartTab({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    return Obx(() {
      return ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        separatorBuilder: (context, index) => SizedBox(height: 14.h),
        itemCount: homeController.cart.value?.lines.length ?? 0,
        itemBuilder: (context, index) {
          final lineItem = homeController.cart.value?.lines[index];
          return ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            tileColor: Colors.white.withValues(alpha: .1),
            leading: Image.network(
              height: 60.h,
              width: 60.w,
              lineItem?.merchandise?.product?.image ?? "",
            ),
            onTap: () {
              Get.to(
                ProductDetailsScreen(
                  product: lineItem!.merchandise!.product!,
                ),
                transition: Transition.cupertino,
                preventDuplicates: false,
              );
              log('Tapped on line item: ${lineItem?.toJson()}');
            },
            title: Text(
              maxLines: 2,
              lineItem?.merchandise?.product?.title ?? '',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Text('Quantity: ${lineItem?.quantity}'),
            subtitle: Text(
              '\$${lineItem?.cost?.totalAmount.amount.toStringAsFixed(2)} ${lineItem?.cost?.totalAmount.currencyCode}',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        },
      );
    });
  }
}

// void removeLineItemFromCart(String lineId) async {
//   try {
//     if (!lineId.startsWith('gid://shopify/CartLine/')) {
//       AlertToast.errorToast(message: 'Invalid lineId');
//       log('Invalid lineId: $lineId');
//       return;
//     }
//     final updatedCart = await shopifyCart.removeLineItemsFromCart(
//       cartId: cart.id,
//       lineIds: [lineId],
//     );
//     setState(() {
//       cart = updatedCart;
//     });
//     widget.onCartItemUpdate?.call();
//     if (!mounted) return;
//     AlertToast.successToast(message: 'Removed item from cart');
//   } on ShopifyException catch (error) {
//     log('removeLineItemFromCart ShopifyException: $error');
//     AlertToast.successToast(
//       message: error.errors?[0]["message"] ?? 'Error removing item from cart',
//     );
//   } catch (error) {
//     log('removeLineItemFromCart Error: $error');
//   }
// }

// void onCartItemUpdate(Line line, {bool increament = true}) async {
//   try {
//     int quantity = line.quantity ?? 0;
//     if (!increament && quantity == 0) {
//       AlertToast.successToast(message: 'Cannot reduce quantity below 0');
//       return;
//     }
//     quantity = increament ? quantity + 1 : quantity - 1;

//     final cartLineInput = CartLineUpdateInput(
//       id: "${line.id}",
//       quantity: quantity,
//       merchandiseId: "${line.variantId}",
//       attributes: [
//         AttributeInput(
//           key: 'color',
//           value: 'blue',
//         ),
//         AttributeInput(key: 'Misc', value: '1')
//       ],
//     );
//     final updatedCart = await shopifyCart.updateLineItemsInCart(
//       cartId: cart.id,
//       cartLineInputs: [cartLineInput],
//     );
//     setState(() {
//       cart = updatedCart;
//     });
//     widget.onCartItemUpdate?.call();
//     if (!mounted) return;
//     AlertToast.successToast(message: 'Updated item in cart');
//   } on ShopifyException catch (error) {
//     log('onCartItemUpdate ShopifyException: ${error.errors?[0]["message"]}');
//     AlertToast.successToast(
//       message: error.errors?[0]["message"] ?? 'Error updating cart',
//     );
//   } catch (error) {
//     log('onCartItemUpdate Error: $error');
//   }
// }

// // void updateCartNote() async {
//   try {
//     final updatedCart = await shopifyCart.updateNoteInCart(
//       cartId: cart.id,
//       note: noteCtrl.text.trim(),
//     );
//     setState(() {
//       cart = updatedCart;
//     });
//     widget.onCartItemUpdate?.call();
//     if (!mounted) return;
//     AlertToast.successToast(message: 'Updated cart note');
//   } catch (error) {
//     log('updateCartNote Error: $error');
//   }
// }
