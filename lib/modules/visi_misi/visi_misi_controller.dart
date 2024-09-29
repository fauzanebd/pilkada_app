import 'package:flutter/material.dart';
import 'package:pilkada_app/api/api_repository.dart';
import 'package:get/get.dart';
import 'package:pilkada_app/models/response/visi_misi_response.dart';
import 'package:pilkada_app/models/visi_misi.dart';
import 'package:pilkada_app/shared/constants/common.dart';

class VisiMisiController extends GetxController {
  final ApiRepository apiRepository;
  VisiMisiController({required this.apiRepository});
  late VisiMisi visiMisi;

  VisiMisiArgs args = Get.arguments as VisiMisiArgs; 

  String? token;


  @override
  void onInit() {
    super.onInit();
    token = args.token;
    visiMisi = VisiMisi(
      text: '',
      image: 'https://placehold.co/600x400',
      clientCode: '0001'
    );
    getVisiMisi(token);
  }

  @override
  void onReady() {
    super.onReady();

    getVisiMisi(token);
  }

  Future<void> getVisiMisi(token) async {
    VisiMisiResponse? res;
    try {
      res = await apiRepository.getVisiMisi(token);
      if (res != null) {
        visiMisi = res.data;
        update([CommonConstants.kVisiMisiBuilderId]);     
      }
    } catch (e) {
      debugPrint(e.toString());
    } 
  }
}

class VisiMisiArgs {
  final String token;
  VisiMisiArgs(this.token);
}