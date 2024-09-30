import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pilkada_app/modules/daftar_anggota/daftar_anggota_controller.dart';
import 'package:pilkada_app/shared/constants/colors.dart';
import 'package:pilkada_app/shared/constants/common.dart';
import 'package:pilkada_app/shared/screens/custom_pop_screen.dart';

class DaftarAnggotaScreen extends StatelessWidget {
  const DaftarAnggotaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DaftarAnggotaController>(
      id: CommonConstants.kDaftarAnggotaBuilderId,
      builder: (controller) {
        return CustomPopScreen(
          appBarTitle: 'Daftar Anggota',
          body: RefreshIndicator(
            backgroundColor: ColorConstants.appScaffoldBackgroundColor,
            onRefresh: controller.refreshData,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: CommonConstants.kDefaultHorizontalPadding.w,
              ),
              child: ListView.builder(
                controller: controller.scrollController,
                itemCount: controller.daftarAnggota.length + 1,
                itemBuilder: (context, index) {
                  if (index < controller.daftarAnggota.length) {
                    final entry = controller.daftarAnggota[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: ColorConstants.primaryAccentColor
                                  .withOpacity(0.5),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              // controller.navigateToDetailData(entry);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    (entry.name.isNotEmpty) ? entry.name : '-',
                                    style: CommonConstants.kNormalText.copyWith(
                                      color: ColorConstants.accentTextColor,
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                  Text(
                                    entry.noPhone ?? '',
                                    style: CommonConstants.kNormalText.copyWith(
                                      color: Colors.black,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                  Text(
                                    'Level: ${entry.hierarchy}',
                                    style: CommonConstants.kNormalText.copyWith(
                                      color: Colors.black.withOpacity(0.5),
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else if (controller.hasMoreData.value) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
