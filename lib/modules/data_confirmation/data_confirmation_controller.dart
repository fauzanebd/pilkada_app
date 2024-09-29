import 'package:flutter/material.dart';
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

  Rx<DataPemilih?> dataPemilih = Rx<DataPemilih?>(null);

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
  final expectationToCandidateController = TextEditingController();
  final positioningToCandidateController = TextEditingController();
  final relationToCandidateController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    uploadImageResponse = args.uploadImageResponse;
    s3FileName = uploadImageResponse!.data.s3File ?? '';
    token = args.token;
    dataPemilih.value = uploadImageResponse!.data;

    nameController.text = dataPemilih.value!.name!;
    nikController.text = dataPemilih.value!.nik!;
    addressController.text = dataPemilih.value!.address!;
    birthDateController.text = dataPemilih.value!.birthDate!;
    genderController.text = dataPemilih.value!.gender!;
    noPhoneController.text = dataPemilih.value!.noPhone!;
    noTpsController.text = dataPemilih.value!.noTps!;
    isPartyMemberController.text = dataPemilih.value!.isPartyMember!.toString();
    categoryController.text = dataPemilih.value!.category!;
    expectationToCandidateController.text =
        dataPemilih.value!.expectationToCandidate!;
    positioningToCandidateController.text =
        dataPemilih.value!.positioningToCandidate!;
    relationToCandidateController.text =
        dataPemilih.value!.relationToCandidate!;
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
    expectationToCandidateController.dispose();
    positioningToCandidateController.dispose();
    relationToCandidateController.dispose();
  }

  Future<void> saveData() async {
    isLoading.value = true;
    SaveDataResponse? res;
    try {
      res = await apiRepository.saveData(dataPemilih.value!, token!);
      isLoading.value = false;
      if (res != null) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(content: Text('Data saved successfully. Thank you!')),
        );
        Get.back();
      }
    } catch (e) {
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
