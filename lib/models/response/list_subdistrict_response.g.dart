// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_subdistrict_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListSubdistrictResponse _$ListSubdistrictResponseFromJson(
        Map<String, dynamic> json) =>
    ListSubdistrictResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => Subdistrict.fromJson(e as Map<String, dynamic>))
          .toList(),
      error: json['error'] as bool,
      message: json['message'] as String,
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ListSubdistrictResponseToJson(
        ListSubdistrictResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'error': instance.error,
      'message': instance.message,
      'meta': instance.meta,
    };
