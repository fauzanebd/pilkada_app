import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pilkada_app/shared/constants/colors.dart';
import 'package:pilkada_app/shared/constants/common.dart';

class AlternateAuthButton extends StatelessWidget {
  const AlternateAuthButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.height,
  });

  final void Function()? onTap;
  final String text;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: Colors.transparent,
          border: Border.all(
            color: ColorConstants.primaryAccentColor,
            width: 3.w,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: CommonConstants.kNormalText.copyWith(
              color: ColorConstants.primaryAccentColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
