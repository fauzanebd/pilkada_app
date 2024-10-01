import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pilkada_app/models/banner.dart';
import 'package:pilkada_app/modules/main/main_controller.dart';
import 'package:pilkada_app/shared/constants/constants.dart';
import 'package:pilkada_app/shared/utils/common_widget.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WormImageCarousel extends StatelessWidget {
  const WormImageCarousel({
    super.key,
    required this.carouselItems,
    required this.controller,
    required this.autoPlayDelay,
    required this.isSkeletonEnabled,
    this.onImageTap,
  });

  final List<CarouselItem> carouselItems;
  final MainController controller;
  final int autoPlayDelay;
  final bool isSkeletonEnabled;
  final Function(String imagePath)? onImageTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: CommonConstants.kDefaultHorizontalPadding.w),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Skeletonizer(
              enabled: isSkeletonEnabled,
              child: SizedBox(
                height: 180.h,
                child: Swiper(
                  itemBuilder: (context, index) {
                    if (carouselItems[index].isPng) {
                      return GestureDetector(
                        onTap: () {
                          debugPrint(
                              'tapped image ${carouselItems[index].image}');
                          onImageTap?.call(carouselItems[index].image!);
                        },
                        child: Image.asset(
                          carouselItems[index].image!,
                          fit: BoxFit.fill,
                        ),
                      );
                    }
                    try {
                      return CachedNetworkImage(
                        key: ValueKey(carouselItems[index].image!),
                        imageUrl: carouselItems[index].image!,
                        fit: BoxFit.fill,
                        placeholder: CommonWidget.cachedNetworkImagePlaceholder,
                        errorWidget: CommonWidget.cachedNetworkImageErrorWidget,
                      );
                    } catch (exception) {
                      return Image.asset(
                        CommonConstants.assetImagePlaceholder,
                        fit: BoxFit.fitHeight,
                      );
                    }
                  },
                  autoplayDelay: autoPlayDelay,
                  // indicatorLayout: PageIndicatorLayout.COLOR,
                  autoplay: true,
                  itemCount: carouselItems.length,
                  onIndexChanged: (index) {
                    controller.activeCarouselIndex.value = index;
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Obx(
            () => AnimatedSmoothIndicator(
              activeIndex: controller.activeCarouselIndex.value,
              count: carouselItems.length,
              // effect: const WormEffect(),
              effect: ExpandingDotsEffect(
                dotHeight: 5.h,
                dotWidth: 9.w,
                dotColor: ColorConstants.inactiveLight.withOpacity(0.8),
                activeDotColor: ColorConstants.primaryAccentColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
