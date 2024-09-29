import 'package:pilkada_app/api/api_repository.dart';
import 'package:get/get.dart';
import 'package:pilkada_app/modules/data_confirmation/data_confirmation_controller.dart';

class DataConfirmationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DataConfirmationController>(
        DataConfirmationController(apiRepository: Get.find<ApiRepository>()));
  }
}
