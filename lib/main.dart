import 'package:evalys_main/module/home/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shopify_flutter/shopify_flutter.dart';
import 'package:toastification/toastification.dart';
import 'global/binding/app_binding.dart';
import 'global/theme/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  ShopifyConfig.setConfig(
    storefrontAccessToken: '23429d64af255f38e589512003c6efd5',
    storeUrl: 'https://evallys.com',
    storefrontApiVersion: '2024-07',
    cachePolicy: CachePolicy.cacheAndNetwork,
    language: 'en',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        useInheritedMediaQuery: true,
        rebuildFactor: (old, data) => true,
        builder: (context, widget) {
          return ToastificationWrapper(
            child: GetMaterialApp(
              initialBinding: AppInitBinding(),
              debugShowCheckedModeBanner: false,
              theme: AppMainTheme.main(isDark: true),
              themeMode: ThemeMode.light,
              home: const HomeView(),
              onInit: () {},
            ),
          );
        });
  }
}
