import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pilkada_app/modules/data_confirmation/data_confirmation_controller.dart';
import 'package:pilkada_app/shared/constants/colors.dart';
import 'package:pilkada_app/shared/constants/common.dart';
import 'package:pilkada_app/shared/screens/custom_pop_screen.dart';
import 'package:pilkada_app/shared/widgets/big_primary_button.dart';

class DataConfirmationScreen extends GetView<DataConfirmationController> {
  const DataConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('building data confirmation screen');
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
                    label: 'Name',
                    textController: controller.nameController,
                  ),
                  FormTextField(
                    label: 'NIK',
                    textController: controller.nikController,
                  ),
                  FormTextField(
                    label: 'Address',
                    textController: controller.addressController,
                  ),
                  FormDatePicker(
                    label: 'Birth Date',
                    value: controller.dataPemilih.value!.birthDate,
                    onChanged: ((value) {
                      debugPrint('value changed: $value');
                      controller.birthDateController.text = value;
                    }),
                    textController: controller.birthDateController,
                  ),
                  FormDropdown(
                      label: 'Gender',
                      value: controller.dataPemilih.value!.gender,
                      items: const ['L', 'P'],
                      onChanged: (value) =>
                          controller.dataPemilih.value!.gender = value),
                  FormTextField(
                    label: 'Phone Number',
                    textController: controller.noPhoneController,
                  ),
                  FormTextField(
                    label: 'TPS Number',
                    textController: controller.noTpsController,
                  ),
                  FormBooleanDropdown(
                      label: 'Is Party Member',
                      value: controller.dataPemilih.value!.isPartyMember,
                      onChanged: (value) =>
                          controller.dataPemilih.value!.isPartyMember = value),
                  FormTextField(
                    label: 'Category',
                    textController: controller.categoryController,
                  ),
                  FormTextField(
                    label: 'Expectation to Candidate',
                    textController: controller.expectationToCandidateController,
                  ),
                  FormTextField(
                    label: 'Positioning to Candidate',
                    textController: controller.positioningToCandidateController,
                  ),
                  FormTextField(
                    label: 'Relation to Candidate',
                    textController: controller.relationToCandidateController,
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
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: BigPrimaryButton(
                    'Save Data',
                    isLoading: false,
                    height: 50.0.h,
                    onTap: controller.saveData,
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
        id: CommonConstants.kDatePickerBuilder,
        builder: (getxController) {
          return GetBuilder<DataConfirmationController>(
              id: CommonConstants.kDatePickerBuilder,
              builder: (getxController) {
                return FormTextField(
                  label: 'Date of Birth',
                  textController: textController,
                  readonly: true,
                  onTap: () async {
                    debugPrint('tapped');
                    final DateTime? picked = await showDatePicker(
                      context: Get.context!,
                      initialDate: value != null
                          ? DateTime.parse(value!)
                          : DateTime.now(),
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

class FormBooleanDropdown extends StatelessWidget {
  const FormBooleanDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool? value;
  final Function(bool p1) onChanged;

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(Get.context!).size.shortestSide;
    final bool isMobile = shortestSide < 650;
    double fontSize = 14.0.sp;
    return DropdownButtonFormField<bool>(
      dropdownColor: ColorConstants.white,
      value: value,
      decoration: InputDecoration(
        labelText: label,
        hintStyle: TextStyle(
          color: ColorConstants.black.withOpacity(0.4),
          fontSize: fontSize,
          fontWeight: FontWeight.normal,
        ),
        labelStyle: TextStyle(
          color: ColorConstants.accentTextColor,
          fontSize: fontSize,
          fontWeight: FontWeight.normal,
        ),
        fillColor: Colors.white,
        isDense: true,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0.r),
          borderSide: BorderSide(
            color: ColorConstants.inactiveLight,
            width: 2.0.sp,
            style: BorderStyle.solid,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0.r),
          borderSide: BorderSide(
            color: ColorConstants.inactiveLight,
            width: 2.0.sp,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0.r),
          borderSide: BorderSide(
            color: ColorConstants.primaryAccentColor,
            width: 2.0.sp,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0.r),
          borderSide: const BorderSide(
            color: ColorConstants.red,
          ),
        ),
        errorStyle: TextStyle(
          color: ColorConstants.red,
          fontSize: fontSize - (isMobile ? 4.0 : 8.0),
          fontWeight: FontWeight.normal,
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        constraints: BoxConstraints(
          minHeight: 60.h,
        ),
      ),
      items: const [
        DropdownMenuItem<bool>(value: true, child: Text('Yes')),
        DropdownMenuItem<bool>(value: false, child: Text('No')),
      ],
      onChanged: (bool? newValue) {
        if (newValue != null) {
          onChanged(newValue);
        }
      },
    );
  }
}

class FormDropdown extends StatelessWidget {
  const FormDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String label;
  final String? value;
  final List<String> items;
  final Function(String p1) onChanged;

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(Get.context!).size.shortestSide;
    final bool isMobile = shortestSide < 650;
    double fontSize = 14.0.sp;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField<String>(
        dropdownColor: ColorConstants.white,
        value: value,
        decoration: InputDecoration(
          labelText: label,
          hintStyle: TextStyle(
            color: ColorConstants.black.withOpacity(0.4),
            fontSize: fontSize,
            fontWeight: FontWeight.normal,
          ),
          labelStyle: TextStyle(
            color: ColorConstants.accentTextColor,
            fontSize: fontSize,
            fontWeight: FontWeight.normal,
          ),
          fillColor: Colors.white,
          isDense: true,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0.r),
            borderSide: BorderSide(
              color: ColorConstants.inactiveLight,
              width: 2.0.sp,
              style: BorderStyle.solid,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0.r),
            borderSide: BorderSide(
              color: ColorConstants.inactiveLight,
              width: 2.0.sp,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0.r),
            borderSide: BorderSide(
              color: ColorConstants.primaryAccentColor,
              width: 2.0.sp,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0.r),
            borderSide: const BorderSide(
              color: ColorConstants.red,
            ),
          ),
          errorStyle: TextStyle(
            color: ColorConstants.red,
            fontSize: fontSize - (isMobile ? 4.0 : 8.0),
            fontWeight: FontWeight.normal,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          constraints: BoxConstraints(
            minHeight: 60.h,
          ),
        ),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            onChanged(newValue);
          }
        },
      ),
    );
  }
}

class FormTextField extends StatelessWidget {
  const FormTextField({
    super.key,
    required this.label,
    required this.textController,
    this.readonly,
    this.onTap,
  });

  final String label;
  final TextEditingController textController;
  final bool? readonly;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(Get.context!).size.shortestSide;
    final bool isMobile = shortestSide < 650;
    double fontSize = 14.0.sp;
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: TextFormField(
        onTap: onTap,
        readOnly: readonly ?? false,
        controller: textController,
        style: TextStyle(
          color: ColorConstants.mainTextColor,
          fontSize: fontSize,
          fontWeight: FontWeight.normal,
        ),
        decoration: InputDecoration(
          labelText: label,
          hintStyle: TextStyle(
            color: ColorConstants.black.withOpacity(0.4),
            fontSize: fontSize,
            fontWeight: FontWeight.normal,
          ),
          labelStyle: TextStyle(
            color: ColorConstants.accentTextColor,
            fontSize: fontSize,
            fontWeight: FontWeight.normal,
          ),
          fillColor: Colors.white,
          isDense: true,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0.r),
            borderSide: BorderSide(
              color: ColorConstants.inactiveLight,
              width: 2.0.sp,
              style: BorderStyle.solid,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0.r),
            borderSide: BorderSide(
              color: ColorConstants.inactiveLight,
              width: 2.0.sp,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0.r),
            borderSide: BorderSide(
              color: ColorConstants.primaryAccentColor,
              width: 2.0.sp,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0.r),
            borderSide: const BorderSide(
              color: ColorConstants.red,
            ),
          ),
          errorStyle: TextStyle(
            color: ColorConstants.red,
            fontSize: fontSize - (isMobile ? 4.0 : 8.0),
            fontWeight: FontWeight.normal,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          constraints: BoxConstraints(
            minHeight: 60.h,
          ),
        ),
      ),
    );
  }
}
