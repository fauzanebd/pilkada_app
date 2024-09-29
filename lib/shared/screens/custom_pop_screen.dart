import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pilkada_app/shared/constants/constants.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomPopScreen extends StatelessWidget {
  const CustomPopScreen(
      {super.key, required this.body, this.appBarTitle, this.appBarTitleColor});

  final Widget body;
  final String? appBarTitle;
  final Color? appBarTitleColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.primaryAccentColor,
        title: Text(
          appBarTitle!,
          style: TextStyle(
              color: appBarTitleColor ?? ColorConstants.secondaryTextColor),
        ),
        leading: Skeleton.keep(
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              CupertinoIcons.back,
              color: appBarTitleColor ?? ColorConstants.secondaryTextColor,
              size: 30,
            ),
          ),
        ),
      ),
      body: body,
    );
  }
}
