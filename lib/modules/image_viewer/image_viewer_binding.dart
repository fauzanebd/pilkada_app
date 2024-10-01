import 'package:get/get.dart';
import 'package:pilkada_app/modules/image_viewer/image_viewer_controller.dart';

class ImageViewerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ImageViewerController>(ImageViewerController());
  }
}
