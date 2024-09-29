import 'package:json_annotation/json_annotation.dart';
import 'package:pilkada_app/models/visi_misi.dart';

part 'visi_misi_response.g.dart';

@JsonSerializable()
class VisiMisiResponse {
  VisiMisi data;
  bool error;
  String message;

  VisiMisiResponse({
    required this.data,
    required this.error,
    required this.message,
  });

  factory VisiMisiResponse.fromJson(Map<String, dynamic> json) =>
      _$VisiMisiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VisiMisiResponseToJson(this); 
}