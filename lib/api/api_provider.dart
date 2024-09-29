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

  Future<Response> uploadImage(String path,
      {required String token,
      required String imagePath,
      required String filename}) {
    final FormData formData = FormData({
      'image': MultipartFile(File(imagePath), filename: filename),
    });

    return post(path, formData, headers: {'Authorization': 'Bearer $token'});
  }

  Future<Response> saveData(String path, DataPemilih data, String token) {
    return post(path, data.toJson(),
        headers: {'Authorization': 'Bearer $token'});
  }
}
