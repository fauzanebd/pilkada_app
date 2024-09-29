import 'package:flutter/material.dart';
import 'package:pilkada_app/api/api_repository.dart';
import 'package:pilkada_app/modules/main/main_controller.dart';
import 'package:pilkada_app/routes/routes.dart';
import 'package:pilkada_app/shared/constants/constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  final ApiRepository apiRepository;
  SplashController({required this.apiRepository});

  @override
  void onReady() async {
    super.onReady();

    var storage = Get.find<SharedPreferences>();

    debugPrint(Get.currentRoute);

    try {
      String? token = storage.getString(StorageConstants.token);
      String? currentUserString =
          storage.getString(StorageConstants.currentUserString);
      if (token != null && currentUserString != null) {
        Get.offAllNamed(Routes.MAIN,
            arguments: MainArgs(token, currentUserString));
        // get parameters
      } else {
        Get.offAllNamed(Routes.AUTH);
      }
    } catch (e) {
      Get.offAllNamed(Routes.AUTH);
    }
  }
}
