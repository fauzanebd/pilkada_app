import 'dart:async';

import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pilkada_app/api/api_repository.dart';
import 'package:pilkada_app/models/data_pemilih.dart';
import 'package:pilkada_app/models/potential_dpt.dart';
import 'package:pilkada_app/models/response/meta.dart';
import 'package:pilkada_app/shared/constants/common.dart';
import 'package:pilkada_app/shared/utils/common_widget.dart';

class DPTController extends GetxController {
  final ApiRepository apiRepository;
  DPTController({required this.apiRepository});
  
  String token = Get.arguments as String;
  RxList<PotentialDpt> DPT = RxList<PotentialDpt>();
  RxBool isLoading = false.obs;
  Rx<Meta?> DPTMeta = Rx<Meta?>(null);
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
    await fetchDPT();
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
        fetchDPT();
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

  Future<void> fetchDPT() async {
    if (isLoading.value) return;

    isLoading.value = true;
    update([CommonConstants.kDPTBuilderId]);

    try {
      final newData = await apiRepository
          .getDPT(token, itemsPerPage, currentPage,
              query: searchQuery.value)
          .then((value) {
        DPTMeta.value = value.meta;
        return value.data;
      });
      if (newData.isEmpty) {
        hasMoreData.value = false;
      } else {
        DPT.addAll(newData);
        currentPage++;
        if (DPTMeta.value!.total > currentPage * itemsPerPage) {
          hasMoreData.value = true;
        } else {
          hasMoreData.value = false;
        }
      }
    } catch (e) {
      CommonWidget.errorSnackbar(
          Get.context!, 'Gagal mengambil data dpt: $e');
    } finally {
      isLoading.value = false;
      update([CommonConstants.kDPTBuilderId]);
    }
  }

  Future<void> navigateToDetailData(DataPemilih dataPemilih) async {
    try {

    } catch (e) {
      CommonWidget.errorSnackbar(
          Get.context!, 'Failed to navigate to detail data page: $e');
    }
  }

  Future<void> refreshData() async {
    currentPage = 1;
    DPT.clear();
    hasMoreData.value = true;
    await fetchDPT();
  }
}
