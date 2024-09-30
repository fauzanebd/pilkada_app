import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:pilkada_app/api/api_repository.dart';
import 'package:get/get.dart';
import 'package:pilkada_app/models/response/visi_misi_response.dart';
import 'package:pilkada_app/models/visi_misi.dart';
import 'package:pilkada_app/shared/constants/common.dart';
import 'package:pilkada_app/shared/utils/common_widget.dart';

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
        text: '', image: 'https://placehold.co/600x400', clientCode: '0001');
    // getVisiMisi(token);
  }

  @override
  void onReady() async {
    super.onReady();

    await getVisiMisi(token);
  }

  Future<void> getVisiMisi(token) async {
    VisiMisiResponse? res;
    try {
      res = await apiRepository.getVisiMisi(
        token,
        clientCode: dotenv.get('CLIENT_CODE'),
      );
      if (res != null) {
        visiMisi = res.data;
        update([CommonConstants.kVisiMisiBuilderId]);
      }
    } catch (e) {
      debugPrint(e.toString());
      CommonWidget.toast('Failed to get visi & misi');
    }
  }
}

class VisiMisiArgs {
  final String token;
  VisiMisiArgs(this.token);
}
