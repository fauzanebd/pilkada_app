import 'dart:io';
import 'package:get/get.dart';
import 'package:pilkada_app/models/data_pemilih.dart';
import 'package:pilkada_app/models/request/login_request.dart';
import 'api.dart';

class ApiProvider extends BaseProvider {
  Future<Response> healthCheck(String path) {
    return get(path);
  }

  Future<Response> login(String path, LoginRequest data) {
    return post(path, data.toJson());
  }

  Future<Response<dynamic>> uploadImage(
    String path, {
    required String token,
    required String imagePath,
    required String filename,
  }) async {
    final file = File(imagePath);
    if (!await file.exists()) {
      throw Exception('File does not exist');
    }
  
    final formData = FormData({
      'image': MultipartFile(file, filename: filename),
    });
  
    try {
      final response = await GetConnect().post(
        '${ApiConstants.baseUrl}$path',
        formData,
        headers: {'Authorization': 'Bearer $token'},
      );
  
      if (response.status.hasError) {
        throw Exception('Failed to upload image: ${response.statusText}');
      }
  
      return response;
    } catch (e) {
      throw Exception('Error uploading image: $e');
    }
  }

  Future<Response> saveData(String path, DataPemilih data, String token) {
    return post(path, data.toJson(),
        headers: {'Authorization': 'Bearer $token'});
  }

  Future<Response> updateData(String path, DataPemilih data, String token) {
    return post(path, data.toJson(),
        headers: {'Authorization': 'Bearer $token'});
  }

  Future<Response> getVisiMisi(String path, String token) {
    return get(path, headers: {'Authorization': 'Bearer $token'});
  }

  Future<Response> fetchDaftarDataPemilih(String path, String token) {
    return get(path, headers: {'Authorization': 'Bearer $token'});
  }

  Future<Response> fetchAnggota(String path, String token) {
    return get(path, headers: {'Authorization': 'Bearer $token'});
  }
}
