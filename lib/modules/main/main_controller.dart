import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pilkada_app/api/api_repository.dart';
import 'package:pilkada_app/models/banner.dart';
import 'package:pilkada_app/models/response/upload_image_response.dart';
import 'package:pilkada_app/models/user.dart';
import 'package:pilkada_app/modules/data_confirmation/data_confirmation_controller.dart';
import 'package:pilkada_app/modules/main/widgets/pick_photo_dialog_content.dart';
import 'package:pilkada_app/routes/app_pages.dart';
import 'package:pilkada_app/shared/constants/colors.dart';
import 'package:pilkada_app/shared/constants/common.dart';
import 'package:pilkada_app/shared/utils/common_widget.dart';

import '../../models/response/appconf_response.dart';

class MainController extends GetxController {
  final ApiRepository apiRepository;
  MainController({required this.apiRepository});

  MainArgs? mainArgs = Get.arguments as MainArgs?;

  String? token;
  User? currentUser;

  RxBool isUploadImageModalLoading = false.obs;

  AppConf appConf = AppConf();

  final RxInt activeCarouselIndex = 0.obs;

  final RxList<CarouselItem> carouselItems = List.generate(
    4,
    (index) => CarouselItem(
      bannerId: index,
      image: CommonConstants.imageNetworkPlaceholder,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ).obs;
  final RxBool carouselItemsLoading = true.obs;

  UploadImageResponse? uploadImageResponse;

  @override
  void onInit() {
    super.onInit();
    String? currentUserString = mainArgs?.currentUserString;
    token = mainArgs?.token;
    currentUser = User.fromString(currentUserString!);
  }


  Future<bool> _cameraAccessAllowed() async {
    if (Platform.isAndroid) {
      return Permission.camera.request().isGranted;
    } else {
      return true;
    }
  }

  Future<bool> _photoAccessAllowed() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt <= 32) {
        return await Permission.storage.request().isGranted;
      } else {
        return await Permission.photos.request().isGranted;
      }
    } else {
      return true;
    }
  }

  Future<CroppedFile?> _cropImage(XFile image) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'Crop Image',
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPresetCustom(), // IMPORTANT: iOS supports only one custom aspect ratio in preset list
          ],
        ),
      ],
    );
    return croppedFile;
  }

  Future<void> _uploadImage(File image) async {
    isUploadImageModalLoading.value = true;
    try {
      uploadImageResponse = await apiRepository.uploadImage(
        image.path,
        image.path.split('/').last,
        userId: currentUser!.id,
        token: token!,
      );
      Get.toNamed(Routes.MAIN + Routes.DATA_CONFIRMATION,
          arguments: DataConfirmationArgs(token!, uploadImageResponse!));
    } catch (e) {
      isUploadImageModalLoading.value = false;
      CommonWidget.toast('Upload image failed: $e');
    }
  }

  Future<void> _captureImage() async {
    if (await _cameraAccessAllowed()) {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      CroppedFile? croppedFile;

      if (image != null) {
        croppedFile = await _cropImage(image);
        if (croppedFile != null) {
          Navigator.of(Get.context!).pop();
          EasyLoading.show(status: 'Uploading image...');
          await _uploadImage(File(croppedFile.path));
          EasyLoading.dismiss();
        }
      }
    } else {
      const SnackBar(
          content: Text('App does not have permission to access camera.'));
    }
  }

  Future<void> _pickImageFromGallery() async {
    if (await _photoAccessAllowed()) {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      CroppedFile? croppedFile;

      if (image != null) {
        croppedFile = await _cropImage(image);
        if (croppedFile != null) {
          Navigator.of(Get.context!).pop();
          EasyLoading.show(
              status: 'Uploading image...',
              maskType: EasyLoadingMaskType.black);
          await _uploadImage(File(croppedFile.path));
          EasyLoading.dismiss();
        }
      }
    } else {
      const SnackBar(
          content: Text('App does not have permission to access gallery.'));
    }
  }

  void onAddDataTap() {
    final ImagePicker picker = ImagePicker();

    showModalBottomSheet(
      context: Get.context!,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            color: const Color.fromRGBO(0, 0, 0, 0.001),
            child: PickPhotoDialogContent(
              onCancelDialog: () => Navigator.of(context).pop(),
              onTakePhoto: () async {
                // Implement camera functionality here
                await _captureImage();
              },
              onChooseFromGallery: () async {
                await _pickImageFromGallery();
                // Navigator.of(context).pop();
              },
            ),
          ),
        );
      },
    );
  }

  void navigateToPage(String page) {
    switch (page) {
      case 'Daftar Data':
        // Navigate to Daftar Data page
        break;
      case 'Visi & Misi':
        // Navigate to Visi & Misi page
        break;
      case 'Anggota':
        // Navigate to Anggota page
        break;
      case 'Profil':
        // Navigate to Profil page
        break;
      case 'DPT':
        // Navigate to DPT page
        break;
      case 'Keluar':
        // Implement logout functionality
        break;
    }
  }

  Future<void> refreshAppConf() async {
    appConf = AppConf();
    update([
      // image carousel consume appconf slider interval
      CommonConstants.kImageCarouselBuilderId,
    ]);
    Get.delete<AppConf>();
    Get.put<AppConf>(appConf, permanent: true);
  }
}

class MainArgs {
  final String token;
  final String currentUserString;
  MainArgs(this.token, this.currentUserString);
}

class CropAspectRatioPresetCustom implements CropAspectRatioPresetData {
  @override
  (int, int)? get data => (2, 3);

  @override
  String get name => '2x3 (customized)';
}
