import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pilkada_app/app_binding.dart';
import 'package:pilkada_app/di.dart';
import 'package:pilkada_app/lang/translation_service.dart';
import 'package:pilkada_app/shared/constants/constants.dart';
import 'package:pilkada_app/theme/theme.dart';
import 'package:get/get.dart';
import 'package:pilkada_app/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletonizer/skeletonizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjection.init();

  runApp(const PilkadaApp());

  configLoading();
}

class PilkadaApp extends StatelessWidget {
  const PilkadaApp({super.key});

  @override
  Widget build(BuildContext context) {
    final SharedPreferences prefs = Get.find<SharedPreferences>();
    final int? localLang = prefs.getInt(StorageConstants.localLangSettings);
    Locale appLangLocale = TranslationService.locale!;
    if (localLang != null) {
      switch (localLang) {
        case 1:
          // indonesia
          appLangLocale = const Locale('id', 'ID');
          break;
        case 2:
          // english
          appLangLocale = const Locale('en', 'US');
          break;
        default:
          break;
      }
    }
    return ScreenUtilInit(
      designSize: const Size(
        CommonConstants.kDesignWidth,
        CommonConstants.kDesignHeight,
      ),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return SkeletonizerConfig(
          data: const SkeletonizerConfigData(
            effect: ShimmerEffect(
              baseColor: ColorConstants.shimmerBaseColor,
              highlightColor: ColorConstants.shimmerHighlightColor,
            ),
            justifyMultiLineText: true,
            ignoreContainers: false,
          ),
          child: GetMaterialApp(
            onInit: () async {
              // await DeepLinkService().initDeepLink();
            },
            debugShowCheckedModeBanner: false,
            enableLog: true,
            initialRoute: Routes.INITIAL,
            defaultTransition: Transition.fade,
            getPages: AppPages.routes,
            initialBinding: AppBinding(),
            smartManagement: SmartManagement.keepFactory,
            title: 'Pilkada App',
            theme: ThemeConfig.mainTheme.copyWith(
              canvasColor: Colors.transparent,
            ),
            // locale: TranslationService.locale,
            locale: appLangLocale,
            // fallbackLocale: TranslationService.fallbackLocale,
            // translations: TranslationService(),
            // builder: EasyLoading.init(),
            builder: (context, child) {
              final MediaQueryData mediaQueryData = MediaQuery.of(context);
              final scale = mediaQueryData.textScaler.clamp(
                minScaleFactor: 1,
                maxScaleFactor: 1.2,
              );

              // Disable landscape mode
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.portraitUp,
                DeviceOrientation.portraitDown,
              ]);
              // EasyLoading.init();
              return FlutterEasyLoading(
                child: MediaQuery(
                  data: mediaQueryData.copyWith(textScaler: scale),
                  child: child!,
                ),
              );
            },
          ),
        );
      },
    );
  }
}

void configLoading() {
  EasyLoading.instance
    // ..indicatorType = EasyLoadingIndicatorType.threeBounce
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.custom
    // ..indicatorSize = 45.0
    ..radius = 10.0
    // ..progressColor = Colors.yellow
    ..backgroundColor = ColorConstants.appScaffoldBackgroundColor
    ..indicatorColor = ColorConstants.primaryAccentColor
    ..textColor = ColorConstants.primaryAccentColor
    ..maskColor = Colors.white
    ..userInteractions = false
    ..dismissOnTap = false
    ..animationStyle = EasyLoadingAnimationStyle.scale;
}
