import 'package:evalys_main/global/theme/colors.dart';
import 'package:evalys_main/global/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartButton extends StatelessWidget {
  const CartButton({
    super.key,
    required this.price,
    this.title = "Buy Now",
    this.subTitle = "Unit price",
    required this.press,
  });

  final String price;
  final String title, subTitle;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding, vertical: defaultBorderRadious / 2),
        child: SizedBox(
          height: 64,
          child: Material(
            color: AppColors.secondary,
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: AppColors.whiteLight.withOpacity(0.6),
              ),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: InkWell(
              onTap: press,
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "\$$price",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.sp,
                                ),
                          ),
                          Text(
                            subTitle,
                            style: TextStyle(
                              color: Colors.white54,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      alignment: Alignment.center,
                      height: double.infinity,
                      color: AppColors.whiteLight,
                      child: Text(
                        title.toUpperCase(),
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: AppColors.primary,
                              fontSize: 14.sp,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
