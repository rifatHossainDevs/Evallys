import 'dart:async';

import 'package:evalys_main/components/Banner/M/banner_m_style_1.dart';
import 'package:evalys_main/components/Banner/M/banner_m_style_2.dart';
import 'package:evalys_main/components/Banner/M/banner_m_style_4.dart';
import 'package:evalys_main/components/dot_indicators.dart';
import 'package:evalys_main/global/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shopify_flutter/shopify_flutter.dart';

import '../../../components/Banner/M/banner_m_style_3.dart';

class OffersCarousel extends StatefulWidget {
  final List<Product> products;
  const OffersCarousel({
    super.key,
    required this.products,
  });

  @override
  State<OffersCarousel> createState() => _OffersCarouselState();
}

class _OffersCarouselState extends State<OffersCarousel> {
  int _selectedIndex = 0;
  late PageController _pageController;
  late Timer _timer;
  List offers = [];

  @override
  void initState() {
    offers = List.generate(
      widget.products.length,
      (index) {
        double compareAtPrice = double.parse(widget
                .products[index].productVariants.first.compareAtPrice?.amount
                .toString() ??
            "0");
        double price = double.parse(widget
            .products[index].productVariants.first.price.amount
            .toString());
        double discountPercentage =
            ((compareAtPrice - price) / compareAtPrice) * 100;

        return BannerMStyle4(
          image: widget.products[index].image,
          title: widget.products[index].title,
          subtitle: "SPECIAL OFFER",
          discountParcent:
              compareAtPrice == 0 ? '' : discountPercentage.toStringAsFixed(0),
          press: () {},
        );
      },
    );
    _pageController = PageController(initialPage: 0);
    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_selectedIndex < offers.length - 1) {
        _selectedIndex++;
      } else {
        _selectedIndex = 0;
      }

      _pageController.animateToPage(
        _selectedIndex,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.87,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: offers.length,
            onPageChanged: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            itemBuilder: (context, index) => offers[index],
          ),
          FittedBox(
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: SizedBox(
                height: 16,
                child: Row(
                  children: List.generate(
                    offers.length,
                    (index) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(left: defaultPadding / 4),
                        child: DotIndicator(
                          isActive: index == _selectedIndex,
                          activeColor: Colors.white70,
                          inActiveColor: Colors.white54,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
