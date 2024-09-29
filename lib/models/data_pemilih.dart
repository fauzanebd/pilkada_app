import 'package:json_annotation/json_annotation.dart';

part 'data_pemilih.g.dart';

@JsonSerializable()
class DataPemilih {
  @JsonKey(name: 'address')
  String? address;
  
  @JsonKey(name: 'birth_date')
  String? birthDate;
  
  @JsonKey(name: 'category')
  String? category;
  
  @JsonKey(name: 'city_code')
  String? cityCode;
  
  @JsonKey(name: 'client_code')
  String? clientCode;
  
  @JsonKey(name: 'confirmation_status')
  String? confirmationStatus;
  
  @JsonKey(name: 'expectation_to_candidate')
  String? expectationToCandidate;
  
  @JsonKey(name: 'gender')
  String? gender;
  
  @JsonKey(name: 'is_party_member')
  bool? isPartyMember;
  
  @JsonKey(name: 'model_id')
  int? modelId;
  
  @JsonKey(name: 'name')
  String? name;
  
  @JsonKey(name: 'nik')
  String? nik;
  
  @JsonKey(name: 'no_phone')
  String? noPhone;
  
  @JsonKey(name: 'no_tps')
  String? noTps;
  
  @JsonKey(name: 'positioning_to_candidate')
  String? positioningToCandidate;
  
  @JsonKey(name: 'province_code')
  String? provinceCode;
  
  @JsonKey(name: 'relation_to_candidate')
  String? relationToCandidate;
  
  @JsonKey(name: 's3_file')
  String? s3File;
  
  @JsonKey(name: 'subdistrict_code')
  String? subdistrictCode;
  
  @JsonKey(name: 'user_id')
  int? userId;
  
  @JsonKey(name: 'village_code')
  String? villageCode;
  
  @JsonKey(name: 'ward_code')
  String? wardCode;

  DataPemilih({
    this.address,
    this.birthDate,
    this.category,
    this.cityCode,
    this.clientCode,
    this.confirmationStatus,
    this.expectationToCandidate,
    this.gender,
    this.isPartyMember,
    this.modelId,
    this.name,
    this.nik,
    this.noPhone,
    this.noTps,
    this.positioningToCandidate,
    this.provinceCode,
    this.relationToCandidate,
    this.s3File,
    this.subdistrictCode,
    this.userId,
    this.villageCode,
    this.wardCode,
  });

  factory DataPemilih.fromJson(Map<String, dynamic> json) =>
      _$DataPemilihFromJson(json);

  Map<String, dynamic> toJson() => _$DataPemilihToJson(this);
}