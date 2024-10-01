import 'package:pilkada_app/api/api_repository.dart';
import 'package:pilkada_app/models/request/login_request.dart';
import 'package:pilkada_app/models/response/login_response.dart';
import 'package:pilkada_app/modules/main/main_controller.dart';
import 'package:pilkada_app/routes/routes.dart';
import 'package:pilkada_app/shared/constants/common.dart';
import 'package:pilkada_app/shared/constants/storage.dart';
import 'package:pilkada_app/shared/utils/common_widget.dart';
import 'package:pilkada_app/shared/utils/exceptions.dart';
import 'package:pilkada_app/shared/utils/focus.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class LoginController extends GetxController {
  final ApiRepository apiRepository;
  LoginController({required this.apiRepository});

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final loginUsernameController = TextEditingController();
  final loginPasswordController = TextEditingController();

  final RxBool isLoginLoading = false.obs;
  final RxBool isObscureLoginPassword = true.obs;

  void dismissLoginLoading() {
    isLoginLoading.value = false;
    update([CommonConstants.kLoginButtonBuilderId]);
  }

  void showLoginLoading() {
    isLoginLoading.value = true;
    update([CommonConstants.kLoginButtonBuilderId]);
  }

  String token = '';
  String currentUserString = '';
  int userId = 0;

  @override
  void onReady() {
    super.onReady();
    final SharedPreferences prefs = Get.find<SharedPreferences>();
    final String? previouslyEnteredUsername =
        prefs.getString(StorageConstants.previouslyEnteredUsername);
    if (previouslyEnteredUsername != null) {
      loginUsernameController.text = previouslyEnteredUsername;
    }
  }

  void toggleObscureLoginPassword() {
    isObscureLoginPassword.value = !isObscureLoginPassword.value;
    update([CommonConstants.kLoginPasswordBuilderId]);
  }

  void login(BuildContext context) async {
    AppFocus.unfocus(context);
    if (loginFormKey.currentState!.validate()) {
      showLoginLoading();
      try {
        final LoginResponse? logRes = await apiRepository.login(
          LoginRequest(
            username: loginUsernameController.text,
            password: loginPasswordController.text,
          ),
        );

        final SharedPreferences prefs = Get.find<SharedPreferences>();
        if (logRes != null) {
          if (logRes.token.isNotEmpty) {
            // save username to shared preferences
            prefs.setString(StorageConstants.previouslyEnteredUsername,
                loginUsernameController.text);

            // save token to shared preferences
            prefs.setString(StorageConstants.token, logRes.token);
            prefs.setInt(StorageConstants.userId, logRes.user.id);
            prefs.setString(
                StorageConstants.currentUserString, logRes.user.jsonToString());
            token = logRes.token;
            userId = logRes.user.id;
            currentUserString = logRes.user.jsonToString();
            Get.offNamed(Routes.MAIN,
                arguments: MainArgs(token, currentUserString));
            dismissLoginLoading();
          }
        } else {
          // this is awkward
          dismissLoginLoading();
          CommonWidget.errorSnackbar(Get.context!, 'Unknown Error');
        }
      } on UnauthorizedException {
        dismissLoginLoading();
        CommonWidget.errorSnackbar(
            Get.context!, 'Username atau password salah');
      } on NotFoundException {
        CommonWidget.errorSnackbar(
            Get.context!, 'Username atau password salah');
      } on NetworkException {
        dismissLoginLoading();
        CommonWidget.errorSnackbar(
            Get.context!, 'Gagal login. coba periksa jaringan anda');
      } on LoginException catch (e) {
        dismissLoginLoading();
        CommonWidget.errorSnackbar(
            Get.context!, '${'Gagal login'}: ${e.message}');
      } catch (e) {
        dismissLoginLoading();
        CommonWidget.errorSnackbar(Get.context!, '${'Gagal login'}: $e');
      }
    }
  }

  void goToRegisterScreen() {
    Get.offAllNamed(Routes.AUTH + Routes.REGISTER);
  }

  // void goToForgotPasswordScreen(BuildContext context) {
  //   AppFocus.unfocus(context);
  //   Get.toNamed(Routes.AUTH + Routes.LOGIN + Routes.FORGOT_PASSWORD);
  // }

  // static Future<void> onAccountActivated() async {
  //   Future.delayed(
  //     const Duration(seconds: 1),
  //     () {
  //       Get.generalDialog(
  //         pageBuilder: (buildContext, animation, secondaryAnimation) {
  //           return const AccountActivatedWelcomeDialog();
  //         },
  //         barrierDismissible: true,
  //         barrierLabel: '',
  //         barrierColor:
  //             ColorConstants.appScaffoldBackgroundColor.withOpacity(0.5),
  //         transitionBuilder: (context, animation, secondaryAnimation, child) {
  //           return ScaleTransition(
  //             scale: Tween<double>(begin: 0.8, end: 1.0).animate(animation),
  //             child: FadeTransition(
  //               opacity: Tween<double>(begin: 0.0, end: 1.0).animate(animation),
  //               child: child,
  //             ),
  //           );
  //         },
  //         transitionDuration: const Duration(milliseconds: 100),
  //       );
  //     },
  //   );
  // }

  @override
  void onClose() {
    super.onClose();
    loginUsernameController.dispose();
    loginPasswordController.dispose();
  }

  // Future<User?> getCurrentUser(String token) async {
  //   final User? user = await apiRepository.getCurrentUser(token);
  //   return user;
  // }
}
