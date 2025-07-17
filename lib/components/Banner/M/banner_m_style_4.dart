import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_svg/svg.dart';

import '../../../global/utils/constants.dart';
import 'banner_m.dart';

class BannerMStyle4 extends StatelessWidget {
  const BannerMStyle4({
    super.key,
    this.image = "https://i.imgur.com/R4iKkDD.png",
    required this.title,
    required this.press,
    required this.discountParcent,
    this.subtitle,
  });
  final String? image;
  final String title;
  final String? subtitle;
  final String discountParcent;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return BannerM(
      image: image!,
      press: press,
      children: [
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (subtitle != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding / 2,
                            vertical: defaultPadding / 8),
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.white,
                              width: 2.h,
                            ),
                            top: BorderSide(
                              color: Colors.white,
                              width: 2.h,
                            ),
                          ),
                        ),
                        child: Text(
                          subtitle!,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    const SizedBox(height: defaultPadding / 2),
                    Text(
                      maxLines: 2,
                      title.toUpperCase(),
                      style: const TextStyle(
                        fontFamily: grandisExtendedFont,
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        height: 1,
                      ),
                    ),
                    // const SizedBox(height: defaultPadding / 4),
                    Text(
                      discountParcent.isEmpty
                          ? 'Best Price Sale'
                          : "UP TO $discountParcent% OFF",
                      style: const TextStyle(
                        fontFamily: grandisExtendedFont,
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(width: defaultPadding),
              CircleAvatar(
                radius: 25.r,
                backgroundColor: Colors.white,
                child: const Icon(
                  Icons.arrow_outward_outlined,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
