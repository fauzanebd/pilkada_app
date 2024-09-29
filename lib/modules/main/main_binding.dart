import 'package:pilkada_app/api/api_repository.dart';
import 'package:get/get.dart';
import 'main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MainController>(
        MainController(apiRepository: Get.find<ApiRepository>()));
  }
}
