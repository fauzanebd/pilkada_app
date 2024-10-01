import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pilkada_app/modules/auth/screens/login/login_controller.dart';
import 'package:pilkada_app/modules/auth/widgets/auth_input_field_with_top_left_label.dart';
import 'package:get/get.dart';
import 'package:pilkada_app/shared/constants/colors.dart';
import 'package:pilkada_app/shared/constants/common.dart';
import 'package:pilkada_app/shared/widgets/big_primary_button.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: controller.loginFormKey,
            child: Container(
              color: ColorConstants.appScaffoldBackgroundColor,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).viewPadding.top),
                  Flexible(
                    flex: 3,
                    child: Center(
                      child: SizedBox(
                        width: 180.w,
                        height: 280.w,
                        child: Image.asset(
                          'assets/pngs/gatepic.png',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 4,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                CommonConstants.kDefaultHorizontalPadding.w),
                        child: Column(
                          children: [
                            // const Expanded(child: SizedBox()),
                            AuthInputFieldWithTopLeftLabel(
                              isObscure: false,
                              textEditingController:
                                  controller.loginUsernameController,
                              labelText: 'Username',
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return 'Username tidak boleh kosong';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 10.h),
                            GetBuilder<LoginController>(
                              id: CommonConstants.kLoginPasswordBuilderId,
                              builder: (getxController) {
                                return AuthInputFieldWithTopLeftLabel(
                                  isObscure: getxController
                                      .isObscureLoginPassword.value,
                                  textEditingController:
                                      controller.loginPasswordController,
                                  password: true,
                                  labelText: 'Password',
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return 'Password tidak boleh kosong';
                                    }

                                    return null;
                                  },
                                  onPasswordEyePressed: () =>
                                      controller.toggleObscureLoginPassword(),
                                );
                              },
                            ),
                            SizedBox(height: 15.h),
                            GetBuilder<LoginController>(
                              id: CommonConstants.kLoginButtonBuilderId,
                              builder: (controller) {
                                return BigPrimaryButton(
                                  'Masuk',
                                  onTap: () {
                                    controller.login(context);
                                  },
                                  height: 50.h,
                                  isLoading: controller.isLoginLoading.value,
                                );
                              },
                            ),
                            SizedBox(height: 8.h),
                            const Expanded(child: SizedBox()),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
