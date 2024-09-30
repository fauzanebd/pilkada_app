import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pilkada_app/shared/constants/colors.dart';

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
        DropdownMenuItem<bool>(value: true, child: Text('Ya')),
        DropdownMenuItem<bool>(value: false, child: Text('Tidak')),
      ],
      onChanged: (bool? newValue) {
        if (newValue != null) {
          onChanged(newValue);
        }
      },
    );
  }
}
