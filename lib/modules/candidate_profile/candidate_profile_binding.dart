import 'package:pilkada_app/api/api_repository.dart';
import 'package:get/get.dart';
import 'package:pilkada_app/modules/candidate_profile/candidate_profile_controller.dart';

class CandidateProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CandidateProfileController>(
        CandidateProfileController(apiRepository: Get.find<ApiRepository>()));
  }
}
