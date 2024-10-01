// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dpt_check_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DPTCheckRequest _$DPTCheckRequestFromJson(Map<String, dynamic> json) =>
    DPTCheckRequest(
      wardCode: json['ward_code'] as String,
      name: json['name'] as String,
      gender: json['gender'] as String,
    );

Map<String, dynamic> _$DPTCheckRequestToJson(DPTCheckRequest instance) =>
    <String, dynamic>{
      'ward_code': instance.wardCode,
      'name': instance.name,
      'gender': instance.gender,
    };
