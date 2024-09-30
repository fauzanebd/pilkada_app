import 'package:pilkada_app/api/api_repository.dart';
import 'package:get/get.dart';
import 'package:pilkada_app/modules/daftar_data/daftar_data_controller.dart';

class DaftarDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DaftarDataController>(DaftarDataController(
      apiRepository: Get.find<ApiRepository>(),
    ));
  }
}
