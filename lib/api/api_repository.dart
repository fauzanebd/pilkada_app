import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:pilkada_app/models/data_pemilih.dart';
import 'package:pilkada_app/models/request/dpt_check_request.dart';
import 'package:pilkada_app/models/request/login_request.dart';
import 'package:pilkada_app/models/response/candidate_profile_response.dart';
import 'package:pilkada_app/models/response/daftar_data_pemilih_response.dart';
import 'package:pilkada_app/models/response/delete_data_response.dart';
import 'package:pilkada_app/models/response/dpt_check_response.dart';
import 'package:pilkada_app/models/response/dpt_response.dart';
import 'package:pilkada_app/models/response/error_response.dart';
import 'package:pilkada_app/models/response/list_anggota_response.dart';
import 'package:pilkada_app/models/response/list_cities_response.dart';
import 'package:pilkada_app/models/response/list_provinces_response.dart';
import 'package:pilkada_app/models/response/list_subdistrict_response.dart';
import 'package:pilkada_app/models/response/list_wards_response.dart';
import 'package:pilkada_app/models/response/login_response.dart';
import 'package:pilkada_app/models/response/save_data_response.dart';
import 'package:pilkada_app/models/response/update_data_response.dart';
import 'package:pilkada_app/models/response/upload_image_response.dart';
import 'package:pilkada_app/models/response/visi_misi_response.dart';
import 'package:pilkada_app/shared/utils/exceptions.dart';
import 'api.dart';

class ApiRepository {
  ApiRepository({required this.apiProvider});

  final ApiProvider apiProvider;

  Future<void> healthCheck() async {
    final res = await apiProvider.healthCheck('/healthcheck');
    switch (res.statusCode) {
      case 200:
        return;
      case null: //null statusCode happen when theres no internet connection
        throw NetworkException(
            'Connection timed out. Check your internet connection',
            responseStatusErrorText: res.statusText);
      default:
        throw HealthCheckException('Health check failed. Please try again');
    }
  }

  Future<LoginResponse?> login(LoginRequest data, {String? clientCode}) async {
    final res = await apiProvider.login('/login?client_code=$clientCode', data);
    switch (res.statusCode) {
      case 200:
        return LoginResponse.fromJson(res.body);
      case null: //null statusCode happen when theres no internet connection
        throw NetworkException(
            'Connection timed out. Check your internet connection',
            responseStatusErrorText: res.statusText);
      case 401:
        throw UnauthorizedException(ErrorResponse.fromJson(res.body).message);
      case 404:
        throw NotFoundException(ErrorResponse.fromJson(res.body).message,
            responseStatusErrorText: res.statusText);
      case 400:
        throw LoginException(ErrorResponse.fromJson(res.body).message);
      default:
        throw Exception(ErrorResponse.fromJson(res.body).message);
    }
  }

  Future<DPTCheckResponse?> checkDPT({
    required DPTCheckRequest data,
    required String token,
  }) async {
    final res = await apiProvider.checkDpt(
      path: '/data-pemilih/check_dpt',
      data: data,
      token: token,
    );
    switch (res.statusCode) {
      case 200:
        return DPTCheckResponse.fromJson(res.body);
      case null: //null statusCode happen when theres no internet connection
        throw NetworkException(
            'Connection timed out. Check your internet connection',
            responseStatusErrorText: res.statusText);
      default:
        throw Exception(ErrorResponse.fromJson(res.body).message);
    }
  }

  Future<UploadImageResponse?> uploadImage(String imagePath, String filename,
      {required int userId,
      required String token,
      required String clientCode}) async {
    final res = await apiProvider.uploadImage(
      '/data-pemilih/upload?client_code=$clientCode',
      token: token,
      imagePath: imagePath,
      filename: filename,
    );
    switch (res.statusCode) {
      case 200:
        return UploadImageResponse.fromJson(res.body);
      case null: //null statusCode happen when theres no internet connection
        // throw Exception(res.statusText);
        debugPrint('kipak');
        debugPrint(res.statusText);
        throw NetworkException(
            'Connection timed out. Check your internet connection',
            responseStatusErrorText: res.statusText);
      default:
        debugPrint(ErrorResponse.fromJson(res.body).message);
        throw Exception(ErrorResponse.fromJson(res.body).message);
    }
  }

