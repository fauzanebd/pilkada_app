import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pilkada_app/modules/profile/profile_controller.dart';

import 'package:get/get.dart';
import 'package:pilkada_app/shared/constants/colors.dart';
import 'package:pilkada_app/shared/constants/common.dart';
import 'package:pilkada_app/shared/screens/custom_pop_screen.dart';
import 'package:pilkada_app/shared/widgets/input_field_with_top_left_label.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPopScreen(
      appBarTitle: 'Profil Anda',
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: controller.editProfileFormKey,
            child: Padding(
              padding: EdgeInsets.only(
                left: CommonConstants.kDefaultHorizontalPadding.w,
                right: CommonConstants.kDefaultHorizontalPadding.w,
                top: CommonConstants.kDefaultPaddingFromAppBar,
              ),
              child: Container(
                padding: EdgeInsets.only(
                  left: CommonConstants.kDefaultHorizontalPadding.w,
                  right: CommonConstants.kDefaultHorizontalPadding.w,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: ColorConstants.secondaryBackgroundColor,
                  border: Border.all(
                    color: ColorConstants.primaryAccentColor,
                    width: 1.0.w,
                    style: BorderStyle.solid,
                    strokeAlign: BorderSide.strokeAlignInside,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(height: 30.h),
                    InputFieldWithTopLeftLabel(
                      textEditingController: controller.editUserNameController,
                      labelText: 'Username',
                      readOnly: true,
                    ),
                    InputFieldWithTopLeftLabel(
                      textEditingController: controller.editNomorHPController,
                      labelText: 'Nomor HP',
                      readOnly: true,
                    ),
                    InputFieldWithTopLeftLabel(
                      textEditingController: controller.editProvinsiController,
                      labelText: 'Provinsi',
                      readOnly: true,
                    ),
                    InputFieldWithTopLeftLabel(
                      textEditingController: controller.editKotaController,
                      labelText: 'Kota',
                      readOnly: true,
                    ),
                    InputFieldWithTopLeftLabel(
                      textEditingController: controller.editKecamatanController,
                      labelText: 'Kecamatan',
                      readOnly: true,
                    ),
                    InputFieldWithTopLeftLabel(
                      textEditingController: controller.editKelurahanController,
                      labelText: 'Kelurahan',
                      readOnly: true,
                    ),
                    InputFieldWithTopLeftLabel(
                      textEditingController: controller.editTPSController,
                      labelText: 'No TPS',
                      readOnly: true,
                    ),
                    SizedBox(height: 30.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
