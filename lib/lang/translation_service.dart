import 'dart:ui';

import 'package:get/get.dart';

class TranslationService extends Translations {
  TranslationService();
  static Locale? get locale => Get.deviceLocale;
  static const fallbackLocale = Locale('en', 'US');
  @override
  Map<String, Map<String, String>> get keys => {};
}
