import 'package:pilkada_app/routes/app_pages.dart';
import 'package:pilkada_app/shared/constants/storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthUtils {
  static void logOut() {
    var prefs = Get.find<SharedPreferences>();
    prefs.remove(StorageConstants.token);
    prefs.remove(StorageConstants.userId);
    prefs.remove(StorageConstants.localLangSettings);
    prefs.remove(StorageConstants.currentUserString);
    Get.offAllNamed(Routes.AUTH);
  }
}
