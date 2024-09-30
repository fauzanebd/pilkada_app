import 'package:json_annotation/json_annotation.dart';
import 'package:pilkada_app/models/data_pemilih.dart';
import 'package:pilkada_app/models/response/meta.dart';

part 'daftar_data_pemilih_response.g.dart';

@JsonSerializable()
class DaftarDataPemilihResponse {
  List<DataPemilih> data;
  bool error;
  String message;
  Meta meta;

  DaftarDataPemilihResponse({
    required this.data,
    required this.error,
    required this.message,
    required this.meta,
  });

  factory DaftarDataPemilihResponse.fromJson(Map<String, dynamic> json) =>
      _$DaftarDataPemilihResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DaftarDataPemilihResponseToJson(this);
}
