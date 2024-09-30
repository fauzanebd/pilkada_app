import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pilkada_app/shared/constants/colors.dart';
import 'package:pilkada_app/modules/main/widgets/dialog_choice.dart';

class PickPhotoDialogContent extends StatelessWidget {
  const PickPhotoDialogContent({
    super.key,
    this.onCancelDialog,
    this.onTakePhoto,
    this.onChooseFromGallery,
    required this.isEnumerator,
  });

  final void Function()? onCancelDialog;
  final void Function()? onTakePhoto;
  final void Function()? onChooseFromGallery;
  final bool isEnumerator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          // bottom: CommonConstants.kDefaultHorizontalPadding.h,
          // left: CommonConstants.kDefaultHorizontalPadding.w,
          // right: CommonConstants.kDefaultHorizontalPadding.w,
          ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DialogChoice(
                  choiceTitle: "Ambil foto",
                  onChoiceTap: onTakePhoto,
                  choiceIcon: CupertinoIcons.photo_camera,
                ),
                const Divider(
                  color: ColorConstants.appScaffoldBackgroundColor,
                  thickness: 1,
                ),
                isEnumerator
                    ? DialogChoice(
                        choiceTitle: "Ambil dari galeri",
                        onChoiceTap: onChooseFromGallery,
                        choiceIcon: CupertinoIcons.photo_on_rectangle,
                      )
                    : const SizedBox(),
                const Divider(
                  color: ColorConstants.appScaffoldBackgroundColor,
                  thickness: 1,
                ),
                DialogChoice(
                  choiceTitle: "Cancel",
                  onChoiceTap: onCancelDialog,
                  choiceTitleColor: ColorConstants.red,
                  choiceIcon: CupertinoIcons.xmark,
                ),
                Container(
                  color: ColorConstants.accentTextColor,
                  height: MediaQuery.of(context).viewPadding.bottom,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
