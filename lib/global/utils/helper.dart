import 'package:evalys_main/global/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class AlertToast {
  static void errorToast({required String message, String? title}) {
    toastification.show(
      backgroundColor: AppColors.red,
      primaryColor: Colors.white,
      context: Get.context!,
      type: ToastificationType.error,
      style: ToastificationStyle.flat,
      progressBarTheme: const ProgressIndicatorThemeData(
        color: Colors.white,
      ),
      title: Text(
        title ?? "Alert Information",
        style: TextStyle(
          color: Colors.white54,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      description: Text(
        message,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontSize: 15.sp,
        ),
      ),
      alignment: Alignment.topCenter,
      autoCloseDuration: const Duration(seconds: 4),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: highModeShadow,
      showProgressBar: true,
      dragToClose: true,
    );
  }

  static void successToast({required String message, String? title}) {
    toastification.show(
      backgroundColor: AppColors.primary,
      primaryColor: Colors.white,
      context: Get.context!,
      type: ToastificationType.success,
      style: ToastificationStyle.flat,
      progressBarTheme: const ProgressIndicatorThemeData(
        color: Colors.white,
      ),
      title: Text(
        title ?? "Alert Information",
        style: TextStyle(
          color: Colors.white,
          fontSize: 10.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
      description: Text(
        message,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontSize: 15.sp,
        ),
      ),
      alignment: Alignment.topCenter,
      autoCloseDuration: const Duration(seconds: 4),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: highModeShadow,
      showProgressBar: true,
      dragToClose: true,
    );
  }
}
