import 'package:json_annotation/json_annotation.dart';
import 'package:pilkada_app/models/response/anggota.dart';
import 'package:pilkada_app/models/response/meta.dart';

part 'list_anggota_response.g.dart';

@JsonSerializable()
class ListAnggotaResponse {
  List<Anggota> data;
  bool error;
  String message;
  Meta meta;

  ListAnggotaResponse({
    required this.data,
    required this.error,
    required this.message,
    required this.meta,
  });

  factory ListAnggotaResponse.fromJson(Map<String, dynamic> json) =>
      _$ListAnggotaResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListAnggotaResponseToJson(this);
}
