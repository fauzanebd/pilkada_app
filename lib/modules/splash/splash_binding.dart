import 'package:pilkada_app/api/api_repository.dart';
import 'package:get/get.dart';
import 'splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(
        SplashController(apiRepository: Get.find<ApiRepository>()));
  }
}