  Future<SaveDataResponse?> saveData(DataPemilih data, String token,
      {String? clientCode}) async {
    final res = await apiProvider.saveData(
        '/data-pemilih/save_data?client_code=$clientCode', data, token);
    switch (res.statusCode) {
      case 200:
        return SaveDataResponse.fromJson(res.body);
      case 400:
        final err = ErrorResponse.fromJson(res.body);
        if (err.message.contains('exists')) {
          throw DuplicateDataException(err.message);
        }
      case null: //null statusCode happen when theres no internet connection
        throw NetworkException(
            'Connection timed out. Check your internet connection',
            responseStatusErrorText: res.statusText);
      default:
        throw Exception(ErrorResponse.fromJson(res.body).message);
    }
    return null;
  }

  Future<String?> updateData(DataPemilih data, String token,
      {String? clientCode}) async {
    final res = await apiProvider.saveData(
        '/data-pemilih/update_data?client_code=$clientCode', data, token);
    switch (res.statusCode) {
      case 200:
        return UpdateDataResponse.fromJson(res.body).message;
      case null: //null statusCode happen when theres no internet connection
        throw NetworkException(
            'Connection timed out. Check your internet connection',
            responseStatusErrorText: res.statusText);
      default:
        throw Exception(ErrorResponse.fromJson(res.body).message);
    }
  }

  Future<String?> deleteData(int id, String token) async {
    final res = await apiProvider.deleteData('/data-pemilih/$id', token);
    switch (res.statusCode) {
      case 200:
        return DeleteDataResponse.fromJson(res.body).message;
      case null: //null statusCode happen when theres no internet connection
        throw NetworkException(
            'Connection timed out. Check your internet connection',
            responseStatusErrorText: res.statusText);
      default:
        throw Exception(ErrorResponse.fromJson(res.body).message);
    }
  }

  Future<VisiMisiResponse> getVisiMisi(String token,
      {String? clientCode}) async {
    final res = await apiProvider.getVisiMisi(
        '/visi-misi?client_code=$clientCode', token);
    switch (res.statusCode) {
      case 200:
        return VisiMisiResponse.fromJson(res.body);
      case null: //null statusCode happen when theres no internet connection
        throw NetworkException(
            'Connection timed out. Check your internet connection',
            responseStatusErrorText: res.statusText);
      default:
        throw Exception(ErrorResponse.fromJson(res.body).message);
    }
  }
  
  Future<CandidateProfileResponse> getCandidateProfile(String token,
      {String? clientCode}) async {
    final res = await apiProvider.getCandidateProfile(
        '/candidate_profile?client_code=$clientCode', token);
    switch (res.statusCode) {
      case 200:
        return CandidateProfileResponse.fromJson(res.body);
      case null: //null statusCode happen when theres no internet connection
        throw NetworkException(
            'Connection timed out. Check your internet connection',
            responseStatusErrorText: res.statusText);
      default:
        throw Exception(ErrorResponse.fromJson(res.body).message);
    }
  }

  Future<DPTResponse> getDPT(String token, int limit, int page, {String? query, String? clientCode}) async {
    String qargs = "";
    if (query != null && query.isNotEmpty) {
      qargs = "&q=$query";
    }
    final res = await apiProvider.getDPT(
        '/dpt?limit=$limit&page=$page&client_code=$clientCode$qargs',
        token);
    switch (res.statusCode) {
      case 200:
        return DPTResponse.fromJson(res.body);
      case null: //null statusCode happen when theres no internet connection
        throw NetworkException(
            'Connection timed out. Check your internet connection',
            responseStatusErrorText: res.statusText);
      default:
        throw Exception(ErrorResponse.fromJson(res.body).message);
    }
  }

  Future<DaftarDataPemilihResponse> fetchDaftarDataPemilih(
      String token, int limit, int page,
      {String? query, String? clientCode}) async {
    String qargs = "";
    if (query != null && query.isNotEmpty) {
      qargs = "&q=$query";
    }
    final res = await apiProvider.fetchDaftarDataPemilih(
        '/data-pemilih?limit=$limit&page=$page&client_code=$clientCode$qargs',
        token);
    switch (res.statusCode) {
      case 200:
        return DaftarDataPemilihResponse.fromJson(res.body);
      case null: //null statusCode happen when theres no internet connection
        throw NetworkException(
            'Connection timed out. Check your internet connection',
            responseStatusErrorText: res.statusText);
      default:
        throw Exception(ErrorResponse.fromJson(res.body).message);
    }
  }

