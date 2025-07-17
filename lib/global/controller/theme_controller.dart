import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  RxBool isDarkTheme = RxBool(true);

  @override
  void onInit() {
    getThemeStatus();
    super.onInit();
  }

  void saveThemeStatus(bool isDarkMode) async {
    final localBD = await SharedPreferences.getInstance();
    await localBD.setBool('isDarkMode', isDarkMode);
  }

  void getThemeStatus() async {
    final localBD = await SharedPreferences.getInstance();
    isDarkTheme.value = localBD.getBool('isDarkMode') ?? true;
  }
}
