import 'package:json_annotation/json_annotation.dart';

part 'visi_misi.g.dart';

@JsonSerializable()
class VisiMisi {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'client_code')
  String? clientCode;

  @JsonKey(name: 'text')
  String? text;

  @JsonKey(name: 'image')
  String? image;

  VisiMisi({
    this.id,
    this.clientCode,
    this.text,
    this.image,
  });

  factory VisiMisi.fromJson(Map<String, dynamic> json) =>
      _$VisiMisiFromJson(json);

  Map<String, dynamic> toJson() => _$VisiMisiToJson(this);
}