import 'package:pilkada_app/routes/routes.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  Future<void> goToLoginScreen() async {
    // await LoginBinding().dependencies();
    Get.toNamed(Routes.AUTH + Routes.LOGIN);
  }
}
