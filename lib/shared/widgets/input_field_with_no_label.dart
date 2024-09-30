import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pilkada_app/shared/constants/colors.dart';

class InputFieldWithNoLabel extends StatelessWidget {
  final bool isObscure;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final String placeholder;
  final Color inputTextColor;
  final double fontSize;
  final bool password;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onPasswordEyePressed;
  final bool readOnly;
  final void Function()? onFieldTap;

  const InputFieldWithNoLabel({
    super.key,
    required this.isObscure,
    required this.textEditingController,
    this.keyboardType = TextInputType.text,
    this.placeholder = '',
    this.inputTextColor = ColorConstants.mainTextColor,
    this.fontSize = 22.0,
    this.password = false,
    this.validator,
    this.onChanged,
    this.onPasswordEyePressed,
    this.readOnly = false,
    this.onFieldTap,
  });

  @override
  Widget build(BuildContext context) {
    return _buildFormField();
    // }
  }

  TextFormField _buildFormField() {
    return TextFormField(
      onTap: onFieldTap,
      readOnly: readOnly,
      decoration: InputDecoration(
        errorStyle: TextStyle(
          color: ColorConstants.primaryAccentColor,
          fontSize: 12.sp,
        ),
        fillColor: ColorConstants.appScaffoldBackgroundColor,
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
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0.r),
          borderSide: const BorderSide(
            color: ColorConstants.primaryAccentColor,
          ),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        constraints: BoxConstraints(
          minHeight: 60.h,
        ),
        suffixIcon: password
            ? IconButton(
                icon: const Icon(
                  Icons.remove_red_eye,
                  color: ColorConstants.primaryAccentColor,
                ),
                onPressed: onPasswordEyePressed,
              )
            : null,
      ),
      controller: textEditingController,
      style: TextStyle(
        color: inputTextColor,
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
      ),
      keyboardType: keyboardType,
      obscureText: isObscure,
      autocorrect: false,
      validator: validator,
      onChanged: onChanged,
    );
  }
}
