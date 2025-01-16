import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../services/local_storage_services.dart';
import '../utils/api_constants.dart';
import '../utils/app_colors.dart';

class ApiClient {
  Future<dynamic> callApi({
    required String endPoint,
    required ApiSendingMethods method,
    Map<String, String>? queryParams,
    Map<String, String>? headers,
    Object? body,
    bool isTokenNeeded = true,
    bool isLoaderNeeded = false,
  }) {
    headers = headers ?? {};

    final url = Uri.https(ApiConstants.baseUrl, endPoint, queryParams);
    print('$url =====> url');
    print('$body =====> body');
    String? encodedBody;
    if (method == ApiSendingMethods.post ||
        method == ApiSendingMethods.put ||
        method == ApiSendingMethods.patch) {
      encodedBody = jsonEncode(body ?? {});
    }
    headers['Content-Type'] = 'application/json';

    if (isTokenNeeded) {
      final token = LocalStorage.getString(LocalStorageKeys.token);
      headers['Authorization'] = 'Bearer $token';
    }
    late Future<http.Response> response;
    switch (method) {
      case ApiSendingMethods.get:
        response = http.get(url, headers: headers);
        break;
      case ApiSendingMethods.post:
        response = http.post(url, headers: headers, body: encodedBody);
        break;
      case ApiSendingMethods.put:
        response = http.put(url, headers: headers, body: encodedBody);
        break;
      case ApiSendingMethods.patch:
        response = http.patch(url, headers: headers, body: encodedBody);
        break;
      case ApiSendingMethods.delete:
        response = http.delete(url, headers: headers);
        break;
      default:
        const Text('No such Case defined');
    }
    return handleResponse(
      response: response,
      endpoint: endPoint,
      isLoaderNeeded: isLoaderNeeded,
    );
  }

  Future<dynamic> handleResponse(
      {required Future<http.Response> response,
        required bool isLoaderNeeded,
        required String endpoint}) async {
    if (isLoaderNeeded) loader();

    final res = await response;
    if (isLoaderNeeded) Get.back();

    print("${res.body} =======> response");

    // Initialize decodedBody as null
    dynamic decodedBody;

    // Only decode the response body if it's not empty
    if (res.body.isNotEmpty) {
      try {
        decodedBody = jsonDecode(res.body);
      } catch (e) {
        print('Error decoding response: $e');
        errorDialog('Invalid JSON response from the server.');
        return null; // Exit early if JSON decoding fails
      }
    } else {
      print('Response body is empty');
    }

    // Check the status code for success
    if (res.statusCode >= 200 && res.statusCode < 300) {
      return decodedBody ?? {};
    } else {
      if (res.statusCode == 401 && endpoint != ApiConstants.login) {
        LocalStorage.remove(LocalStorageKeys.token);
        LocalStorage.remove(LocalStorageKeys.fcmToken);
        // tokenExpireDialog();
        return;
      } else if (decodedBody != null && decodedBody is Map) {
        if (decodedBody.containsKey('error')) {
          errorDialog(decodedBody['error']);
        } else if (decodedBody.containsKey("detail")) {
          errorDialog(decodedBody['detail']);
        } else {
          errorDialog(decodedBody.toString());
        }
      } else {
        errorDialog('An error occurred. Status code: ${res.statusCode}');
      }
    }
    return null;
  }

  static Future<dynamic> loader() {
    return Get.dialog(AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        content: Center(
            child: CircularProgressIndicator(
              color: AppColors.blueColor,
            ))));
  }

  Future<dynamic> errorDialog(String decodedBody) {
    return Get.dialog(AlertDialog(
      title: const Text("Errors"),
      content: Text(decodedBody),
    ));
  }

  Future<dynamic> sendDataWithImages({
    required String endpoint,
    required ApiSendingMethods method,
    Map<String, String>? queryParams,
    Map<String, String>? headers,
    required Map body,
    bool isTokenNeeded = true,
    bool isLoaderNeeded = false,
    List<Uint8List>? fileBytes,
    List<String>? fileNames,
    String fileKey = "image",
  }) async {

    final url = Uri.https(ApiConstants.baseUrl, endpoint, queryParams);

    late http.MultipartRequest request;
    switch (method) {
      case ApiSendingMethods.post:
        request = http.MultipartRequest("POST", url);
        break;
      case ApiSendingMethods.put:
        request = http.MultipartRequest("PUT", url);
        break;
      case ApiSendingMethods.patch:
        request = http.MultipartRequest("PATCH", url);
        break;
      default:
        throw UnsupportedError('HTTP method not supported');
    }

    if (fileBytes != null) {
      for (int i = 0; i < fileBytes.length; i++) {
        var multipartFile = http.MultipartFile.fromBytes(
          fileKey,
          fileBytes[i],
          filename: fileNames?[i],
        );
        request.files.add(multipartFile);
      }
    }

    headers = headers ?? {};
    if (isTokenNeeded) {
      final token = LocalStorage.getString(LocalStorageKeys.token);
      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = "Bearer $token";
      } else {
        return errorDialog('Authentication token not found');
      }
    }

    request.headers.addAll(headers);

    for (var key in body.keys) {
      request.fields[key] = body[key];
    }

    final streamResponse = await request.send();
    final response = await http.Response.fromStream(streamResponse);

    return handleResponse(
      response: Future.value(response),
      endpoint: endpoint,
      isLoaderNeeded: isLoaderNeeded,
    );
  }
}

enum ApiSendingMethods { get, post, put, delete, patch }