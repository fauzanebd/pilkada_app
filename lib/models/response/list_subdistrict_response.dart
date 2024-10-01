import 'package:json_annotation/json_annotation.dart';
import 'package:pilkada_app/models/response/meta.dart';
import 'package:pilkada_app/models/subdistrict.dart';

part 'list_subdistrict_response.g.dart';

@JsonSerializable()
class ListSubdistrictResponse {
  List<Subdistrict> data;
  bool error;
  String message;
  Meta meta;

  ListSubdistrictResponse({
    required this.data,
    required this.error,
    required this.message,
    required this.meta,
  });

  factory ListSubdistrictResponse.fromJson(Map<String, dynamic> json) =>
      _$ListSubdistrictResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListSubdistrictResponseToJson(this);
}
