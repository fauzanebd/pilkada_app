import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pilkada_app/modules/detail_data/detail_data_controller.dart';
import 'package:pilkada_app/shared/constants/colors.dart';
import 'package:pilkada_app/shared/constants/common.dart';
import 'package:pilkada_app/shared/screens/custom_pop_screen.dart';
import 'package:pilkada_app/shared/widgets/big_primary_button.dart';
import 'package:pilkada_app/shared/widgets/form_boolean_dropdown.dart';
import 'package:pilkada_app/shared/widgets/form_dropdown.dart';
import 'package:pilkada_app/shared/widgets/form_text_field.dart';

class DetailDataScreen extends GetView<DetailDataController> {
  const DetailDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('building data detail screen');
    return CustomPopScreen(
      appBarTitle: 'Detail Data',
      body: Stack(
        children: [
          Form(
            key: controller.detailDataKey,
            child: Padding(
              padding: EdgeInsets.only(
                left: CommonConstants.kDefaultHorizontalPadding.w,
                right: CommonConstants.kDefaultHorizontalPadding.w,
                bottom: 80.h,
              ),
              child: ListView(
                children: [
                  const SizedBox(height: 30),
                  FormTextField(
                    label: 'Nama',
                    textController: controller.nameController,
                  ),
                  FormTextField(
                    label: 'Nomor KTP',
                    textController: controller.nikController,
                  ),
                  FormTextField(
                    label: 'Alamat',
                    textController: controller.addressController,
                  ),
                  FormDatePicker(
                    label: 'Tanggal Lahir',
                    value: controller.dataPemilih!.birthDate,
                    onChanged: ((value) {
                      controller.birthDateController.text = value;
                    }),
                    textController: controller.birthDateController,
                  ),
                  FormDropdown(
                    label: 'Jenis Kelamin',
                    value: controller.dataPemilih!.gender,
                    items: controller.gender,
                    onChanged: (value) =>
                        controller.genderController.text = value,
                  ),
                  FormTextField(
                    label: 'Nomor HP/WA',
                    textController: controller.noPhoneController,
                  ),
                  FormTextField(
                    label: 'Nomor TPS',
                    textController: controller.noTpsController,
                  ),
                  FormBooleanDropdown(
                    label: 'Anggota Parpol',
                    value: controller.dataPemilih!.isPartyMember,
                    onChanged: (value) {
                      controller.isPartyMemberController.text =
                          value.toString();
                    },
                  ),
                  FormDropdown(
                    label: 'Kategori',
                    value: (controller.dataPemilih!.category != null &&
                            controller.dataPemilih!.category!.isNotEmpty)
                        ? controller.dataPemilih!.category!
                        : controller.categoryValues[0],
                    items: controller.categoryValues,
                    onChanged: (value) {
                      controller.categoryController.text = value;
                    },
                  ),
                  FormDropdown(
                    label: 'Posisi terhadap Kandidat',
                    value: (controller.dataPemilih!.positioningToCandidate !=
                                null &&
                            controller.dataPemilih!.positioningToCandidate!
                                .isNotEmpty)
                        ? controller.dataPemilih!.positioningToCandidate!
                        : controller.positioningToCandidateValues[0],
                    items: controller.positioningToCandidateValues,
                    onChanged: (value) {
                      controller.positioningToCandidateController.text = value;
                    },
                  ),
                  FormDropdown(
                    label: 'Status Konfirmasi',
                    value:
                        (controller.dataPemilih!.confirmationStatus != null &&
                                controller.dataPemilih!.confirmationStatus!
                                    .isNotEmpty)
                            ? controller.dataPemilih!.confirmationStatus!
                            : controller.confirmationStatus[0],
                    items: controller.confirmationStatus,
                    onChanged: (value) {
                      controller.confirmationStatusController.text = value;
                    },
                  ),
                  FormTextField(
                    label: 'Hubungan dengan Kandidat',
                    textController: controller.relationToCandidateController,
                  ),
                  // New location fields
                  FormTextField(
                    label: 'Provinsi',
                    textController: controller.provinceController,
                    readonly: true,
                    onTap: () => controller.showProvincesPicker(),
                  ),
                  FormTextField(
                    label: 'Kota',
                    textController: controller.cityController,
                    readonly: true,
                    onTap: () => controller.showCitiesPicker(),
                  ),
                  FormTextField(
                    label: 'Kecamatan',
                    textController: controller.subdistrictController,
                    readonly: true,
                    onTap: () => controller.showSubdistrictsPicker(),
                  ),

                  FormTextField(
                    label: 'Kelurahan',
                    textController: controller.wardController,
                    readonly: true,
                    onTap: () => controller.showWardsPicker(),
                  ),
                  FormTextField(
                    label: 'Desa',
                    textController: controller.villageController,
                  ),
                  const SizedBox(height: 10),
                  // ElevatedButton(
                  //   onPressed: controller.saveData,
                  //   child: const Text('Save Data'),
                  // ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: BigPrimaryButton(
                    'Perbaharui Data',
                    isLoading: false,
                    height: 50.0.h,
                    onTap: controller.updateData,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProvincePickerBottomSheet extends StatelessWidget {
  final String title;
  final Function(dynamic) onItemSelected;
  final void Function(String) onSearchChanged;

  const ProvincePickerBottomSheet({
    super.key,
    required this.title,
    required this.onItemSelected,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailDataController>(
        id: CommonConstants.kProvincePickerBuilderId,
        builder: (controller) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    onChanged: (value) {
                      // Implement search functionality here
                      onSearchChanged(value);
                    },
                  ),
                ),
                Expanded(
                  child: (controller.provinces.isNotEmpty)
                      ? ListView.builder(
                          controller:
                              controller.provincesPickerScrollController,
                          itemCount: controller.provinces.length + 1,
                          itemBuilder: (context, index) {
                            if (index < controller.provinces.length) {
                              final item = controller.provinces[index];
                              return ListTile(
                                title: Text(item.name),
                                onTap: () {
                                  onItemSelected(item);
                                  Navigator.pop(context);
                                },
                              );
                            } else if (controller.theresMoreProvinces.value) {
                              return const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        )
                      : Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Tidak ada Provinsi',
                              style: CommonConstants.kNormalText.copyWith(
                                color: ColorConstants.accentTextColor,
                                fontSize: 20.sp,
                              ),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          );
        });
  }
}

class CitiesPickerBottomSheet extends StatelessWidget {
  final String title;
  final Function(dynamic) onItemSelected;
  final void Function(String) onSearchChanged;

  const CitiesPickerBottomSheet({
    super.key,
    required this.title,
    required this.onItemSelected,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailDataController>(
        id: CommonConstants.kCitiesPickerBuilderId,
        builder: (controller) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    onChanged: (value) {
                      onSearchChanged(value);
                    },
                  ),
                ),
                Expanded(
                  child: (controller.cities.isNotEmpty)
                      ? ListView.builder(
                          controller: controller.citiesPickerScrollController,
                          itemCount: controller.cities.length + 1,
                          itemBuilder: (context, index) {
                            if (index < controller.cities.length) {
                              final item = controller.cities[index];
                              return ListTile(
                                title: Text(item.name),
                                onTap: () {
                                  onItemSelected(item);
                                  Navigator.pop(context);
                                },
                              );
                            } else if (controller.theresMoreCities.value) {
                              return const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        )
                      : Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Tidak ada Kota',
                              style: CommonConstants.kNormalText.copyWith(
                                color: ColorConstants.accentTextColor,
                                fontSize: 20.sp,
                              ),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          );
        });
  }
}

class SubdistrictPickerBottomSheet extends StatelessWidget {
  final String title;
  final Function(dynamic) onItemSelected;
  final void Function(String) onSearchChanged;

  const SubdistrictPickerBottomSheet({
    super.key,
    required this.title,
    required this.onItemSelected,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailDataController>(
        id: CommonConstants.kSubdistrictsPickerBuilderId,
        builder: (controller) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    onChanged: onSearchChanged,
                  ),
                ),
                Expanded(
                  child: (controller.subdistricts.isNotEmpty)
                      ? ListView.builder(
                          controller:
                              controller.subdistrictsPickerScrollController,
                          itemCount: controller.subdistricts.length + 1,
                          itemBuilder: (context, index) {
                            if (index < controller.subdistricts.length) {
                              final item = controller.subdistricts[index];
                              return ListTile(
                                title: Text(item.name),
                                onTap: () {
                                  onItemSelected(item);
                                  Navigator.pop(context);
                                },
                              );
                            } else if (controller
                                .theresMoreSubdistricts.value) {
                              return const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        )
                      : Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Tidak ada Kecamatan',
                              style: CommonConstants.kNormalText.copyWith(
                                color: ColorConstants.accentTextColor,
                                fontSize: 20.sp,
                              ),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          );
        });
  }
}

class WardPickerBottomSheet extends StatelessWidget {
  final String title;
  final Function(dynamic) onItemSelected;
  final void Function(String) onSearchChanged;

  const WardPickerBottomSheet({
    super.key,
    required this.title,
    required this.onItemSelected,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailDataController>(
        id: CommonConstants.kWardsPickerBuilderId,
        builder: (controller) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    onChanged: onSearchChanged,
                  ),
                ),
                Expanded(
                  child: (controller.wards.isNotEmpty)
                      ? ListView.builder(
                          controller: controller.wardsPickerScrollController,
                          itemCount: controller.wards.length + 1,
                          itemBuilder: (context, index) {
                            if (index < controller.wards.length) {
                              final item = controller.wards[index];
                              return ListTile(
                                title: Text(item.name),
                                onTap: () {
                                  onItemSelected(item);
                                  Navigator.pop(context);
                                },
                              );
                            } else if (controller.theresMoreWards.value) {
                              return const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        )
                      : Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Tidak ada Kelurahan',
                              style: CommonConstants.kNormalText.copyWith(
                                color: ColorConstants.accentTextColor,
                                fontSize: 20.sp,
                              ),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          );
        });
  }
}

class FormDatePicker extends StatelessWidget {
  const FormDatePicker({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    required this.textController,
    this.readonly,
  });

  final String label;
  final String? value;
  final TextEditingController textController;
  final Function(String p1) onChanged;
  final bool? readonly;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailDataController>(
        id: CommonConstants.kDatePickerBuilderId,
        builder: (getxController) {
          return GetBuilder<DetailDataController>(
              id: CommonConstants.kDatePickerBuilderId,
              builder: (getxController) {
                return FormTextField(
                  label: label,
                  textController: textController,
                  readonly: true,
                  onTap: () async {
                    DateTime parsedDateTime;
                    try {
                      parsedDateTime = DateTime.parse(value!);
                    } catch (e) {
                      parsedDateTime = DateTime.now();
                    }
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: parsedDateTime,
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) {
                      onChanged(DateFormat('yyyy-MM-dd').format(picked));
                    }
                  },
                );
              });
        });
  }
}
