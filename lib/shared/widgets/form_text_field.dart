import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pilkada_app/shared/constants/colors.dart';

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