  Future<ListAnggotaResponse> fetchAnggota(String token, int limit, int page,
      {String? query, String? clientCode}) async {
    String qargs = "";
    if (query != null && query.isNotEmpty) {
      qargs = "&q=$query";
    }
    final res = await apiProvider.fetchAnggota(
        '/users/get-subordinate?client_code=$clientCode$qargs', token);
    switch (res.statusCode) {
      case 200:
        return ListAnggotaResponse.fromJson(res.body);
      case null: //null statusCode happen when theres no internet connection
        throw NetworkException(
            'Connection timed out. Check your internet connection',
            responseStatusErrorText: res.statusText);
      default:
        throw Exception(ErrorResponse.fromJson(res.body).message);
    }
  }

  Future<ListProvincesResponse> fetchProvinces(
      String token, int limit, int page,
      {String? query, String? clientCode}) async {
    String qargs = "";
    if (query != null && query.isNotEmpty) {
      qargs = "&q=$query";
    }
    final res = await apiProvider.fetchProvinces(
        '/locations/provinces?limit=$limit&page=$page&client_code=$clientCode$qargs',
        token);
    switch (res.statusCode) {
      case 200:
        return ListProvincesResponse.fromJson(res.body);
      case null: //null statusCode happen when theres no internet connection
        throw NetworkException(
            'Connection timed out. Check your internet connection',
            responseStatusErrorText: res.statusText);
      default:
        throw Exception(ErrorResponse.fromJson(res.body).message);
    }
  }

  Future<ListCitiesResponse> fetchCities(
      String token, int limit, int page, String provinceCode,
      {String? query, String? clientCode}) async {
    String qargs = "";
    if (query != null && query.isNotEmpty) {
      qargs = "&q=$query";
    }
    final res = await apiProvider.fetchCities(
        '/locations/cities?limit=$limit&page=$page&province_code=$provinceCode&client_code=$clientCode$qargs',
        token);
    switch (res.statusCode) {
      case 200:
        return ListCitiesResponse.fromJson(res.body);
      case null: //null statusCode happen when theres no internet connection
        throw NetworkException(
            'Connection timed out. Check your internet connection',
            responseStatusErrorText: res.statusText);
      default:
        throw Exception(ErrorResponse.fromJson(res.body).message);
    }
  }

  Future<ListSubdistrictResponse> fetchSubdistricts(
      String token, int limit, int page, String cityCode,
      {String? query, String? clientCode}) async {
    String qargs = "";
    if (query != null && query.isNotEmpty) {
      qargs = "&q=$query";
    }
    final res = await apiProvider.fetchSubdistricts(
        '/locations/subdistricts?limit=$limit&page=$page&city_code=$cityCode&client_code=$clientCode$qargs',
        token);
    switch (res.statusCode) {
      case 200:
        return ListSubdistrictResponse.fromJson(res.body);
      case null: //null statusCode happen when theres no internet connection
        throw NetworkException(
            'Connection timed out. Check your internet connection',
            responseStatusErrorText: res.statusText);
      default:
        throw Exception(ErrorResponse.fromJson(res.body).message);
    }
  }

  Future<ListWardsResponse> fetchWards(
      String token, int limit, int page, String subdistrictCode,
      {String? query, String? clientCode}) async {
    String qargs = "";
    if (query != null && query.isNotEmpty) {
      qargs = "&q=$query";
    }
    final res = await apiProvider.fetchWards(
        '/locations/wards?limit=$limit&page=$page&subdistrict_code=$subdistrictCode&client_code=$clientCode$qargs',
        token);
    switch (res.statusCode) {
      case 200:
        return ListWardsResponse.fromJson(res.body);
      case null: //null statusCode happen when theres no internet connection
        throw NetworkException(
            'Connection timed out. Check your internet connection',
            responseStatusErrorText: res.statusText);
      default:
        throw Exception(ErrorResponse.fromJson(res.body).message);
    }
  }
}
