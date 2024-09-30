import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pilkada_app/modules/main/main_controller.dart';
import 'package:pilkada_app/modules/main/widgets/worm_image_carousel.dart';
import 'package:pilkada_app/shared/constants/colors.dart';
import 'package:pilkada_app/shared/constants/common.dart';

class MainScreen extends GetView<MainController> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, res) {
        if (didPop) {
          return;
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).viewPadding.top,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: CommonConstants.kDefaultHorizontalPadding.w,
                vertical: 10.w,
              ),
              child: SizedBox(
                width: 40.w,
                height: 40.w,
                child: Image.asset(
                  'assets/pngs/smartsoft-logo.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            GetBuilder<MainController>(
              id: CommonConstants.kImageCarouselBuilderId,
              builder: (ctrl) {
                return WormImageCarousel(
                  carouselItems: ctrl.carouselItems.value,
                  isSkeletonEnabled: ctrl.carouselItemsLoading.value,
                  controller: controller,
                  autoPlayDelay: controller.appConf.sliderInterval,
                );
              },
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: CommonConstants.kDefaultHorizontalPadding.w,
                  vertical: 10.w,
                ),
                child: GridView.count(
                  crossAxisCount: 3,
                  childAspectRatio: 1, // Ensures square cells
                  children: [
                    _buildMenuItem(Icons.list_alt, 'Daftar Data', onTap: () {
                      controller.navigateToPage('Daftar Data');
                    }),
                    _buildMenuItem(Icons.emoji_events, 'Visi & Misi', onTap: () {
                      controller.navigateToPage('Visi & Misi');
                    }),
                    if (controller.currentUser != null && !(controller.currentUser!.isEnumerator ?? false))
                      _buildMenuItem(Icons.group, 'Anggota', onTap: () {
                        controller.navigateToPage('Anggota');
                      }),
                    _buildMenuItem(Icons.person, 'Profil', onTap: () {
                      controller.navigateToPage('Profil');
                    }),
                    if (controller.currentUser != null && !(controller.currentUser!.isEnumerator ?? false))
                      _buildMenuItem(Icons.people, 'DPT', onTap: () {
                        controller.navigateToPage('DPT');
                      }),
                    _buildMenuItem(Icons.exit_to_app, 'Keluar', onTap: () {
                      controller.navigateToPage('Keluar');
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 20.h),
          child: _buildCustomFAB(context),
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String label, {Function()? onTap}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Material(
          child: InkWell(
            onTap: () {
              if (onTap != null) {
                onTap();
              }
            },
            child: Ink(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: ColorConstants.primaryAccentColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: Colors.white, size: 50.w),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          textAlign: TextAlign.center,
          style: CommonConstants.kNormalText.copyWith(
            fontSize: 14.sp,
            color: ColorConstants.accentTextColor,
          ),
        ),
      ],
    );
  }

  Widget _buildCustomFAB(BuildContext context) {
    return SizedBox(
            width: 70.w, // Increased size to accommodate shadow
            height: 70.w, // Increased size to accommodate shadow
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  // Add functionality for the custom FAB
                  controller.onAddDataTap();
                },
                customBorder: const CircleBorder(),
                child: Ink(
                  decoration: const BoxDecoration(
                    color: ColorConstants.primaryAccentColor,
                    shape: BoxShape.circle,
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.black.withOpacity(0.3),
                    //     spreadRadius: 1,
                    //     blurRadius: 5,
                    //     offset: Offset(0, 2),
                    //   ),
                    // ],
                  ),
                  child: Center(
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 30.w,
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
