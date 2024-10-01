import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:pilkada_app/modules/image_viewer/image_viewer_controller.dart';
import 'package:pilkada_app/shared/screens/screens.dart';
import 'package:path/path.dart' as path;

class ImageViewerScreen extends GetView<ImageViewerController> {
  const ImageViewerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPopScreen(
      appBarTitle: path.basename(controller.imagePath),
      body: Center(
        // child: Text('image goes here'),
        child: PhotoView(
          imageProvider: AssetImage(controller.imagePath),
        ),
      ),
    );
  }
}
