import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:pilkada_app/shared/constants/colors.dart';

class CustomPopScreen extends StatelessWidget {
  const CustomPopScreen({
    super.key,
    required this.body,
    required this.appBarTitle,
    this.appBarTitleColor,
  });

  final Widget body;
  final String? appBarTitle;
  final Color? appBarTitleColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle!,
            style: TextStyle(color: appBarTitleColor ?? ColorConstants.black)),
        leading: Skeleton.keep(
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              CupertinoIcons.back,
              color: appBarTitleColor ?? ColorConstants.black,
              size: 30,
            ),
          ),
        ),
      ),
      body: body,
    );
  }
}
