import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pilkada_app/modules/auth/auth_controller.dart';
import 'package:pilkada_app/shared/constants/constants.dart';
import 'package:pilkada_app/shared/widgets/big_primary_button.dart';
import 'package:get/get.dart';

class AuthScreen extends GetView<AuthController> {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorConstants.appScaffoldBackgroundColor,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: CommonConstants.kDefaultHorizontalPadding.w,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 5,
                child: Center(
                  child: SizedBox(
                    width: 210.w,
                    height: 210.w,
                    child: Image.asset(
                      'assets/pngs/gatepic.png',
                      fit: BoxFit.contain,
                    ),
                    // child: SvgPicture.asset(
                    //   'assets/svgs/smartsoft-logo.svg',
                    //   fit: BoxFit.contain,
                    // ),
                  ),
                ),
              ),
              Flexible(
                flex: 4,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Text(
                          'selamat datang',
                          style: CommonConstants.kLargeText.copyWith(
                            color: ColorConstants.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 30.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Text(
                          'login untuk memulai',
                          style: CommonConstants.kSmallText.copyWith(
                            color: ColorConstants.inactiveDark,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      BigPrimaryButton(
                        'login',
                        height: 48.h,
                        onTap: () async {
                          controller.goToLoginScreen();
                        },
                        isLoading: false,
                      ),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
