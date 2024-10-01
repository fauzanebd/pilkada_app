import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pilkada_app/api/api_repository.dart';
import 'package:pilkada_app/models/data_pemilih.dart';
import 'package:pilkada_app/models/response/anggota.dart';
import 'package:pilkada_app/models/response/meta.dart';
import 'package:pilkada_app/modules/detail_data/detail_data_controller.dart';
import 'package:pilkada_app/routes/app_pages.dart';
import 'package:pilkada_app/shared/constants/common.dart';
import 'package:pilkada_app/shared/utils/common_widget.dart';

class DaftarAnggotaController extends GetxController {
  final ApiRepository apiRepository;
  DaftarAnggotaController({required this.apiRepository});

  String token = Get.arguments as String;
  RxList<Anggota> daftarAnggota = RxList<Anggota>();
  RxBool isLoading = false.obs;
  Rx<Meta?> daftarAnggotaMeta = Rx<Meta?>(null);
  RxBool hasMoreData = true.obs;
  int currentPage = 1;
  static const int itemsPerPage = 10;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_scrollListener);
  }

  @override
  void onReady() async {
    super.onReady();
    await fetchDaftarAnggota();
  }

  @override
  void onClose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.onClose();
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (!isLoading.value && hasMoreData.value) {
        fetchDaftarAnggota();
      }
    }
  }

  Future<void> fetchDaftarAnggota() async {
    if (isLoading.value) return;

    isLoading.value = true;
    update([CommonConstants.kDaftarAnggotaBuilderId]);

    try {
      final newData = await apiRepository
          .fetchAnggota(token, itemsPerPage, currentPage)
          .then((value) {
        daftarAnggotaMeta.value = value.meta;
        return value.data;
      });
      if (newData.isEmpty) {
        hasMoreData.value = false;
      } else {
        daftarAnggota.addAll(newData);
        currentPage++;
        if (daftarAnggotaMeta.value!.total > currentPage * itemsPerPage) {
          hasMoreData.value = true;
        } else {
          hasMoreData.value = false;
        }
      }
    } catch (e) {
      CommonWidget.errorSnackbar(Get.context!, 'Failed to fetch data: $e');
    } finally {
      isLoading.value = false;
      update([CommonConstants.kDaftarAnggotaBuilderId]);
    }
  }

  Future<void> navigateToDetailData(DataPemilih dataPemilih) async {
    try {
      Get.toNamed(
        Routes.MAIN + Routes.DAFTAR_DATA + Routes.DETAIL_DATA,
        arguments: DetailDataArgs(token, dataPemilih),
      );
    } catch (e) {
      CommonWidget.errorSnackbar(
          Get.context!, 'Failed to navigate to detail data page: $e');
    }
  }

  Future<void> refreshData() async {
    currentPage = 1;
    daftarAnggota.clear();
    hasMoreData.value = true;
    await fetchDaftarAnggota();
  }
}
