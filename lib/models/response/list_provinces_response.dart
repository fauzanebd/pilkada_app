import 'package:json_annotation/json_annotation.dart';
import 'package:pilkada_app/models/province.dart';
import 'package:pilkada_app/models/response/meta.dart';

part 'list_provinces_response.g.dart';

@JsonSerializable()
class ListProvincesResponse {
  List<Province> data;
  bool error;
  String message;
  Meta meta;

  ListProvincesResponse({
    required this.data,
    required this.error,
    required this.message,
    required this.meta,
  });

  factory ListProvincesResponse.fromJson(Map<String, dynamic> json) =>
      _$ListProvincesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListProvincesResponseToJson(this);
}
