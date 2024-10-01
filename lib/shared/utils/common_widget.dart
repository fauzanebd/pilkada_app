import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pilkada_app/shared/constants/colors.dart';
import 'package:pilkada_app/shared/constants/common.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class CommonWidget {
  static void log(String message) {
    debugPrint(message);
  }

  static String decimalFormat(double value) {
    if (value % 1 == 0) {
      return numberFormatter.format(value);
    } else {
      return value.toStringAsFixed(3);
    }
  }

  static String dateFormatter(String dateString) {
    // The dateString should be in this format:
    // "Tue, 01 Oct 2024 10:08:42 GMT";

    // Parse the input string
    DateTime dateTime = HttpDate.parse(dateString);

    // Convert to WIB (Western Indonesian Time, UTC+7)
    DateTime wibDateTime = dateTime.add(Duration(hours: 7));

    // Format the date in Indonesian
    String formattedDate =
        DateFormat('EEE, d MMM yyyy', 'id_ID').format(wibDateTime);

    // Format the time in 24-hour format
    String formattedTime = DateFormat('HH:mm:ss').format(wibDateTime);

    return '$formattedDate, $formattedTime WIB';
  }

  static NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'id',
    symbol: 'Rp. ',
    decimalDigits: 0,
  );

  static NumberFormat numberFormatter = NumberFormat.decimalPattern('id');

  static DateFormat longMonthDateFormatter =
      DateFormat("dd MMMM yyyy", Get.locale!.toString());

  static DateFormat longMonthDateFormatterWithTime = DateFormat(
    "dd MMMM yyyy HH:mm",
    Get.locale!.toString(),
  );

  static Widget Function(BuildContext, String)? cachedNetworkImagePlaceholder =
      (context, url) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Shimmer.fromColors(
        baseColor: ColorConstants.shimmerBaseColor,
        highlightColor: ColorConstants.shimmerHighlightColor,
        child: Container(
          color: ColorConstants.secondaryDarkAppColor,
        ),
      ),
    );
  };

  static Widget Function(BuildContext, String, Object)?
      cachedNetworkImageErrorWidget = (context, url, err) => Image.asset(
            CommonConstants.assetImagePlaceholder,
            fit: BoxFit.cover,
          );

  static Widget Function(BuildContext, ImageProvider<Object>)?
      cardListCachedNetworkImageBuilder = (context, imageProvider) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          );

  static void snackbar(BuildContext context, String textcontent,
      {Color? backgroundColor, Color? textColor}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor ?? ColorConstants.primaryAccentColor,
        content: Text(
          textcontent,
          style: CommonConstants.kSnackbarText.copyWith(
            color: textColor ?? ColorConstants.secondaryTextColor,
          ),
        ),
      ),
    );
  }

  static void errorSnackbar(BuildContext context, String textcontent,
      {Color? backgroundColor, Color? textColor}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor ?? ColorConstants.red,
        content: Text(
          textcontent,
          style: CommonConstants.kSnackbarText.copyWith(
            color: textColor ?? ColorConstants.secondaryTextColor,
          ),
        ),
      ),
    );
  }

  static void toast(String error, {bool long = true}) async {
    Fluttertoast.showToast(
      msg: error,
      toastLength: long ? Toast.LENGTH_SHORT : Toast.LENGTH_LONG,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 3,
      backgroundColor: ColorConstants.secondaryDarkAppColor,
      textColor: Colors.white,
      fontSize: 16.0.sp,
    );
    // await Fluttertoast.showToast(
    //   msg: error,
    //   toastLength: Toast.LENGTH_SHORT,
    //   gravity: ToastGravity.BOTTOM,
    //   timeInSecForIosWeb: 3,
    //   backgroundColor: Colors.white,
    //   textColor: Colors.black,
    //   fontSize: 16.0,
    // );
  }
}
