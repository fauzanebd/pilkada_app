import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pilkada_app/modules/detail_data/detail_data_controller.dart';
import 'package:pilkada_app/shared/constants/colors.dart';
import 'package:pilkada_app/shared/constants/common.dart';

class LocationPickerBottomSheet extends StatelessWidget {
  final String title;
  final List<dynamic> items;
  final Function(dynamic) onItemSelected;
  final Function(String) onSearchChanged;
  final ScrollController scrollController;
  final RxBool theresMore;
  final RxBool isLoading;

  const LocationPickerBottomSheet({
    super.key,
    required this.title,
    required this.items,
    required this.onItemSelected,
    required this.onSearchChanged,
    required this.scrollController,
    required this.theresMore,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailDataController>(
        id: CommonConstants.kProvincePickerBuilderId,
        builder: (controller) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    onChanged: onSearchChanged,
                  ),
                ),
                Expanded(
                  child: Obx(() {
                    if (items.isNotEmpty) {
                      return ListView.builder(
                        controller: scrollController,
                        itemCount: items.length + 1,
                        itemBuilder: (context, index) {
                          if (index < items.length) {
                            final item = items[index];
                            return ListTile(
                              title: Text(item.name),
                              onTap: () {
                                onItemSelected(item);
                                Navigator.pop(context);
                              },
                            );
                          } else if (theresMore.value) {
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
                      );
                    } else {
                      return Center(
                        child: isLoading.value
                            ? const CircularProgressIndicator()
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'No $title found',
                                  style: CommonConstants.kNormalText.copyWith(
                                    color: ColorConstants.accentTextColor,
                                    fontSize: 20.sp,
                                  ),
                                ),
                              ),
                      );
                    }
                  }),
                ),
              ],
            ),
          );
        });
  }
}
