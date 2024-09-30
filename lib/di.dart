import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pilkada_app/lang/translation_service.dart';
import 'package:pilkada_app/lifecycle_controller.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pilkada_app/shared/services/storage_service.dart';

class DependencyInjection {
  static Future<void> init() async {
    await Get.putAsync(() => StorageService().init());
    Get.put(LifeCycleController());
    await dotenv.load(fileName: ".env");
    await initializeDateFormatting(TranslationService.locale.toString());
  }
}
