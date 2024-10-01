// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'candidate_profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CandidateProfileResponse _$CandidateProfileResponseFromJson(
        Map<String, dynamic> json) =>
    CandidateProfileResponse(
      data: CandidateProfile.fromJson(json['data'] as Map<String, dynamic>),
      error: json['error'] as bool,
      message: json['message'] as String,
    );

Map<String, dynamic> _$CandidateProfileResponseToJson(
        CandidateProfileResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'error': instance.error,
      'message': instance.message,
    };
