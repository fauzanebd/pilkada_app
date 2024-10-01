import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pilkada_app/api/api_repository.dart';
import 'package:get/get.dart';
import 'package:pilkada_app/models/response/candidate_profile_response.dart';
import 'package:pilkada_app/models/candidate_profile.dart';
import 'package:pilkada_app/shared/constants/common.dart';
import 'package:pilkada_app/shared/utils/common_widget.dart';

class CandidateProfileController extends GetxController {
  final ApiRepository apiRepository;
  CandidateProfileController({required this.apiRepository});
  late CandidateProfile candidateProfile;

  CandidateProfileArgs args = Get.arguments as CandidateProfileArgs;

  String? token;

  @override
  void onInit() {
    super.onInit();
    token = args.token;
    candidateProfile = CandidateProfile(
        text: '', image: 'https://placehold.co/600x400', clientCode: '0001');
    // getVisiMisi(token);
  }

  @override
  void onReady() async {
    super.onReady();

    await getCandidateProfile(token);
  }

  Future<void> getCandidateProfile(token) async {
    CandidateProfileResponse? res;
    try {
      res = await apiRepository.getCandidateProfile(token, clientCode: dotenv.get('CLIENT_CODE'));
      if (res != null) {
        candidateProfile = res.data;
        update([CommonConstants.kCandidateProfileBuilderId]);
      }
    } catch (e) {
      debugPrint(e.toString());
      CommonWidget.errorSnackbar(Get.context!, 'Failed to get visi & misi');
    }
  }
}

class CandidateProfileArgs {
  final String token;
  CandidateProfileArgs(this.token);
}
