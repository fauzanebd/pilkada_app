import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/request/request.dart';

FutureOr<Request> requestInterceptor(request) async {
  // final token = StorageService.box.pull(StorageItems.accessToken);

  // request.headers['X-Requested-With'] = 'XMLHttpRequest';
  // request.headers['Authorization'] = 'Bearer $token';

  requestLogger(request);
  return request;
}

Future<void> requestLogger(Request request) async {
  debugPrint('Request Url: ${request.method} ${request.url}\n');
  debugPrint('Request Headers: ${request.headers}\n');

  // try {
  //   final bodyBytes = await request.bodyBytes.reduce((a, b) => [...a, ...b]);
  //   final bodyString = utf8.decode(bodyBytes);
  //   debugPrint('Request Body: $bodyString\n');
  // } catch (e) {
  //   debugPrint('Error reading body: $e\n');
  // }

  // debugPrint('-------------------');
}
