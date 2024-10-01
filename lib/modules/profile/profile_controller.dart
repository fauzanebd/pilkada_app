import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pilkada_app/api/api.dart';
import 'package:pilkada_app/models/user.dart';
import 'package:pilkada_app/modules/main/main_controller.dart';
import 'package:pilkada_app/modules/main/widgets/pick_photo_dialog_content.dart';
import 'package:pilkada_app/shared/constants/colors.dart';
import 'package:pilkada_app/shared/constants/common.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  final ApiRepository apiRepository;
  ProfileController({
    required this.apiRepository,
  });

  ProfileArgs editProfileArgs = Get.arguments as ProfileArgs;

  final GlobalKey<FormState> editProfileFormKey = GlobalKey<FormState>();
  final editUserNameController = TextEditingController();
  final editNomorHPController = TextEditingController();
  final editProvinsiController = TextEditingController();
  final editKotaController = TextEditingController();

  final RxBool isEditProfileLoading = false.obs;

  void dismissEditProfileLoading() {
    isEditProfileLoading.value = false;
    update([CommonConstants.kEditProfileButtonBuilderId]);
  }

  void showEditProfileLoading() {
    isEditProfileLoading.value = true;
    update([CommonConstants.kEditProfileButtonBuilderId]);
  }

  Rx<XFile?> updatedImage = Rx<XFile?>(null);

  @override
  void onInit() {
    super.onInit();

    editUserNameController.text = editProfileArgs.user.username ?? '';
    editNomorHPController.text = editProfileArgs.user.noPhone ?? '';
    editProvinsiController.text = editProfileArgs.user.provinceCode ?? '';
    editKotaController.text = editProfileArgs.user.cityCode ?? '';
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
    throw UnimplementedError();
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
          EasyLoading.show(status: 'Mengunggah gambar...');
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
              status: 'Mengunggah gambar...',
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

  Future<void> onEditPhotoTap() async {
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
              isEnumerator: false,
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

    Get.generalDialog(
      pageBuilder: (buildContext, animation, secondaryAnimation) {
        return PickPhotoDialogContent(
          isEnumerator: false,
          onCancelDialog: () => Get.back(),
          onTakePhoto: () async {
            final XFile? image = await picker.pickImage(
              source: ImageSource.camera,
              imageQuality: 50,
            );
            if (image != null) {
              updatedImage.value = image;
              update([CommonConstants.kProfileAvatarBuilderId]);
              Get.back();
            }
          },
          onChooseFromGallery: () async {
            final XFile? image = await picker.pickImage(
              source: ImageSource.gallery,
              imageQuality: 50,
            );
            if (image != null) {
              updatedImage.value = image;
              update([CommonConstants.kProfileAvatarBuilderId]);
              Get.back();
            }
          },
        );
      },
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: ColorConstants.appScaffoldBackgroundColor.withOpacity(0.5),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: Offset.zero)
              .animate(animation),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
    );
  }

  Future<void> editProfile(BuildContext context) async {
    throw UnimplementedError();
  }

  @override
  void onClose() {
    super.onClose();
    editUserNameController.dispose();
    editNomorHPController.dispose();
    editProvinsiController.dispose();
    editKotaController.dispose();
  }
}

class ProfileArgs {
  ProfileArgs({
    required this.token,
    required this.user,
  });

  final String token;
  final User user;
}
