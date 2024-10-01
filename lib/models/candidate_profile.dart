import 'package:json_annotation/json_annotation.dart';

part 'candidate_profile.g.dart';

@JsonSerializable()
class CandidateProfile {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'client_code')
  String? clientCode;

  @JsonKey(name: 'text')
  String? text;

  @JsonKey(name: 'image')
  String? image;

  CandidateProfile({
    this.id,
    this.clientCode,
    this.text,
    this.image,
  });

  factory CandidateProfile.fromJson(Map<String, dynamic> json) =>
      _$CandidateProfileFromJson(json);

  Map<String, dynamic> toJson() => _$CandidateProfileToJson(this);
}