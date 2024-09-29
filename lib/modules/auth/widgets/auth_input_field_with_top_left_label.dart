import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pilkada_app/modules/auth/widgets/auth_input_field.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:pilkada_app/shared/constants/colors.dart';
import 'package:pilkada_app/shared/constants/common.dart';

class AuthInputFieldWithTopLeftLabel extends StatelessWidget {
  const AuthInputFieldWithTopLeftLabel({
    super.key,
    this.isObscure = false,
    required this.textEditingController,
    required this.labelText,
    this.validator,
    this.placeHolder,
    this.onChanged,
    this.onPasswordEyePressed,
    this.password = false,
    this.fontSize = 16,
    this.distanceFromLabel = 5,
    this.readOnly = false,
    this.onTap,
    this.hintText,
    this.phoneNumber = false,
    this.onCountryChanged,
  });

  final bool isObscure;
  final bool password;
  final TextEditingController textEditingController;
  final String labelText;
  final String? placeHolder;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onPasswordEyePressed;
  final double fontSize;
  final double distanceFromLabel;
  final bool readOnly;
  final void Function()? onTap;
  final String? hintText;
  final bool phoneNumber;
  final void Function(Country)? onCountryChanged;

  @override
  Widget build(BuildContext context) {
    // The equivalent of the "smallestWidth" qualifier on Android.
    var shortestSide = MediaQuery.of(Get.context!).size.shortestSide;

    // is it a phone?, assuming that a tablet will have a shortestSide > 650
    final bool isMobile = shortestSide < 650;
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            labelText,
            style: CommonConstants.kNormalText.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: ColorConstants.black,
            ),
          ),
        ),
        SizedBox(height: distanceFromLabel.h),
        phoneNumber
            ? IntlPhoneField(
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(
                    color: ColorConstants.black.withOpacity(0.4),
                    fontSize: fontSize,
                    fontWeight: FontWeight.normal,
                  ),
                  fillColor: Colors.black,
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
                  errorStyle: TextStyle(
                    color: ColorConstants.red,
                    fontSize: fontSize - (isMobile ? 4.0 : 8.0),
                    fontWeight: FontWeight.normal,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 10.0,
                  ),
                  constraints: BoxConstraints(
                    minHeight: 60.h,
                  ),
                ),
                disableLengthCheck: true,
                dropdownIconPosition: IconPosition.leading,
                dropdownIcon: const Icon(
                  Icons.arrow_drop_down,
                  color: ColorConstants.black,
                ),
                flagsButtonPadding: EdgeInsets.only(left: 10.w),
                dropdownTextStyle: TextStyle(
                  color: ColorConstants.black,
                  fontSize: fontSize,
                  fontWeight: FontWeight.normal,
                ),
                initialCountryCode: 'ID',
                onCountryChanged: onCountryChanged,
                style: TextStyle(
                  color: ColorConstants.black,
                  fontSize: fontSize,
                  fontWeight: FontWeight.normal,
                ),
                invalidNumberMessage: 'phone_format_error'.tr,
                controller: textEditingController,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(
                      RegExp(r'[a-zA-Z]')), //only numbers
                  FilteringTextInputFormatter.deny(
                      RegExp(r'^0')), //no leading zero
                ],
                pickerDialogStyle: PickerDialogStyle(
                  searchFieldInputDecoration: InputDecoration(
                    hintText: 'search_country'.tr,
                    hintStyle: TextStyle(
                      color: ColorConstants.black.withOpacity(0.4),
                      fontSize: fontSize,
                      fontWeight: FontWeight.w500,
                    ),
                    // only bottom border
                    border: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorConstants.primaryAccentColor,
                      ),
                    ),
                    contentPadding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      top: 10.0,
                    ),
                    suffixIcon: const Icon(
                      Icons.search,
                      color: ColorConstants.primaryAccentColor,
                    ),
                  ),
                  countryNameStyle: TextStyle(
                    color: ColorConstants.primaryAccentColor,
                    fontSize: fontSize,
                    fontWeight: FontWeight.w600,
                  ),
                  countryCodeStyle: TextStyle(
                    color: ColorConstants.primaryAccentColor.withOpacity(0.6),
                    fontSize: fontSize - 2.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            : AuthInputFieldWithNoLabel(
                isObscure: isObscure,
                textEditingController: textEditingController,
                keyboardType: TextInputType.text,
                placeholder: placeHolder ?? '',
                fontSize: fontSize.sp,
                validator: validator,
                password: password,
                readOnly: readOnly,
                onChanged: onChanged,
                onPasswordEyePressed: onPasswordEyePressed,
                onTap: onTap,
                hintText: hintText,
              ),
      ],
    );
  }
}
