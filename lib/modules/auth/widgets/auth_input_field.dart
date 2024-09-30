import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pilkada_app/shared/constants/colors.dart';
import 'package:get/get.dart';

class AuthInputFieldWithNoLabel extends StatelessWidget {
  final bool isObscure;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final String placeholder;
  final Color inputTextColor;
  final double fontSize;
  final bool password;
  final bool readOnly;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onPasswordEyePressed;
  final void Function()? onTap;
  final String? hintText;

  const AuthInputFieldWithNoLabel({
    super.key,
    required this.isObscure,
    required this.textEditingController,
    this.keyboardType = TextInputType.text,
    this.placeholder = '',
    this.inputTextColor = Colors.black,
    this.fontSize = 22.0,
    this.password = false,
    this.validator,
    this.onChanged,
    this.onPasswordEyePressed,
    this.readOnly = false,
    this.onTap,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return _buildFormField();
  }

  TextFormField _buildFormField() {
    var shortestSide = MediaQuery.of(Get.context!).size.shortestSide;
    final bool isMobile = shortestSide < 650;

    return TextFormField(
      readOnly: readOnly,
      onTap: onTap,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: ColorConstants.black.withOpacity(0.4),
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
        suffixIcon: password
            ? InkWell(
                splashFactory: NoSplash.splashFactory,
                child: const Icon(
                  Icons.remove_red_eye,
                  color: ColorConstants.primaryAccentColor,
                ),
                onTap: onPasswordEyePressed,
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

class AuthInputFieldWithNoLabelHorizontal extends StatelessWidget {
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

  const AuthInputFieldWithNoLabelHorizontal({
    super.key,
    required this.isObscure,
    required this.textEditingController,
    this.keyboardType = TextInputType.text,
    this.placeholder = '',
    this.inputTextColor = Colors.black,
    this.fontSize = 22.0,
    this.password = false,
    this.validator,
    this.onChanged,
    this.onPasswordEyePressed,
  });

  @override
  Widget build(BuildContext context) {
    return _buildFormField();
    // }
  }

  TextFormField _buildFormField() {
    return TextFormField(
      decoration: InputDecoration(
        fillColor: Colors.white,
        isDense: true,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0.r),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0.r),
          borderSide: const BorderSide(
            color: ColorConstants.red,
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
