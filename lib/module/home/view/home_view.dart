import 'package:evalys_main/components/product/product_card.dart';
import 'package:evalys_main/global/theme/colors.dart';
import 'package:evalys_main/global/utils/constants.dart';
import 'package:evalys_main/module/home/controller/home_controller.dart';
import 'package:evalys_main/module/home/view/cart_screen.dart';
import 'package:evalys_main/module/home/view/profile_content.dart';
import 'package:evalys_main/module/home/widget/best_sellers.dart';

import 'package:evalys_main/module/home/widget/most_popular.dart';
import 'package:evalys_main/module/home/widget/offer_carousel_and_categories.dart';
import 'package:evalys_main/module/home/widget/popular_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:get/get.dart';

import '../../../global/utils/image_path.dart';
import 'cart_tab.dart';
import 'category_content.dart';
import 'search_screen.dart';
import 'sign_in_screen.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: const SizedBox(),
        leadingWidth: 0,
        centerTitle: false,
        title: Image.asset(
          appLogo,
          height: 100,
          width: 100,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              "assets/logo/shopping-bag.png",
              color: AppColors.white,
              height: 30.h,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          return IndexedStack(
            index: homeController.bottomIndex.value,
            children: [
              _homeContent(),
              const CategoryContent(),
              const SearchScreen(),
              const CartTab(),
              const ProfileContent(),
            ],
          );
        }),
      ),
      bottomNavigationBar: Obx(() {
        return SnakeNavigationBar.color(
          selectedItemColor: Colors.white,
          unselectedItemColor: Theme.of(context).scaffoldBackgroundColor,
          backgroundColor: AppColors.secondary,
          snakeViewColor: Colors.white,
          currentIndex: homeController.bottomIndex.value,
          onTap: (index) {
            if (index == 4 && homeController.currentUser.value == null) {
              Get.to(() => const SignInScreen(), transition: Transition.fadeIn);
            } else if (index == 3 && homeController.currentUser.value != null) {
              Get.to(() => const CartView(), transition: Transition.fadeIn);
            } else {
              homeController.bottomIndex.value = index;
            }
          },
          snakeShape: SnakeShape.indicator,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/logo/home.png',
                height: 30.h,
                width: 30.w,
                fit: BoxFit.contain,
                color: Colors.white,
              ),
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/logo/love.png',
                height: 30.h,
                width: 30.w,
                fit: BoxFit.contain,
                color: Colors.white,
              ),
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/logo/magnifying-glass.png',
                height: 30.h,
                width: 30.w,
                fit: BoxFit.contain,
                color: Colors.white,
              ),
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/logo/shopping-bag.png',
                height: 30.h,
                width: 30.w,
                fit: BoxFit.contain,
                color: Colors.white,
              ),
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/logo/user.png',
                height: 30.h,
                width: 30.w,
                fit: BoxFit.contain,
                color: Colors.white,
              ),
            )
          ],
        );
      }),
    );
  }

  CustomScrollView _homeContent() {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: OffersCarouselAndCategories(
            collections: homeController.collections,
            products: homeController.products,
          ),
        ),
        SliverToBoxAdapter(
            child: PopularProducts(
          products: homeController.products,
        )),
        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: defaultPadding * 1.5)
              .copyWith(bottom: 0),
          sliver: SliverToBoxAdapter(child: Obx(() {
            return SizedBox(
              height: 230.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: homeController.popularProducts.length,
                itemBuilder: (context, index) {
                  double compareAtPrice = double.tryParse(homeController
                              .popularProducts[index]
                              .productVariants
                              .first
                              .compareAtPrice
                              ?.amount
                              .toString() ??
                          "0") ??
                      0;
                  double price = double.tryParse(homeController
                          .popularProducts[index]
                          .productVariants
                          .first
                          .price
                          .amount
                          .toString()) ??
                      0;
                  int discountPercentage = compareAtPrice > 0
                      ? (((compareAtPrice - price) / compareAtPrice) * 100)
                          .toInt()
                      : 0;
                  return Padding(
                    padding: EdgeInsets.only(
                      left: defaultPadding,
                      right: index == homeController.popularProducts.length - 1
                          ? defaultPadding
                          : 0,
                    ),
                    child: ProductCard(
                      product: homeController.popularProducts[index],
                      image: homeController.popularProducts[index].image,
                      brandName: homeController.popularProducts[index].vendor,
                      title: homeController.popularProducts[index].title,
                      price: compareAtPrice,
                      priceAfetDiscount:
                          homeController.popularProducts[index].price,
                      dicountpercent:
                          discountPercentage > 0 ? discountPercentage : null,
                      press: () {
                        Navigator.pushNamed(
                            context, "productDetailsScreenRoute",
                            arguments: index.isEven);
                      },
                    ),
                  );
                },
              ),
            );
          })),
        ),
        // SliverToBoxAdapter(
        //   child: Column(
        //     children: [
        //       BannerSStyle1(
        //         title: "New \narrival",
        //         subtitle: "SPECIAL OFFER",
        //         discountParcent: 50,
        //         press: () {
        //           Navigator.pushNamed(context, 'onSaleScreenRoute');
        //         },
        //       ),
        //       const SizedBox(height: defaultPadding / 4),
        //       // We have 4 banner styles, all in the pro version
        //     ],
        //   ),
        // ),
        SliverToBoxAdapter(
          child: Obx(() {
            return BestSellers(
              products: homeController.featuredProducts.value,
              title: 'Featured Collection',
            );
          }),
        ),
        SliverPadding(
          padding: EdgeInsets.only(bottom: 10.h),
          sliver: SliverToBoxAdapter(child: Obx(() {
            return MostPopular(
              products: homeController.trendingProducts.value,
              title: 'Trending Products',
            );
          })),
        ),
        SliverToBoxAdapter(child: Obx(() {
          return BestSellers(
            products: homeController.bestSellingProducts.value,
            title: 'Best Selling Products',
          );
        })),
        SliverToBoxAdapter(child: SizedBox(height: 30.h)),
      ],
    );
  }
}
