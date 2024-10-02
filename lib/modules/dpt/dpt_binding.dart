import 'package:pilkada_app/api/api_repository.dart';
import 'package:get/get.dart';
import 'package:pilkada_app/modules/dpt/dpt_controller.dart';

class DPTBinding extends Bindings {
  
  @override
  void dependencies() {
    Get.put<DPTController>(DPTController(
      apiRepository: Get.find<ApiRepository>(),
    ));
  }
}
