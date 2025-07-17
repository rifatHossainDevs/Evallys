import 'package:evalys_main/module/home/controller/home_controller.dart';
import 'package:get/get.dart';

class AppInitBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
