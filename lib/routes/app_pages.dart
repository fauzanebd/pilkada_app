import 'package:get/get.dart';
import 'package:pilkada_app/modules/auth/auth_binding.dart';
import 'package:pilkada_app/modules/auth/auth_screen.dart';
import 'package:pilkada_app/modules/auth/screens/login/login_bindings.dart';
import 'package:pilkada_app/modules/auth/screens/login/login_screen.dart';
import 'package:pilkada_app/modules/daftar_anggota/daftar_anggota_binding.dart';
import 'package:pilkada_app/modules/daftar_anggota/daftar_anggota_screen.dart';
import 'package:pilkada_app/modules/daftar_data/daftar_data_binding.dart';
import 'package:pilkada_app/modules/daftar_data/daftar_data_screen.dart';
import 'package:pilkada_app/modules/data_confirmation/data_confirmation_binding.dart';
import 'package:pilkada_app/modules/data_confirmation/data_confirmation_screen.dart';
import 'package:pilkada_app/modules/detail_data/detail_data_binding.dart';
import 'package:pilkada_app/modules/main/main.dart';
import 'package:pilkada_app/modules/profile/profile_binding.dart';
import 'package:pilkada_app/modules/profile/profile_screen.dart';
import 'package:pilkada_app/modules/splash/splash_binding.dart';
import 'package:pilkada_app/modules/splash/splash_screen.dart';
import 'package:pilkada_app/modules/visi_misi/visi_misi_screen.dart';
import 'package:pilkada_app/modules/visi_misi/visi_misi_binding.dart';

import '../modules/detail_data/detail_data_screen.dart';

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
          page: () => const DataConfirmationScreen(),
          binding: DataConfirmationBinding(),
          transition: Transition.cupertinoDialog,
        ),
        GetPage(
            name: Routes.DAFTAR_DATA,
            page: () => const DaftarDataScreen(),
            binding: DaftarDataBinding(),
            transition: Transition.cupertino,
            children: [
              GetPage(
                name: Routes.DETAIL_DATA,
                page: () => const DetailDataScreen(),
                binding: DetailDataBinding(),
                transition: Transition.cupertino,
              ),
            ]),
        GetPage(
          name: Routes.VISI_MISI,
          page: () => const VisiMisiScreen(),
          binding: VisiMisiBinding(),
          transition: Transition.cupertinoDialog,
        ),
        GetPage(
          name: Routes.DAFTAR_ANGGOTA,
          page: () => const DaftarAnggotaScreen(),
          binding: DaftarAnggotaBinding(),
          transition: Transition.cupertino,
        ),
        GetPage(
          name: Routes.PROFILE,
          page: () => const ProfileScreen(),
          binding: ProfileBinding(),
          transition: Transition.cupertino,
        ),
      ],
    ),
  ];
}
