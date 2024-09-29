import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:pilkada_app/models/data_pemilih.dart';
import 'package:pilkada_app/models/request/login_request.dart';
import 'package:pilkada_app/models/response/error_response.dart';
import 'package:pilkada_app/models/response/login_response.dart';
import 'package:pilkada_app/models/response/save_data_response.dart';
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

  Future<LoginResponse?> login(LoginRequest data) async {
    final res = await apiProvider.login('/login', data);
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

  Future<UploadImageResponse?> uploadImage(String imagePath, String filename,
      {required int userId, required String token}) async {
    final res = await apiProvider.uploadImage(
      '/data-pemilih/upload',
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

  Future<SaveDataResponse?> saveData(DataPemilih data, String token) async {
    final res =
        await apiProvider.saveData('/data-pemilih/save_data', data, token);
    switch (res.statusCode) {
      case 200:
        return SaveDataResponse.fromJson(res.body);
      case null: //null statusCode happen when theres no internet connection
        throw NetworkException(
            'Connection timed out. Check your internet connection',
            responseStatusErrorText: res.statusText);
      default:
        throw Exception(ErrorResponse.fromJson(res.body).message);
    }
  }

  Future<VisiMisiResponse> getVisiMisi(String token) async {
    final res = await apiProvider.getVisiMisi('/visi-misi', token);
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
}
