import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pilkada_app/api/api_repository.dart';
import 'package:pilkada_app/models/data_pemilih.dart';
import 'package:pilkada_app/models/response/meta.dart';
import 'package:pilkada_app/modules/detail_data/detail_data_controller.dart';
import 'package:pilkada_app/routes/app_pages.dart';
import 'package:pilkada_app/shared/constants/common.dart';
import 'package:pilkada_app/shared/utils/common_widget.dart';

class DaftarDataController extends GetxController {
  final ApiRepository apiRepository;
  DaftarDataController({required this.apiRepository});

  String token = Get.arguments as String;
  RxList<DataPemilih> dataPemilih = RxList<DataPemilih>();
  RxBool isLoading = false.obs;
  Rx<Meta?> daftarDataPemilihMeta = Rx<Meta?>(null);
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
    await fetchDataPemilih();
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
        fetchDataPemilih();
      }
    }
  }

  Future<void> fetchDataPemilih() async {
    if (isLoading.value) return;

    isLoading.value = true;
    update([CommonConstants.kDaftarDataBuilderId]);

    try {
      final newData = await apiRepository
          .fetchDaftarDataPemilih(token, itemsPerPage, currentPage)
          .then((value) {
        daftarDataPemilihMeta.value = value.meta;
        return value.data;
      });
      if (newData.isEmpty) {
        hasMoreData.value = false;
      } else {
        dataPemilih.addAll(newData);
        currentPage++;
        if (daftarDataPemilihMeta.value!.total > currentPage * itemsPerPage) {
          hasMoreData.value = true;
        } else {
          hasMoreData.value = false;
        }
      }
    } catch (e) {
      CommonWidget.toast('Failed to fetch data: $e');
    } finally {
      isLoading.value = false;
      update([CommonConstants.kDaftarDataBuilderId]);
    }
  }

  void updateDataItem(DataPemilih updatedData) {
    final index = dataPemilih.indexWhere((item) => item.id == updatedData.id);
    if (index != -1) {
      dataPemilih[index] = updatedData;
      update([CommonConstants.kDaftarDataBuilderId]);
    }
  }
  
  Future<void> navigateToDetailData(DataPemilih dataPemilih) async {
    try {
      Get.toNamed(
        Routes.MAIN + Routes.DAFTAR_DATA + Routes.DETAIL_DATA,
        arguments: DetailDataArgs(token, dataPemilih),
      );
    } catch (e) {
      CommonWidget.toast('Failed to navigate to detail data page: $e');
    }
  }

  Future<void> refreshData() async {
    currentPage = 1;
    dataPemilih.clear();
    hasMoreData.value = true;
    await fetchDataPemilih();
  }
}
