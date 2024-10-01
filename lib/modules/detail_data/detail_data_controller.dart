import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pilkada_app/api/api_repository.dart';
import 'package:pilkada_app/models/city.dart';
import 'package:pilkada_app/models/data_pemilih.dart';
import 'package:pilkada_app/models/province.dart';
import 'package:pilkada_app/models/response/meta.dart';
import 'package:pilkada_app/models/subdistrict.dart';
import 'package:pilkada_app/models/ward.dart';
import 'package:pilkada_app/modules/daftar_data/daftar_data_controller.dart';
import 'package:pilkada_app/modules/detail_data/detail_data_screen.dart';
import 'package:pilkada_app/shared/constants/common.dart';
import 'package:pilkada_app/shared/utils/common_widget.dart';

class DetailDataController extends GetxController {
  final ApiRepository apiRepository;
  DetailDataController({required this.apiRepository});

  DetailDataArgs args = Get.arguments as DetailDataArgs;

  DataPemilih? dataPemilih;

  String? token;
  late String s3FileName;

  RxBool isLoading = false.obs;

  // Province
  List<Province> provinces = [];
  RxBool isProvincesLoading = false.obs;
  RxBool theresMoreProvinces = false.obs;
  int currentProvincesPage = 1;
  static const int provincesPerPage = 10;
  Province? selectedProvince;
  final ScrollController provincesPickerScrollController = ScrollController();
  Rx<Meta?> provincesMeta = Rx<Meta?>(null);
  String provincesSearchQuery = '';

  // City
  List<City> cities = [];
  RxBool isCitiesLoading = false.obs;
  RxBool theresMoreCities = false.obs;
  int currentCitiesPage = 1;
  static const int citiesPerPage = 10;
  City? selectedCity;
  final ScrollController citiesPickerScrollController = ScrollController();
  Rx<Meta?> citiesMeta = Rx<Meta?>(null);
  String citiesSearchQuery = '';

  // Subdistrict
  List<Subdistrict> subdistricts = [];
  RxBool isSubdistrictsLoading = false.obs;
  RxBool theresMoreSubdistricts = false.obs;
  int currentSubdistrictsPage = 1;
  static const int subdistrictsPerPage = 10;
  Subdistrict? selectedSubdistrict;
  final ScrollController subdistrictsPickerScrollController =
      ScrollController();
  Rx<Meta?> subdistrictsMeta = Rx<Meta?>(null);
  String subdistrictsSearchQuery = '';

  // Ward
  List<Ward> wards = [];
  RxBool isWardsLoading = false.obs;
  RxBool theresMoreWards = false.obs;
  int currentWardsPage = 1;
  static const int wardsPerPage = 10;
  Ward? selectedWard;
  final ScrollController wardsPickerScrollController = ScrollController();
  Rx<Meta?> wardsMeta = Rx<Meta?>(null);
  String wardsSearchQuery = '';

  Timer? _debounce;

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
  final provinceController = TextEditingController();
  final cityController = TextEditingController();
  final subdistrictController = TextEditingController();
  final villageController = TextEditingController();
  final wardController = TextEditingController();

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

    // locations
    if (dataPemilih!.provinceCode != null) {
      selectedProvince = Province(
        code: dataPemilih!.provinceCode!,
        name: dataPemilih!.provinceName!,
      );
    }
    provinceController.text = dataPemilih!.provinceName ?? 'Pilih Provinsi';
    if (dataPemilih!.cityCode != null) {
      selectedCity = City(
        code: dataPemilih!.cityCode!,
        name: dataPemilih!.cityName!,
        provinceCode: dataPemilih!.provinceCode!,
      );
    }
    cityController.text = dataPemilih!.cityName ?? 'Pilih Kota';
    if (dataPemilih!.subdistrictCode != null) {
      selectedSubdistrict = Subdistrict(
        cityCode: dataPemilih!.cityCode!,
        code: dataPemilih!.subdistrictCode!,
        name: dataPemilih!.subdistrictName!,
      );
    }
    subdistrictController.text =
        dataPemilih!.subdistrictName ?? 'Pilih Kecamatan';
    if (dataPemilih!.wardCode != null) {
      selectedWard = Ward(
        code: dataPemilih!.wardCode!,
        name: dataPemilih!.wardName ?? '',
        subdistrictCode: dataPemilih!.subdistrictCode!,
      );
    }
    wardController.text = dataPemilih!.wardName ?? 'Pilih Kelurahan';

