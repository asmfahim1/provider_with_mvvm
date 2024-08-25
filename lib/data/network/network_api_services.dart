import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider_with_mvvm/data/app_exception.dart';
import 'package:provider_with_mvvm/data/network/base_api_services.dart';

class NetworkApiServices extends BaseApiServices {
  Future<Map<String, String>> _getHeaders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  @override
  Future<dynamic> getApiResponse(String url) async {
    dynamic responseJson;
    try {
      final headers = await _getHeaders();
      final response = await http.get(Uri.parse(url), headers: headers).timeout(
        const Duration(seconds: 10),
      );
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future<dynamic> postApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      final headers = await _getHeaders();
      final response = await http
          .post(Uri.parse(url), headers: headers, body: jsonEncode(data))
          .timeout(
        const Duration(seconds: 10),
      );
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw TimeoutException();
    }
    return responseJson;
  }

  @override
  Future<dynamic> putApiResponse(String url) async {
    dynamic responseJson;
    try {
      final headers = await _getHeaders();
      final response = await http.put(Uri.parse(url), headers: headers).timeout(
        const Duration(seconds: 10),
      );
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw TimeoutException();
    }
    return responseJson;
  }

  @override
  Future<dynamic> deleteApiResponse(String url) {
    // TODO: implement deleteApiResponse
    throw UnimplementedError();
  }


  @override
  Future uploadImage(String url, File imageFile) async{
    dynamic responseJson;
    try {
      final headers = await _getHeaders();
      final request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers.addAll(headers)
        ..files.add(await http.MultipartFile.fromPath('image', imageFile.path));
      final response = await request.send().timeout(
        const Duration(seconds: 20),
      );
      final res = await http.Response.fromStream(response);
      responseJson = returnResponse(res);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw TimeoutException();
    }
    return responseJson;
  }


  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body);
      case 401:
        throw UnAuthorizeException('');
      case 403:
        throw UnAuthorizeException('You are not authorized for this action');
      case 404:
        throw InvalidInputException('Server not found');
      case 500:
        throw InvalidInputException('Server down');
      default:
        throw FetchDataException(
            'Error occurred while communicating with server ${response.statusCode}');
    }
  }
}
