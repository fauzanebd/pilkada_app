// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_cities_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListCitiesResponse _$ListCitiesResponseFromJson(Map<String, dynamic> json) =>
    ListCitiesResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => City.fromJson(e as Map<String, dynamic>))
          .toList(),
      error: json['error'] as bool,
      message: json['message'] as String,
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ListCitiesResponseToJson(ListCitiesResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'error': instance.error,
      'message': instance.message,
      'meta': instance.meta,
    };
