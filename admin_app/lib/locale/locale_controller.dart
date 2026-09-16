import 'dart:ui';
import 'package:get/get.dart';
import '../utils/app_preferances.dart';

class MyLocaleController extends GetxController {
  late Locale initialLang;

  @override
  void onInit() {
    super.onInit();
    _loadInitialLang();
  }

  Future<void> _loadInitialLang() async {
    String? lang = await AppPreferences.getLang();

    if (lang == null) {
      initialLang = Get.deviceLocale ?? const Locale('en');
    } else {
      initialLang = Locale(lang);
    }

    Get.updateLocale(initialLang);
  }

  Future<void> changeLang(String codeLang) async {
    Locale locale = Locale(codeLang);
    await AppPreferences.setLang(codeLang);
    Get.updateLocale(locale);
    initialLang = locale;
  }

  Future<void> toggleLang() async {
    String currentLang = Get.locale?.languageCode ?? initialLang.languageCode;
    if (currentLang == "ar") {
      await changeLang("en");
    } else {
      await changeLang("ar");
    }
  }
}
