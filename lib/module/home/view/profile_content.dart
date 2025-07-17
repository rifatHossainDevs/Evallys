import 'package:evalys_main/components/network_image_with_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shopify_flutter/models/models.dart';
import 'package:shopify_flutter/shopify_flutter.dart';

import '../controller/home_controller.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50.r,
            backgroundColor: Colors.white,
            child: Icon(
              CupertinoIcons.profile_circled,
              size: 50.sp,
              color: Colors.black,
            ),
          ),
          Obx(() {
            return Text(
              homeController.currentUser.value?.displayName ?? 'Gest User',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            );
          }),
          Obx(() {
            return Text(homeController.currentUser.value?.email ?? '--',
                style: TextStyle(fontSize: 16.sp));
          }),
          Obx(() {
            return Text(
              homeController.currentUser.value?.phone ?? '--',
              style: TextStyle(fontSize: 16.sp),
            );
          }),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.shopping_bag_rounded,
                    size: 26.sp,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Order history',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.shopping_bag_sharp,
                    size: 26.sp,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Cart',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.settings,
                    size: 26.sp,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Shipping Address',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    ShopifyAuth shopifyAuth = ShopifyAuth.instance;
                    shopifyAuth.signOutCurrentUser();
                    homeController.currentUser.value = null;
                    homeController.bottomIndex.value = 0;
                  },
                  leading: Icon(
                    Icons.logout,
                    size: 26.sp,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
