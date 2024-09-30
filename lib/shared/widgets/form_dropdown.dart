import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pilkada_app/shared/constants/colors.dart';

class FormDropdown extends StatelessWidget {
  const FormDropdown({
    super.key,
    required this.label,
    this.value,
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
    return DropdownButtonFormField<String>(
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
    );
  }
}
