// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dpt_check_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DPTCheckResponse _$DPTCheckResponseFromJson(Map<String, dynamic> json) =>
    DPTCheckResponse(
      isValidDpt: json['is_valid_dpt'] as bool,
      message: json['message'] as String,
      potentialDpt: (json['potential_dpt'] as List<dynamic>)
          .map((e) => PotentialDpt.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DPTCheckResponseToJson(DPTCheckResponse instance) =>
    <String, dynamic>{
      'is_valid_dpt': instance.isValidDpt,
      'message': instance.message,
      'potential_dpt': instance.potentialDpt,
    };
