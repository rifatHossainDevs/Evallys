import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../global/theme/colors.dart';

class HeaderWidget extends StatelessWidget {
  final String title;
  final EdgeInsets? padding;
  const HeaderWidget({super.key, required this.title, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.secondary,
      margin: padding ?? EdgeInsets.symmetric(vertical: 14.h),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 30.h,
              decoration: const BoxDecoration(
                color: AppColors.whiteLight,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              height: 32.h,
              decoration: const BoxDecoration(
                color: AppColors.secondary,
              ),
              child: Center(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 30.h,
              decoration: const BoxDecoration(
                color: AppColors.whiteLight,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
