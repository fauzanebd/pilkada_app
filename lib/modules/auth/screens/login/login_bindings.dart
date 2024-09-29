import 'package:pilkada_app/api/api_repository.dart';
import 'package:pilkada_app/modules/auth/screens/login/login_controller.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    Get.lazyPut(
        () => LoginController(apiRepository: Get.find<ApiRepository>()));
  }
}
