import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

FutureOr<dynamic> responseInterceptor(
    Request request, Response response) async {
  responseLogger(response);
  // if (response.statusCode == 401) {
  //   throw UnauthorizedException(ErrorResponse.fromJson(response.body).message ?? '401: Unauthorized');
  //   // AuthUtils.logOut();
  // }
  return response;
}

void responseLogger(Response response) {
  debugPrint('Status Code: ${response.statusCode}\n');
  debugPrint('Data: ${response.bodyString?.toString() ?? ''}');
}
