import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pilkada_app/api/api_repository.dart';
import 'package:pilkada_app/models/data_pemilih.dart';
import 'package:pilkada_app/models/response/meta.dart';
import 'package:pilkada_app/modules/detail_data/detail_data_controller.dart';
import 'package:pilkada_app/routes/app_pages.dart';
import 'package:pilkada_app/shared/constants/common.dart';
import 'package:pilkada_app/shared/utils/common_widget.dart';
import 'dart:async';

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

  static const int searchBarAnimationDuration = 150;

  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  Timer? _debounce;
  RxString searchQuery = ''.obs;
  RxBool isSearchBarVisible = true.obs;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_scrollListener);
    searchController.addListener(_onSearchChanged);
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
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    searchFocusNode.dispose();
    _debounce?.cancel();
    super.onClose();
  }

  void _scrollListener() {
    if (scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (isSearchBarVisible.value) {
        isSearchBarVisible.value = false;
      }
    } else if (scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (!isSearchBarVisible.value) {
        isSearchBarVisible.value = true;
      }
    }

    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (!isLoading.value && hasMoreData.value) {
        fetchDataPemilih();
      }
    }
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      searchQuery.value = searchController.text;
      refreshData();
    });
  }

  Future<void> fetchDataPemilih() async {
    if (isLoading.value) return;

    isLoading.value = true;
    update([CommonConstants.kDaftarDataBuilderId]);

    try {
      final newData = await apiRepository
          .fetchDaftarDataPemilih(
        token,
        itemsPerPage,
        currentPage,
        query: searchQuery.value,
      )
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

  Future<void> navigateToDetailData(int index) async {
    try {
      Get.toNamed(
        Routes.MAIN + Routes.DAFTAR_DATA + Routes.DETAIL_DATA,
        arguments: DetailDataArgs(token, dataPemilih[index]),
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
