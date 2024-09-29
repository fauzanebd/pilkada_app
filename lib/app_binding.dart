import 'package:pilkada_app/api/api_provider.dart';
import 'package:pilkada_app/api/api_repository.dart';
import 'package:get/get.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() async {
    Get.put(ApiProvider(), permanent: true);
    Get.put(ApiRepository(apiProvider: Get.find<ApiProvider>()),
        permanent: true);
  }
}
