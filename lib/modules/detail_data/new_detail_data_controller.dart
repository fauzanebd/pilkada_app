import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pilkada_app/api/api_repository.dart';
import 'package:pilkada_app/models/city.dart';
import 'package:pilkada_app/models/data_pemilih.dart';
import 'package:pilkada_app/models/province.dart';
import 'package:pilkada_app/models/subdistrict.dart';
import 'package:pilkada_app/models/ward.dart';
import 'package:pilkada_app/models/response/meta.dart';
import 'package:pilkada_app/modules/daftar_data/daftar_data_controller.dart';
import 'package:pilkada_app/shared/constants/common.dart';
import 'package:pilkada_app/shared/utils/common_widget.dart';
import 'package:pilkada_app/shared/widgets/location_picker_bottom_sheet.dart';

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

  // Form controllers
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
    initializeData();
    setupScrollListeners();
  }

  void initializeData() {
    dataPemilih = args.dataPemilih;
    s3FileName = dataPemilih!.s3File ?? '';
    token = args.token;

    // Initialize text controllers
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

    // Initialize location controllers
    provinceController.text = dataPemilih!.provinceName ?? 'Pilih Provinsi';
    cityController.text = dataPemilih!.cityName ?? 'Pilih Kota';
    subdistrictController.text =
        dataPemilih!.subdistrictName ?? 'Pilih Kecamatan';
    wardController.text = dataPemilih!.wardName ?? 'Pilih Kelurahan';
    villageController.text = dataPemilih!.villageName ?? '';
  }

  void setupScrollListeners() {
    provincesPickerScrollController.addListener(_provincesPickerScrollListener);
    citiesPickerScrollController.addListener(_citiesPickerScrollListener);
    subdistrictsPickerScrollController
        .addListener(_subdistrictsPickerScrollListener);
    wardsPickerScrollController.addListener(_wardsPickerScrollListener);
  }

  @override
  void onClose() {
    disposeScrollControllers();
    disposeTextControllers();
    _debounce?.cancel();
    super.onClose();
  }

  void disposeScrollControllers() {
    provincesPickerScrollController.dispose();
    citiesPickerScrollController.dispose();
    subdistrictsPickerScrollController.dispose();
    wardsPickerScrollController.dispose();
  }

  void disposeTextControllers() {
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
    provinceController.dispose();
    cityController.dispose();
    subdistrictController.dispose();
    villageController.dispose();
    wardController.dispose();
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
      updateDataPemilih();
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
  }

  void updateDataPemilih() {
    dataPemilih!.name = nameController.text;
    dataPemilih!.nik = nikController.text;
    dataPemilih!.address = addressController.text;
    dataPemilih!.birthDate =
        birthDateController.text.isNotEmpty ? birthDateController.text : null;
    dataPemilih!.gender = genderController.text;
    dataPemilih!.noPhone = noPhoneController.text;
    dataPemilih!.noTps = noTpsController.text;
    dataPemilih!.isPartyMember = isPartyMemberController.text == 'true';
    dataPemilih!.category = categoryController.text;
    dataPemilih!.confirmationStatus = confirmationStatusController.text;
    dataPemilih!.expectationToCandidate = expectationToCandidateController.text;
    dataPemilih!.positioningToCandidate = positioningToCandidateController.text;
    dataPemilih!.relationToCandidate = relationToCandidateController.text;

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
    dataPemilih!.villageName = villageController.text;
  }

  Future<void> _onSearchChanged(String query, Function fetchFunction) async {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      await fetchFunction(query);
      update([CommonConstants.kProvincePickerBuilderId]);
    });
  }

  void showProvincesPicker() async {
    await fetchProvinces('');
    showLocationPicker('Provinsi', provinces, (item) {
      selectedProvince = item;
      provinceController.text = item.name;
      resetLocationFields('province');
      refreshProvinces('', refetch: false);
    }, (query) => _onSearchChanged(query, fetchProvinces));
  }

  void showCitiesPicker() async {
    if (selectedProvince == null) {
      CommonWidget.toast('Silahkan pilih Provinsi terlebih dahulu');
      return;
    }
    await fetchCities('');
    showLocationPicker('Kota', cities, (item) {
      selectedCity = item;
      cityController.text = item.name;
      resetLocationFields('city');
      refreshCities('', refetch: false);
    }, (query) => _onSearchChanged(query, fetchCities));
  }

  void showSubdistrictsPicker() async {
    if (selectedCity == null) {
      CommonWidget.toast('Silahkan pilih Kota terlebih dahulu');
      return;
    }
    await fetchSubdistricts('');
    showLocationPicker('Kecamatan', subdistricts, (item) {
      selectedSubdistrict = item;
      subdistrictController.text = item.name;
      resetLocationFields('subdistrict');
      refreshSubdistricts('', refetch: false);
    }, (query) => _onSearchChanged(query, fetchSubdistricts));
  }

  void showWardsPicker() async {
    if (selectedSubdistrict == null) {
      CommonWidget.toast('Silahkan pilih Kecamatan terlebih dahulu');
      return;
    }
    await fetchWards('');
    showLocationPicker('Kelurahan', wards, (item) {
      selectedWard = item;
      wardController.text = item.name;
      refreshWards('', refetch: false);
    }, (query) => _onSearchChanged(query, fetchWards));
  }

  void showLocationPicker(String title, List<dynamic> items,
      Function(dynamic) onItemSelected, Function(String) onSearchChanged) {
    showModalBottomSheet(
      context: Get.context!,
      builder: (context) => LocationPickerBottomSheet(
        title: title,
        items: items,
        onItemSelected: onItemSelected,
        onSearchChanged: onSearchChanged,
        scrollController: getScrollController(title),
        theresMore: getTheresMore(title),
        isLoading: getIsLoading(title),
      ),
    );
  }

  ScrollController getScrollController(String title) {
    switch (title) {
      case 'Provinsi':
        return provincesPickerScrollController;
      case 'Kota':
        return citiesPickerScrollController;
      case 'Kecamatan':
        return subdistrictsPickerScrollController;
      case 'Kelurahan':
        return wardsPickerScrollController;
      default:
        return ScrollController();
    }
  }

  RxBool getTheresMore(String title) {
    switch (title) {
      case 'Provinsi':
        return theresMoreProvinces;
      case 'Kota':
        return theresMoreCities;
      case 'Kecamatan':
        return theresMoreSubdistricts;
      case 'Kelurahan':
        return theresMoreWards;
      default:
        return RxBool(false);
    }
  }

  RxBool getIsLoading(String title) {
    switch (title) {
      case 'Provinsi':
        return isProvincesLoading;
      case 'Kota':
        return isCitiesLoading;
      case 'Kecamatan':
        return isSubdistrictsLoading;
      case 'Kelurahan':
        return isWardsLoading;
      default:
        return RxBool(false);
    }
  }

  void resetLocationFields(String level) {
    switch (level) {
      case 'province':
        selectedCity = null;
        selectedSubdistrict = null;
        selectedWard = null;
        cityController.text = 'Pilih Kota';
        subdistrictController.text = 'Pilih Kecamatan';
        wardController.text = 'Pilih Kelurahan';
        villageController.text = '';
        break;
      case 'city':
        selectedSubdistrict = null;
        selectedWard = null;
        subdistrictController.text = 'Pilih Kecamatan';
        wardController.text = 'Pilih Kelurahan';
        villageController.text = '';
        break;
      case 'subdistrict':
        selectedWard = null;
        wardController.text = 'Pilih Kelurahan';
        villageController.text = '';
        break;
    }
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
      handleFetchResult(newProvinces, provinces, currentProvincesPage,
          provincesPerPage, theresMoreProvinces, provincesMeta);
      update([CommonConstants.kProvincePickerBuilderId]);
    } catch (e) {
      CommonWidget.toast('Failed to fetch provinces: $e');
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
      handleFetchResult(newCities, cities, currentCitiesPage, citiesPerPage,
          theresMoreCities, citiesMeta);
      update([CommonConstants.kCitiesPickerBuilderId]);
    } catch (e) {
      CommonWidget.toast('Failed to fetch cities: $e');
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
      handleFetchResult(newSubdistricts, subdistricts, currentSubdistrictsPage,
          subdistrictsPerPage, theresMoreSubdistricts, subdistrictsMeta);
      update([CommonConstants.kSubdistrictsPickerBuilderId]);
    } catch (e) {
      CommonWidget.toast('Failed to fetch subdistricts: $e');
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
      handleFetchResult(newWards, wards, currentWardsPage, wardsPerPage,
          theresMoreWards, wardsMeta);
      update([CommonConstants.kWardsPickerBuilderId]);
    } catch (e) {
      CommonWidget.toast('Failed to fetch wards: $e');
    } finally {
      isWardsLoading.value = false;
      update([CommonConstants.kWardsPickerBuilderId]);
    }
  }

  void handleFetchResult(List newItems, List items, int currentPage,
      int perPage, RxBool theresMore, Rx<Meta?> meta) {
    if (newItems.isEmpty) {
      theresMore.value = false;
    } else {
      items.addAll(newItems);
      currentPage++;
      if (meta.value!.total > currentPage * perPage) {
        theresMore.value = true;
      } else {
        theresMore.value = false;
      }
    }
  }
}

class DetailDataArgs {
  final String token;
  final DataPemilih dataPemilih;
  DetailDataArgs(this.token, this.dataPemilih);
}
