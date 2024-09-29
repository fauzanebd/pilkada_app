import 'package:pilkada_app/api/api_repository.dart';
import 'package:get/get.dart';
import 'visi_misi_controller.dart';

class VisiMisiBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<VisiMisiController>(
        VisiMisiController(apiRepository: Get.find<ApiRepository>()));
  }
}
