import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pilkada_app/shared/constants/constants.dart';

class BigPrimaryButton extends StatelessWidget {
  const BigPrimaryButton(
    this.text, {
    super.key,
    required this.isLoading,
    this.onTap,
    required this.height,
  });

  final bool isLoading;
  final String text;
  final void Function()? onTap;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.r),
      child: Material(
        // color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          splashColor: ColorConstants.primaryAccentColor.withAlpha(150),
          child: Ink(
            height: height,
            decoration: BoxDecoration(
              color: isLoading
                  ? ColorConstants.primaryAccentColor.withAlpha(150)
                  : const Color.fromARGB(255, 8, 9, 44),
              boxShadow: [
                CommonConstants.widgetShadowStyle,
              ],
            ),
            child: Center(
              child: isLoading
                  ? const CupertinoActivityIndicator(
                      color: ColorConstants.white)
                  : Text(
                      text,
                      style: CommonConstants.kNormalText.copyWith(
                        color: ColorConstants.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
