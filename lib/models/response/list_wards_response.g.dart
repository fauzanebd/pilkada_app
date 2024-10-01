// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_wards_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListWardsResponse _$ListWardsResponseFromJson(Map<String, dynamic> json) =>
    ListWardsResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => Ward.fromJson(e as Map<String, dynamic>))
          .toList(),
      error: json['error'] as bool,
      message: json['message'] as String,
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ListWardsResponseToJson(ListWardsResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'error': instance.error,
      'message': instance.message,
      'meta': instance.meta,
    };