    provincesPickerScrollController.addListener(_provincesPickerScrollListener);
    citiesPickerScrollController.addListener(_citiesPickerScrollListener);
    subdistrictsPickerScrollController
        .addListener(_subdistrictsPickerScrollListener);
    wardsPickerScrollController.addListener(_wardsPickerScrollListener);
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

    //provinces dispose
    provincesPickerScrollController
        .removeListener(_provincesPickerScrollListener);
    provincesPickerScrollController.dispose();

    //cities dispose
    citiesPickerScrollController.removeListener(_citiesPickerScrollListener);
    citiesPickerScrollController.dispose();

    // subdistricts dispose
    subdistrictsPickerScrollController
        .removeListener(_subdistrictsPickerScrollListener);
    subdistrictsPickerScrollController.dispose();

    // wards dispose
    wardsPickerScrollController.removeListener(_wardsPickerScrollListener);
    wardsPickerScrollController.dispose();

    _debounce?.cancel();
  }

  void _provincesPickerScrollListener() {
    if (provincesPickerScrollController.position.pixels ==
        provincesPickerScrollController.position.maxScrollExtent) {
      if (!isProvincesLoading.value && theresMoreProvinces.value) {
        fetchProvinces(provincesSearchQuery);
      }
    }
  }

  void _citiesPickerScrollListener() {
    if (citiesPickerScrollController.position.pixels ==
        citiesPickerScrollController.position.maxScrollExtent) {
      if (!isCitiesLoading.value && theresMoreCities.value) {
        fetchCities(citiesSearchQuery);
      }
    }
  }

  void _subdistrictsPickerScrollListener() {
    if (subdistrictsPickerScrollController.position.pixels ==
        subdistrictsPickerScrollController.position.maxScrollExtent) {
      if (!isSubdistrictsLoading.value && theresMoreSubdistricts.value) {
        fetchSubdistricts(subdistrictsSearchQuery);
      }
    }
  }

  void _wardsPickerScrollListener() {
    if (wardsPickerScrollController.position.pixels ==
        wardsPickerScrollController.position.maxScrollExtent) {
      if (!isWardsLoading.value && theresMoreWards.value) {
        fetchWards(wardsSearchQuery);
      }
    }
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

      dataPemilih!.villageCode = villageController.text;

      if (selectedProvince != null) {
        dataPemilih!.provinceCode = selectedProvince!.code;
        dataPemilih!.provinceName = selectedProvince!.name;
      }

      if (selectedCity != null) {
        dataPemilih!.cityCode = selectedCity!.code;
        dataPemilih!.cityName = selectedCity!.name;
      }

      if (selectedSubdistrict != null) {
        dataPemilih!.subdistrictCode = selectedSubdistrict!.code;
        dataPemilih!.subdistrictName = selectedSubdistrict!.name;
      }

      if (selectedWard != null) {
        dataPemilih!.wardCode = selectedWard!.code;
        dataPemilih!.wardName = selectedWard!.name;
      }

      EasyLoading.show(status: 'Updating data...');
      res = await apiRepository.updateData(dataPemilih!, token!);
      isLoading.value = false;
      if (res != null) {
        Get.find<DaftarDataController>().updateDataItem(dataPemilih!);
        CommonWidget.snackbar(Get.context!, 'Data berhasil diperbaharui');
        EasyLoading.dismiss();
        Get.back();
      }
    } catch (e) {
      EasyLoading.dismiss();
      isLoading.value = false;
      CommonWidget.snackbar(Get.context!,
          'Gagal memperbaharui data. Silahkan coba lagi beberapa saat.');
      Get.back();
    }
  }

  Future<void> _onProvinceSearchChanged(String query) async {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      provincesSearchQuery = query;
      await refreshProvinces(query);
      update([CommonConstants.kProvincePickerBuilderId]);
    });
  }

  Future<void> _onCitySearchChanged(String query) async {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      citiesSearchQuery = query;
      await refreshCities(query);
      update([CommonConstants.kCitiesPickerBuilderId]);
    });
  }

  Future<void> _onSubdistrictSearchChanged(String query) async {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      subdistrictsSearchQuery = query;
      await refreshSubdistricts(query);
      update([CommonConstants.kSubdistrictsPickerBuilderId]);
    });
  }

  Future<void> _onWardSearchChanged(String query) async {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      wardsSearchQuery = query;
      await refreshWards(query);
      update([CommonConstants.kWardsPickerBuilderId]);
    });
  }

  void showProvincesPicker() async {
    await fetchProvinces('');
    showModalBottomSheet(
      context: Get.context!,
      builder: (context) => ProvincePickerBottomSheet(
        title: 'Provinsi',
        onItemSelected: (item) {
          selectedProvince = item;
          provinceController.text = item.name;
          refreshProvinces('', refetch: false);
          // Clear city, subdistrict, and ward when province is changed
          selectedCity = null;
          selectedSubdistrict = null;
          selectedWard = null;
          cityController.text = 'Pilih Kota';
          subdistrictController.text = 'Pilih Kecamatan';
          wardController.text = 'Pilih Kelurahan';
        },
        onSearchChanged: _onProvinceSearchChanged,
      ),
    );
  }

  void showCitiesPicker() async {
    if (selectedProvince == null) {
      CommonWidget.errorSnackbar(
          Get.context!, 'Silahkan pilih Provinsi terlebih dahulu');
      return;
    }
    await fetchCities('');
    showModalBottomSheet(
      context: Get.context!,
      builder: (context) => CitiesPickerBottomSheet(
        title: 'Kota',
        onItemSelected: (item) {
          selectedCity = item;
          cityController.text = item.name;
          refreshCities('', refetch: false);
          // Clear subdistrict and ward when city is changed
          selectedSubdistrict = null;
          selectedWard = null;
          subdistrictController.text = 'Pilih Kecamatan';
          wardController.text = 'Pilih Kelurahan';
        },
        onSearchChanged: _onCitySearchChanged,
      ),
    );
  }

  void showSubdistrictsPicker() async {
    if (selectedCity == null) {
      CommonWidget.errorSnackbar(
          Get.context!, 'Silahkan pilih Kota terlebih dahulu');
      return;
    }
    await fetchSubdistricts('');
    showModalBottomSheet(
      context: Get.context!,
      builder: (context) => SubdistrictPickerBottomSheet(
        title: 'Kecamatan',
        onItemSelected: (item) {
          selectedSubdistrict = item;
          subdistrictController.text = item.name;
          refreshSubdistricts('', refetch: false);
          // Clear ward when subdistrict is changed
          selectedWard = null;
          wardController.text = 'Pilih Kelurahan';
        },
        onSearchChanged: _onSubdistrictSearchChanged,
      ),
    );
  }

  void showWardsPicker() async {
    if (selectedSubdistrict == null) {
      CommonWidget.errorSnackbar(
          Get.context!, 'Silahkan pilih Kecamatan terlebih dahulu');
      return;
    }
    await fetchWards('');
    showModalBottomSheet(
      context: Get.context!,
      builder: (context) => WardPickerBottomSheet(
        title: 'Kelurahan',
        onItemSelected: (item) {
          selectedWard = item;
          wardController.text = item.name;
          refreshWards('', refetch: false);
        },
        onSearchChanged: _onWardSearchChanged,
      ),
    );
  }

  Future<void> refreshProvinces(String query, {bool refetch = true}) async {
    currentProvincesPage = 1;
    provinces.clear();
    provincesMeta.value = null;
    theresMoreProvinces.value = true;
    if (refetch) {
      await fetchProvinces(query);
    } else {
      provincesSearchQuery = '';
      _debounce?.cancel();
    }
  }

  Future<void> refreshCities(String query, {bool refetch = true}) async {
    currentCitiesPage = 1;
    cities.clear();
    citiesMeta.value = null;
    theresMoreCities.value = true;
    if (refetch) {
      await fetchCities(query);
    } else {
      citiesSearchQuery = '';
      _debounce?.cancel();
    }
  }

  Future<void> refreshSubdistricts(String query, {bool refetch = true}) async {
    currentSubdistrictsPage = 1;
    subdistricts.clear();
    subdistrictsMeta.value = null;
    theresMoreSubdistricts.value = true;
    if (refetch) {
      await fetchSubdistricts(query);
    } else {
      subdistrictsSearchQuery = '';
      _debounce?.cancel();
    }
  }

  Future<void> refreshWards(String query, {bool refetch = true}) async {
    currentWardsPage = 1;
    wards.clear();
    wardsMeta.value = null;
    theresMoreWards.value = true;
    if (refetch) {
      await fetchWards(query);
    } else {
      wardsSearchQuery = '';
      _debounce?.cancel();
    }
  }

  Future<void> fetchProvinces(String query) async {
    if (isProvincesLoading.value) return;

    isProvincesLoading.value = true;
    update([CommonConstants.kProvincePickerBuilderId]);

    try {
      final newProvinces = await apiRepository
          .fetchProvinces(
        token!,
        provincesPerPage,
        currentProvincesPage,
        query: query,
        clientCode: dotenv.get('CLIENT_CODE'),
      )
          .then((value) {
        provincesMeta.value = value.meta;
        return value.data;
      });
      if (newProvinces.isEmpty) {
        theresMoreProvinces.value = false;
      } else {
        provinces.addAll(newProvinces);
        currentProvincesPage++;
        if (provincesMeta.value!.total >
            currentProvincesPage * provincesPerPage) {
          theresMoreProvinces.value = true;
        } else {
          theresMoreProvinces.value = false;
        }
      }
      update([CommonConstants.kProvincePickerBuilderId]);
    } catch (e) {
      CommonWidget.errorSnackbar(Get.context!, 'Failed to fetch provinces: $e');
    } finally {
      isProvincesLoading.value = false;
      update([CommonConstants.kProvincePickerBuilderId]);
    }
  }

  Future<void> fetchCities(String query) async {
    if (isCitiesLoading.value) return;

    isCitiesLoading.value = true;
    update([CommonConstants.kCitiesPickerBuilderId]);

    try {
      final newCities = await apiRepository
          .fetchCities(
        token!,
        citiesPerPage,
        currentCitiesPage,
        selectedProvince!.code,
        query: query,
        clientCode: dotenv.get('CLIENT_CODE'),
      )
          .then((value) {
        citiesMeta.value = value.meta;
        return value.data;
      });
      if (newCities.isEmpty) {
        theresMoreCities.value = false;
      } else {
        cities.addAll(newCities);
        currentCitiesPage++;
        if (citiesMeta.value!.total > currentCitiesPage * citiesPerPage) {
          theresMoreCities.value = true;
        } else {
          theresMoreCities.value = false;
        }
      }
      update([CommonConstants.kCitiesPickerBuilderId]);
    } catch (e) {
      CommonWidget.errorSnackbar(Get.context!, 'Failed to fetch cities: $e');
    } finally {
      isCitiesLoading.value = false;
      update([CommonConstants.kCitiesPickerBuilderId]);
    }
  }

  Future<void> fetchSubdistricts(String query) async {
    if (isSubdistrictsLoading.value) return;

    isSubdistrictsLoading.value = true;
    update([CommonConstants.kSubdistrictsPickerBuilderId]);

    try {
      final newSubdistricts = await apiRepository
          .fetchSubdistricts(
        token!,
        subdistrictsPerPage,
        currentSubdistrictsPage,
        selectedCity!.code,
        query: query,
        clientCode: dotenv.get('CLIENT_CODE'),
      )
          .then((value) {
        subdistrictsMeta.value = value.meta;
        return value.data;
      });
      if (newSubdistricts.isEmpty) {
        theresMoreSubdistricts.value = false;
      } else {
        subdistricts.addAll(newSubdistricts);
        currentSubdistrictsPage++;
        if (subdistrictsMeta.value!.total >
            currentSubdistrictsPage * subdistrictsPerPage) {
          theresMoreSubdistricts.value = true;
        } else {
          theresMoreSubdistricts.value = false;
        }
      }
      update([CommonConstants.kSubdistrictsPickerBuilderId]);
    } catch (e) {
      CommonWidget.errorSnackbar(
          Get.context!, 'Failed to fetch subdistricts: $e');
    } finally {
      isSubdistrictsLoading.value = false;
      update([CommonConstants.kSubdistrictsPickerBuilderId]);
    }
  }

  Future<void> fetchWards(String query) async {
    if (isWardsLoading.value) return;

    isWardsLoading.value = true;
    update([CommonConstants.kWardsPickerBuilderId]);

    try {
      final newWards = await apiRepository
          .fetchWards(
        token!,
        wardsPerPage,
        currentWardsPage,
        selectedSubdistrict!.code,
        query: query,
        clientCode: dotenv.get('CLIENT_CODE'),
      )
          .then((value) {
        wardsMeta.value = value.meta;
        return value.data;
      });
      if (newWards.isEmpty) {
        theresMoreWards.value = false;
      } else {
        wards.addAll(newWards);
        currentWardsPage++;
        if (wardsMeta.value!.total > currentWardsPage * wardsPerPage) {
          theresMoreWards.value = true;
        } else {
          theresMoreWards.value = false;
        }
      }
      update([CommonConstants.kWardsPickerBuilderId]);
    } catch (e) {
      CommonWidget.errorSnackbar(Get.context!, 'Failed to fetch wards: $e');
    } finally {
      isWardsLoading.value = false;
      update([CommonConstants.kWardsPickerBuilderId]);
    }
  }
}

class DetailDataArgs {
  final String token;
  final DataPemilih dataPemilih;
  DetailDataArgs(this.token, this.dataPemilih);
}
