import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pilkada_app/modules/daftar_data/daftar_data_controller.dart';
import 'package:pilkada_app/shared/constants/colors.dart';
import 'package:pilkada_app/shared/constants/common.dart';
import 'package:pilkada_app/shared/screens/custom_pop_screen.dart';

class DaftarDataScreen extends StatelessWidget {
  const DaftarDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DaftarDataController>(
      id: CommonConstants.kDaftarDataBuilderId,
      builder: (controller) {
        return CustomPopScreen(
          appBarTitle: 'Daftar Data Pemilih',
          body: RefreshIndicator(
            backgroundColor: ColorConstants.appScaffoldBackgroundColor,
            color: ColorConstants.primaryAccentColor,
            onRefresh: controller.refreshData,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: CommonConstants.kDefaultHorizontalPadding.w,
                  ),
                  child: Column(
                    children: [
                      Obx(() => AnimatedContainer(
                            duration: const Duration(
                                milliseconds: DaftarDataController
                                    .searchBarAnimationDuration),
                            height: controller.isSearchBarVisible.value
                                ? 60.h
                                : 0.h,
                          )),
                      // Space for the search bar
                      Container(
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ColorConstants.primaryAccentColor,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: Text(
                          'Total Data: ${controller.dataPemilih.length}',
                          style: CommonConstants.kNormalText.copyWith(
                            color: ColorConstants.primaryAccentColor,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Expanded(
                        child: ListView.builder(
                          controller: controller.scrollController,
                          itemCount: controller.dataPemilih.length + 1,
                          itemBuilder: (context, index) {
                            if (index < controller.dataPemilih.length) {
                              final entry = controller.dataPemilih[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
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
                                      controller.navigateToDetailData(index);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                        vertical: 8.0,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            (entry.name != null &&
                                                    entry.name!.isNotEmpty)
                                                ? entry.name!
                                                : '-',
                                            style: CommonConstants.kNormalText
                                                .copyWith(
                                              color: ColorConstants
                                                  .accentTextColor,
                                              fontSize: 20.sp,
                                            ),
                                          ),
                                          Text(
                                            entry.nik ?? '',
                                            style: CommonConstants.kNormalText
                                                .copyWith(
                                              color: Colors.black,
                                              fontSize: 18.sp,
                                            ),
                                          ),
                                          Text(
                                            entry.createdAt ?? '',
                                            style: CommonConstants.kNormalText
                                                .copyWith(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                        ],
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
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Obx(() => AnimatedOpacity(
                        opacity:
                            controller.isSearchBarVisible.value ? 1.0 : 0.0,
                        duration: const Duration(
                            milliseconds: DaftarDataController
                                .searchBarAnimationDuration),
                        child: AnimatedContainer(
                          duration: const Duration(
                              milliseconds: DaftarDataController
                                  .searchBarAnimationDuration),
                          height:
                              controller.isSearchBarVisible.value ? 60.h : 0,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  CommonConstants.kDefaultHorizontalPadding.w,
                              vertical: 8.h,
                            ),
                            child: TextField(
                              focusNode: controller.searchFocusNode,
                              controller: controller.searchController,
                              decoration: InputDecoration(
                                hintText: 'Search...',
                                prefixIcon: const Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0.r),
                                  borderSide: const BorderSide(
                                    color: ColorConstants.primaryAccentColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
