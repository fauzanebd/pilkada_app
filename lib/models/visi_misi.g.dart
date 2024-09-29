// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visi_misi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisiMisi _$VisiMisiFromJson(Map<String, dynamic> json) => VisiMisi(
      id: (json['id'] as num?)?.toInt(),
      clientCode: json['client_code'] as String?,
      text: json['text'] as String?,
    )..image = json['image'] as String?;

Map<String, dynamic> _$VisiMisiToJson(VisiMisi instance) => <String, dynamic>{
      'id': instance.id,
      'client_code': instance.clientCode,
      'text': instance.text,
      'image': instance.image,
    };
