// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_provinces_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListProvincesResponse _$ListProvincesResponseFromJson(
        Map<String, dynamic> json) =>
    ListProvincesResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => Province.fromJson(e as Map<String, dynamic>))
          .toList(),
      error: json['error'] as bool,
      message: json['message'] as String,
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ListProvincesResponseToJson(
        ListProvincesResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'error': instance.error,
      'message': instance.message,
      'meta': instance.meta,
    };
