import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pilkada_app/shared/constants/colors.dart';
import 'package:pilkada_app/shared/constants/common.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorConstants.appScaffoldBackgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 3,
              child: Center(
                child: SizedBox(
                  width: 220.w,
                  height: 220.w,
                  child: Image.asset(
                    'assets/pngs/smartsoft-logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Text(
                'Pilkada App',
                style: CommonConstants.kLargeText.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 34.sp,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
