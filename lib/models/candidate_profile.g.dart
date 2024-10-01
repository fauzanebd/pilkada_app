// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'candidate_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CandidateProfile _$CandidateProfileFromJson(Map<String, dynamic> json) =>
    CandidateProfile(
      id: (json['id'] as num?)?.toInt(),
      clientCode: json['client_code'] as String?,
      text: json['text'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$CandidateProfileToJson(CandidateProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'client_code': instance.clientCode,
      'text': instance.text,
      'image': instance.image,
    };
