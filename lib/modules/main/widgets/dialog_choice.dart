import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pilkada_app/shared/constants/colors.dart';
import 'package:pilkada_app/shared/constants/common.dart';

class DialogChoice extends StatelessWidget {
  const DialogChoice({
    super.key,
    required this.choiceTitle,
    required this.onChoiceTap,
    this.choiceTitleColor,
    this.choiceIcon,
  });

  final String choiceTitle;
  final void Function()? onChoiceTap;
  final Color? choiceTitleColor;
  final IconData? choiceIcon;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorConstants.primaryAccentColor,
      child: InkWell(
        onTap: onChoiceTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 18.h,
            horizontal: CommonConstants.kDefaultHorizontalPadding.w,
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                choiceIcon == null
                    ? const SizedBox()
                    : Icon(
                        choiceIcon,
                        size: 16.sp,
                        color: choiceTitleColor ??
                            ColorConstants.secondaryTextColor,
                      ),
                choiceIcon == null
                    ? const SizedBox()
                    : SizedBox(
                        width: CommonConstants.kDefaultHorizontalPadding.w),
                Text(
                  choiceTitle,
                  overflow: TextOverflow.ellipsis,
                  style: CommonConstants.kNormalText.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color:
                        choiceTitleColor ?? ColorConstants.secondaryTextColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
