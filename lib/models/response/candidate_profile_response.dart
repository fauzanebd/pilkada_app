import 'package:json_annotation/json_annotation.dart';
import 'package:pilkada_app/models/candidate_profile.dart';

part 'candidate_profile_response.g.dart';

@JsonSerializable()
class CandidateProfileResponse {
  CandidateProfile data;
  bool error;
  String message;

  CandidateProfileResponse({
    required this.data,
    required this.error,
    required this.message,
  });

  factory CandidateProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$CandidateProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CandidateProfileResponseToJson(this); 
}