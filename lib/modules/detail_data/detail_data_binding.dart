import 'package:pilkada_app/api/api_repository.dart';
import 'package:get/get.dart';
import 'package:pilkada_app/modules/detail_data/detail_data_controller.dart';

class DetailDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DetailDataController>(
        DetailDataController(apiRepository: Get.find<ApiRepository>()));
  }
}
