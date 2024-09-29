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

  @override
  void onInit() {
    super.onInit();
    uploadImageResponse = args.uploadImageResponse;
    s3FileName = uploadImageResponse!.data.s3File ?? '';
    token = args.token;
    dataPemilih.value = uploadImageResponse!.data;
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
