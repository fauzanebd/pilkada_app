// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dpt_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DPTResponse _$DPTResponseFromJson(Map<String, dynamic> json) => DPTResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => PotentialDpt.fromJson(e as Map<String, dynamic>))
          .toList(),
      error: json['error'] as bool,
      message: json['message'] as String,
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DPTResponseToJson(DPTResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'error': instance.error,
      'message': instance.message,
      'meta': instance.meta,
    };
