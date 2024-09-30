import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pilkada_app/shared/constants/colors.dart';
import 'package:pilkada_app/shared/constants/common.dart';
import 'package:pilkada_app/shared/widgets/input_field_with_no_label.dart';

class InputFieldWithTopLeftLabel extends StatelessWidget {
  const InputFieldWithTopLeftLabel({
    super.key,
    this.isObscure = false,
    required this.textEditingController,
    required this.labelText,
    this.validator,
    this.placeHolder,
    this.onChanged,
    this.onPasswordEyePressed,
    this.password = false,
    this.readOnly = false,
    this.onFieldTap,
  });

  final bool isObscure;
  final bool password;
  final TextEditingController textEditingController;
  final String labelText;
  final String? placeHolder;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onPasswordEyePressed;
  final void Function()? onFieldTap;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              labelText,
              style: CommonConstants.kNormalText.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: ColorConstants.accentTextColor,
              ),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        InputFieldWithNoLabel(
          isObscure: isObscure,
          textEditingController: textEditingController,
          keyboardType: TextInputType.text,
          placeholder: placeHolder ?? '',
          fontSize: 14.sp,
          validator: validator,
          password: password,
          onChanged: onChanged,
          onPasswordEyePressed: onPasswordEyePressed,
          readOnly: readOnly,
          onFieldTap: onFieldTap,
        ),
      ],
    );
  }
}
