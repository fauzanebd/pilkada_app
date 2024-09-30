import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pilkada_app/api/api_repository.dart';
import 'package:pilkada_app/models/data_pemilih.dart';
import 'package:pilkada_app/modules/daftar_data/daftar_data_controller.dart';

class DetailDataController extends GetxController {
  final ApiRepository apiRepository;
  DetailDataController({required this.apiRepository});

  DetailDataArgs args = Get.arguments as DetailDataArgs;

  DataPemilih? dataPemilih;

  String? token;
  late String s3FileName;

  RxBool isLoading = false.obs;

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
  final GlobalKey<FormState> detailDataKey = GlobalKey<FormState>();
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

    dataPemilih = args.dataPemilih;
    s3FileName = dataPemilih!.s3File ?? '';
    token = args.token;

    nameController.text = dataPemilih!.name ?? '';
    nikController.text = dataPemilih!.nik ?? '';
    addressController.text = dataPemilih!.address ?? '';
    birthDateController.text = dataPemilih!.birthDate ?? '';
    genderController.text = dataPemilih!.gender ?? '';
    noPhoneController.text = dataPemilih!.noPhone ?? '';
    noTpsController.text = dataPemilih!.noTps ?? '';
    isPartyMemberController.text = dataPemilih!.isPartyMember?.toString() ?? '';
    categoryController.text = dataPemilih!.category ?? '';
    confirmationStatusController.text = dataPemilih!.confirmationStatus ?? '';
    expectationToCandidateController.text =
        dataPemilih!.expectationToCandidate ?? '';
    positioningToCandidateController.text =
        dataPemilih!.positioningToCandidate ?? '';
    relationToCandidateController.text = dataPemilih!.relationToCandidate ?? '';
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
    confirmationStatusController.dispose();
  }

  Future<void> updateData() async {
    isLoading.value = true;
    String? res;
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

      EasyLoading.show(status: 'Updating data...');
      res = await apiRepository.updateData(dataPemilih!, token!);
      isLoading.value = false;
      if (res != null) {
        Get.find<DaftarDataController>().updateDataItem(dataPemilih!);
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text('$res. Thank you!')),
        );
        EasyLoading.dismiss();
        Get.back();
      }
    } catch (e) {
      EasyLoading.dismiss();
      isLoading.value = false;
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
            content: Text('Failed to update data. Please try again.')),
      );
      Get.back();
    }
    // }
  }
}

class DetailDataArgs {
  final String token;
  final DataPemilih dataPemilih;
  DetailDataArgs(this.token, this.dataPemilih);
}
