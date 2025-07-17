import 'package:evalys_main/global/theme/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

class AppMainTheme {
  static ThemeData main({bool isDark = false}) {
    return ThemeData(
      secondaryHeaderColor:
          isDark ? Colors.white.withOpacity(0.15) : Colors.white,
      primaryColor: AppColors.primary,
      primarySwatch: AppColors.primaryMaterialColor,
      brightness: isDark ? Brightness.dark : Brightness.light,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
          TargetPlatform.macOS: FadeUpwardsPageTransitionsBuilder(),
        },
      ),
      fontFamily: AppTextStyles.fontFamily,
      canvasColor:
          isDark ? Color(0xFFDCD7C9) : const Color.fromARGB(255, 93, 107, 112),
      scaffoldBackgroundColor: isDark ? AppColors.primary : Color(0xFFDCD7C9),
      shadowColor: isDark ? const Color(0xFF1D1D2F) : Colors.grey.shade200,
      cardColor: isDark
          ? const Color.fromARGB(255, 68, 66, 83)
          : const Color.fromARGB(255, 241, 240, 244),
      iconTheme: IconThemeData(
        color: isDark ? Colors.white : Colors.black,
      ),
      dividerColor: const Color(0xFF222130),
      appBarTheme: AppBarTheme(
          backgroundColor: isDark ? AppColors.secondary : AppColors.primary,
          iconTheme: IconThemeData(
            color: isDark ? Colors.white : Colors.black,
          ),
          titleTextStyle: TextStyle(
            color: isDark ? Colors.white : Colors.black,
          )),
      tabBarTheme: TabBarThemeData(
        dividerColor: Colors.transparent,
        dividerHeight: 0,
        tabAlignment: TabAlignment.center,
        labelPadding: EdgeInsets.only(left: 15.w),
        indicator: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: AppColors.primary,
            ),
          ),
        ),
        labelColor: AppColors.primary,
        indicatorColor: AppColors.primary,
      ),
      cupertinoOverrideTheme: CupertinoThemeData(
        applyThemeToAll: true,
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      ),
      expansionTileTheme: ExpansionTileThemeData(
        backgroundColor: Colors.transparent,
        textColor: isDark ? Colors.white : Colors.black,
        collapsedBackgroundColor: Colors.transparent,
        collapsedIconColor: isDark ? Colors.white : Colors.black,
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontFamily: AppTextStyles.fontFamily,
          fontWeight: FontWeight.bold,
          fontSize: 20.sp,
          color: isDark ? Colors.white : Colors.black,
        ),
        titleLarge: TextStyle(
          fontFamily: AppTextStyles.fontFamily,
          fontSize: 16.sp,
          color: isDark ? Colors.white : Colors.black,
        ),
        titleMedium: TextStyle(
          fontFamily: AppTextStyles.fontFamily,
          fontSize: 15.sp,
          color: isDark ? Colors.white : Colors.black,
        ),
        titleSmall: TextStyle(
          fontFamily: AppTextStyles.fontFamily,
          fontSize: 13.sp,
          color: isDark ? Colors.white : Colors.black,
        ),
        labelLarge: TextStyle(
          fontFamily: AppTextStyles.fontFamily,
          fontSize: 14.sp,
          color: isDark ? Colors.white : Colors.black,
        ),
        labelMedium: TextStyle(
          fontFamily: AppTextStyles.fontFamily,
          fontSize: 12.sp,
          color: isDark ? Colors.white : Colors.black,
        ),
        labelSmall: TextStyle(
          fontFamily: AppTextStyles.fontFamily,
          fontSize: 10.sp,
          color: isDark ? Colors.white : Colors.black,
        ),
        displayLarge: TextStyle(
          fontFamily: AppTextStyles.fontFamily,
          fontSize: 16.sp,
          color: isDark ? Colors.white : Colors.black,
        ),
        bodyMedium: TextStyle(
          fontFamily: AppTextStyles.fontFamily,
          fontSize: 13.sp,
          color: isDark ? Colors.white : Colors.black,
        ),
        bodySmall: TextStyle(
          fontFamily: AppTextStyles.fontFamily,
          fontSize: 11.sp,
          color: isDark ? Colors.white : Colors.black,
        ),
        bodyLarge: TextStyle(
          fontFamily: AppTextStyles.fontFamily,
          fontSize: 14.sp,
          color: isDark ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
