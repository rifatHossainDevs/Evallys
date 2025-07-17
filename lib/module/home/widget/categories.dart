import 'dart:developer';

import 'package:evalys_main/global/theme/colors.dart';
import 'package:evalys_main/global/utils/constants.dart';
import 'package:evalys_main/module/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shopify_flutter/shopify_flutter.dart';

class Categories extends StatelessWidget {
  final List<Collection> collections;
  const Categories({
    super.key,
    required this.collections,
  });

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...List.generate(
            collections.length,
            (index) => Padding(
              padding: EdgeInsets.only(
                  left: index == 0 ? defaultPadding : defaultPadding / 2,
                  right: index == collections.length - 1 ? defaultPadding : 0),
              child: CategoryBtn(
                category: collections[index].title,
                // svgSrc: "assets/icons/Woman.svg",
                isActive: index == -1,
                press: () {
                  homeController.selectHomeCollection.value =
                      collections[index];
                  homeController.fetchSelectCategoryProducts();
                  homeController.bottomIndex.value = 1;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryBtn extends StatelessWidget {
  const CategoryBtn({
    super.key,
    required this.category,
    this.svgSrc,
    required this.isActive,
    required this.press,
  });

  final String category;
  final String? svgSrc;
  final bool isActive;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      child: Container(
        height: 40.h,
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        decoration: BoxDecoration(
          color: AppColors.secondary,
          border: Border.all(color: Theme.of(context).secondaryHeaderColor),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            if (svgSrc != null)
              SvgPicture.asset(
                svgSrc!,
                height: 20,
                colorFilter: ColorFilter.mode(
                  isActive ? Colors.white : Theme.of(context).iconTheme.color!,
                  BlendMode.srcIn,
                ),
              ),
            if (svgSrc != null) const SizedBox(width: defaultPadding / 2),
            Text(
              category,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isActive
                    ? Colors.white
                    : Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
