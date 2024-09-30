import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pilkada_app/api/api_repository.dart';
import 'package:pilkada_app/models/data_pemilih.dart';
import 'package:pilkada_app/models/response/save_data_response.dart';
import 'package:pilkada_app/models/response/upload_image_response.dart';

class DataConfirmationController extends GetxController {
  final ApiRepository apiRepository;
  DataConfirmationController({required this.apiRepository});

  DataConfirmationArgs args = Get.arguments as DataConfirmationArgs;
  UploadImageResponse? uploadImageResponse;
  String? token;
  late String s3FileName;

  RxBool isLoading = false.obs;

  DataPemilih? dataPemilih;

  List<String> gender = const ['L', 'P'];

  List<String> positioningToCandidateValues = const [
    '-',
    'Sangat Setia',
    'Setia',
    'Biasa',
  ];

  List<String> categoryValues = const [
    '-',
    'Hitam',
    'Putih',
    'Abu-abu',
  ];

  List<String> confirmationStatus = const [
    '-',
    'Solid',
    'Menunggu',
    'Santai',
  ];

  // Form
  final GlobalKey<FormState> dataConfirmationFormKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final nikController = TextEditingController();
  final addressController = TextEditingController();
  final birthDateController = TextEditingController();
  final genderController = TextEditingController();
  final noPhoneController = TextEditingController();
  final noTpsController = TextEditingController();
  final isPartyMemberController = TextEditingController();
  final categoryController = TextEditingController();
  final confirmationStatusController = TextEditingController();
  final expectationToCandidateController = TextEditingController();
  final positioningToCandidateController = TextEditingController();
  final relationToCandidateController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    uploadImageResponse = args.uploadImageResponse;
    s3FileName = uploadImageResponse!.data.s3File ?? '';
    token = args.token;
    dataPemilih = uploadImageResponse!.data;

    nameController.text = dataPemilih!.name ?? '';
    nikController.text = dataPemilih!.nik ?? '';
    addressController.text = dataPemilih!.address ?? '';
    birthDateController.text = dataPemilih!.birthDate ?? '';
    genderController.text = dataPemilih!.gender ?? gender[0];
    isPartyMemberController.text =
        dataPemilih!.isPartyMember?.toString() ?? "false";
  }

  @override
  void onClose() {
    super.onClose();
    nameController.dispose();
    nikController.dispose();
    addressController.dispose();
    birthDateController.dispose();
    genderController.dispose();
    noPhoneController.dispose();
    noTpsController.dispose();
    isPartyMemberController.dispose();
    categoryController.dispose();
    confirmationStatusController.dispose();
    expectationToCandidateController.dispose();
    positioningToCandidateController.dispose();
    relationToCandidateController.dispose();
  }

  Future<void> saveData() async {
    isLoading.value = true;
    SaveDataResponse? res;
    try {
      dataPemilih!.name = nameController.text;
      dataPemilih!.nik = nikController.text;
      dataPemilih!.address = addressController.text;
      if (birthDateController.text.isNotEmpty) {
        dataPemilih!.birthDate = birthDateController.text;
      } else {
        dataPemilih!.birthDate = null;
      }
      dataPemilih!.gender = genderController.text;
      dataPemilih!.noPhone = noPhoneController.text;
      dataPemilih!.noTps = noTpsController.text;
      dataPemilih!.isPartyMember = isPartyMemberController.text == 'true';
      dataPemilih!.category = categoryController.text;
      dataPemilih!.confirmationStatus = confirmationStatusController.text;
      dataPemilih!.expectationToCandidate =
          expectationToCandidateController.text;
      dataPemilih!.positioningToCandidate =
          positioningToCandidateController.text;
      dataPemilih!.relationToCandidate = relationToCandidateController.text;

      EasyLoading.show(status: 'Saving data...');

      res = await apiRepository.saveData(dataPemilih!, token!);
      isLoading.value = false;
      if (res != null) {
        EasyLoading.dismiss();
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(content: Text('Data saved successfully. Thank you!')),
        );
        Get.back();
      }
    } catch (e) {
      EasyLoading.dismiss();
      isLoading.value = false;
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(content: Text('Failed to save data. Please try again.')),
      );
      Get.back();
    }
  }
}

class DataConfirmationArgs {
  final String token;
  final UploadImageResponse uploadImageResponse;
  DataConfirmationArgs(this.token, this.uploadImageResponse);
}
