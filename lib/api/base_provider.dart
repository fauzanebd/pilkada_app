import 'package:get/get.dart';

import 'api.dart';

class BaseProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = ApiConstants.baseUrl;

    httpClient.timeout = const Duration(seconds: 30);

    httpClient.addAuthenticator(authInterceptor);
    httpClient.addRequestModifier(requestInterceptor);
    httpClient.addResponseModifier(responseInterceptor);
  }
}
