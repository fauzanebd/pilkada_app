import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pilkada_app/api/api_repository.dart';
import 'package:pilkada_app/models/banner.dart';
import 'package:pilkada_app/models/response/upload_image_response.dart';
import 'package:pilkada_app/models/user.dart';
import 'package:pilkada_app/modules/data_confirmation/data_confirmation_controller.dart';
import 'package:pilkada_app/modules/main/widgets/pick_photo_dialog_content.dart';
import 'package:pilkada_app/modules/profile/profile_controller.dart';
import 'package:pilkada_app/modules/visi_misi/visi_misi_controller.dart';
import 'package:pilkada_app/routes/app_pages.dart';
import 'package:pilkada_app/shared/constants/common.dart';
import 'package:pilkada_app/shared/utils/auth.dart';
import 'package:pilkada_app/shared/utils/common_widget.dart';
import 'package:url_launcher/url_launcher.dart';

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

  final RxList<CarouselItem> carouselItems = [
    CarouselItem(
      bannerId: 1,
      image: 'assets/pngs/slider1.png',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      isPng: true,
    ),
    CarouselItem(
      bannerId: 1,
      image: 'assets/pngs/slider2.png',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      isPng: true,
    ),
    CarouselItem(
      bannerId: 1,
      image: 'assets/pngs/slider3.png',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      isPng: true,
    ),
  ].obs;
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
        clientCode: dotenv.get('CLIENT_CODE'),
      );

      //mock
      // uploadImageResponse = UploadImageResponse(
      //   data: DataPemilih(
      //     name: 'Agus Sujono',
      //     nik: '233454504',
      //     address: 'Jl. Kebon Jeruk',
      //     birthDate: '2023-08-01',
      //     gender: 'L',
      //     noPhone: '0812345678',
      //     noTps: '0943',
      //     isPartyMember: true,
      //     category: 'category',
      //     expectationToCandidate: 'wahahaha',
      //     positioningToCandidate: 'struick',
      //     relationToCandidate: 'krisfk',
      //   ),

      // error: false,
      // message: 'message',
      // );
      Get.toNamed(
        Routes.MAIN + Routes.DATA_CONFIRMATION,
        arguments: DataConfirmationArgs(token!, uploadImageResponse!),
      );
    } catch (e) {
      isUploadImageModalLoading.value = false;
      CommonWidget.errorSnackbar(Get.context!, 'Upload image failed: $e');
    }
  }

  void launchURL(String url) async {
    Uri u = Uri.parse(url);
    if (!await launchUrl(u)) {
      throw Exception('Could not launch $url');
    }
  }

  void onImageTap(String imagePath) {
    Get.toNamed(
      Routes.MAIN + Routes.IMAGE_VIEWER,
      arguments: imagePath,
    );
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
      SnackBar(
        content: Text(
          'App does not have permission to access camera.',
          style: CommonConstants.kSnackbarText,
        ),
      );
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
      SnackBar(
        content: Text(
          'Aplikasi tidak diizinkan mengakses galeri.',
          style: CommonConstants.kSnackbarText,
        ),
      );
    }
  }

  void onAddDataTap() {
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
              isEnumerator: (currentUser != null &&
                  !(currentUser!.isEnumerator ?? false)),
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

  Future<void> navigateToPage(String page) async {
    switch (page) {
      case 'Daftar Data':
        // Navigate to Daftar Data page
        Get.toNamed(
          Routes.MAIN + Routes.DAFTAR_DATA,
          arguments: token!,
        );
        break;
      case 'Visi & Misi':
        // Navigate to Visi & Misi page
        Get.toNamed(
          Routes.MAIN + Routes.VISI_MISI,
          arguments: VisiMisiArgs(token!),
        );
        break;
      case 'Anggota':
        // Navigate to Anggota page
        Get.toNamed(
          Routes.MAIN + Routes.DAFTAR_ANGGOTA,
          arguments: token!,
        );
        break;
      case 'Profil':
        // Navigate to Profil page
        Get.toNamed(
          Routes.MAIN + Routes.PROFILE,
          arguments: ProfileArgs(token: token!, user: currentUser!),
        );
        break;
      case 'DPT':
        // Navigate to DPT page
        break;
      case 'Keluar':
        // Implement logout functionality
        AuthUtils.logOut();
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
