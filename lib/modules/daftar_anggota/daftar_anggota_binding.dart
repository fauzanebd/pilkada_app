import 'package:pilkada_app/api/api_repository.dart';
import 'package:get/get.dart';
import 'package:pilkada_app/modules/daftar_anggota/daftar_anggota_controller.dart';

class DaftarAnggotaBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DaftarAnggotaController>(DaftarAnggotaController(
      apiRepository: Get.find<ApiRepository>(),
    ));
  }
}
