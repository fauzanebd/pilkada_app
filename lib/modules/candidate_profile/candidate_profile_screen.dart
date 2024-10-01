import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pilkada_app/modules/candidate_profile/candidate_profile_controller.dart';
import 'package:pilkada_app/shared/constants/colors.dart';
import 'package:pilkada_app/shared/constants/common.dart';
import 'package:pilkada_app/shared/screens/custom_pop_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:get/get.dart';

class CandidateProfileScreen extends StatelessWidget {
  const CandidateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CandidateProfileController>(
      id: CommonConstants.kCandidateProfileBuilderId,
      builder: (controller) {
        if (controller.candidateProfile.text == null) {
          return CustomPopScreen(
            appBarTitle: 'Profil Calon',
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } 

        return CustomPopScreen(
            appBarTitle: 'Profil Calon',
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: CommonConstants.kDefaultHorizontalPadding.w,
                  vertical: 10.w,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 14,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: controller.candidateProfile.image ?? 'https://placehold.co/600x400',
                          fit: BoxFit.fill,
                          placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Container(
                            height: 200,
                            color: Colors.grey[300],
                            child: Center(
                              child: Icon(Icons.error, color: Colors.red),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    MarkdownBody(
                        extensionSet: md.ExtensionSet(
                          md.ExtensionSet.gitHubFlavored.blockSyntaxes,
                          [
                            md.EmojiSyntax(),
                            ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes,
                          ],
                        ),
                        data: controller.candidateProfile.text ?? CommonConstants.defaultDescription,
                        styleSheet: MarkdownStyleSheet(
                          textAlign: WrapAlignment.spaceEvenly,
                          h1: CommonConstants.kNormalText.copyWith(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          h2: CommonConstants.kNormalText.copyWith(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          h3: CommonConstants.kNormalText.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          p: CommonConstants.kNormalText.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w300,
                          ),
                          blockquote: CommonConstants.kNormalText.copyWith(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w300,
                          ),
                          blockquoteDecoration: BoxDecoration(
                            color: ColorConstants.appScaffoldBackgroundColor,
                            border: Border(
                              left: BorderSide(
                                color: ColorConstants.mainTextColor,
                                width: 2.w,
                              ),
                            )
                          ),
                          blockquotePadding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 5.h,
                          ),
                          listBullet: CommonConstants.kNormalText.copyWith(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w300,
                            color: ColorConstants.mainTextColor,
                          ),
                          listIndent: 20.w,
                          listBulletPadding: EdgeInsets.only(right: 8.w),
                        )
                      )
                  ],
                ),
              ),
            ),
          );
      } 
    );
  }
}