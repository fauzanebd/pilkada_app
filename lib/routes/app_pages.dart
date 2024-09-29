import 'package:get/get.dart';
import 'package:pilkada_app/modules/auth/auth_binding.dart';
import 'package:pilkada_app/modules/auth/auth_screen.dart';
import 'package:pilkada_app/modules/auth/screens/login/login_bindings.dart';
import 'package:pilkada_app/modules/auth/screens/login/login_screen.dart';
import 'package:pilkada_app/modules/data_confirmation/data_confirmation_binding.dart';
import 'package:pilkada_app/modules/data_confirmation/data_confirmation_screen.dart';
import 'package:pilkada_app/modules/main/main.dart';
import 'package:pilkada_app/modules/splash/splash_binding.dart';
import 'package:pilkada_app/modules/splash/splash_screen.dart';

part 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.AUTH,
      page: () => const AuthScreen(),
      binding: AuthBinding(),
      transition: Transition.cupertinoDialog,
      children: [
        GetPage(
          name: Routes.LOGIN,
          page: () => const LoginScreen(),
          binding: LoginBinding(),
          transition: Transition.cupertinoDialog,
        ),
      ],
    ),
    GetPage(
      name: Routes.MAIN,
      page: () => const MainScreen(),
      binding: MainBinding(),
      transition: Transition.cupertinoDialog,
      children: [
        GetPage(
          name: Routes.DATA_CONFIRMATION,
          page: () => DataConfirmationScreen(),
          binding: DataConfirmationBinding(),
          transition: Transition.cupertinoDialog,
        )
      ],
    ),
  ];
}
