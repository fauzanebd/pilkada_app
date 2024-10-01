import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pilkada_app/models/response/dpt_check_response.dart';
import 'package:pilkada_app/modules/data_confirmation/data_confirmation_controller.dart';
import 'package:pilkada_app/shared/constants/colors.dart';
import 'package:pilkada_app/shared/constants/common.dart';
import 'package:pilkada_app/shared/screens/custom_pop_screen.dart';
import 'package:pilkada_app/shared/utils/common_widget.dart';
import 'package:pilkada_app/shared/widgets/big_primary_button.dart';
import 'package:pilkada_app/shared/widgets/form_boolean_dropdown.dart';
import 'package:pilkada_app/shared/widgets/form_dropdown.dart';
import 'package:pilkada_app/shared/widgets/form_text_field.dart';

class DataConfirmationScreen extends GetView<DataConfirmationController> {
  const DataConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPopScreen(
      appBarTitle: 'Confirm Data',
      body: Stack(
        children: [
          Form(
            key: controller.dataConfirmationFormKey,
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
                  FormTextField(
                    label: 'Nomor TPS',
                    textController: controller.noTpsController,
                  ),
                  const SizedBox(height: 10),
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
                    'Cek DPT',
                    isLoading: false,
                    height: 50.0.h,
                    // onTap: controller.saveData,
                    onTap: () async {
                      final res = await controller.checkDPT();
                      if (res != null) {
                        showDPTConfirmation(context, controller, res);
                      } else {
                        CommonWidget.errorSnackbar(
                            Get.context!, 'Gagal cek DPT');
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showDPTConfirmation(
    BuildContext context,
    DataConfirmationController controller,
    DPTCheckResponse dptCheckRes,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorConstants.appScaffoldBackgroundColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Konfirmasi DPT',
                style: CommonConstants.kNormalText.copyWith(
                  color: ColorConstants.accentTextColor,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: SizedBox(
                  child: Icon(
                    CupertinoIcons.xmark,
                    size: 20.sp,
                    color: ColorConstants.primaryAccentColor,
                  ),
                ),
              ),
            ],
          ),
          content: Text(
            dptCheckRes.isValidDpt
                ? 'Data ${controller.nameController.text} valid terdaftar di DPT'
                : 'Data ${controller.nameController.text} tidak valid terdaftar di DPT.\nTetap simpan data?',
            style: CommonConstants.kNormalText.copyWith(
              color: ColorConstants.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: ColorConstants.red),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Batal simpan data',
                style: TextStyle(
                  color: ColorConstants.white,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.primaryAccentColor),
              onPressed: () {
                controller.saveData();
                Navigator.of(context).pop();
              },
              child: Text(
                dptCheckRes.isValidDpt
                    ? 'Lanjut simpan data'
                    : 'Ya, tetap simpan data',
                style: TextStyle(
                  color: ColorConstants.white,
                ),
              ),
            ),
          ],
        );
      },
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
    return GetBuilder<DataConfirmationController>(
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
    return GetBuilder<DataConfirmationController>(
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
    return GetBuilder<DataConfirmationController>(
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
                          } else if (controller.theresMoreSubdistricts.value) {
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
      },
    );
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
    return GetBuilder<DataConfirmationController>(
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
    return GetBuilder<DataConfirmationController>(
        id: CommonConstants.kDatePickerBuilderId,
        builder: (getxController) {
          return GetBuilder<DataConfirmationController>(
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
