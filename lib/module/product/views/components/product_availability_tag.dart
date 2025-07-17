import 'package:evalys_main/global/theme/colors.dart';
import 'package:evalys_main/global/utils/constants.dart';
import 'package:flutter/material.dart';

class ProductAvailabilityTag extends StatelessWidget {
  const ProductAvailabilityTag({
    super.key,
    required this.isAvailable,
  });

  final bool isAvailable;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding / 2),
      decoration: BoxDecoration(
        color: isAvailable ? AppColors.secondary : errorColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(defaultBorderRadious / 2),
        ),
      ),
      child: Text(
        isAvailable ? "Available in stock" : "Currently unavailable",
        style: Theme.of(context)
            .textTheme
            .labelSmall!
            .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
      ),
    );
  }
}
