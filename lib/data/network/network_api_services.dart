import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:provider_with_mvvm/data/app_exception.dart';
import 'package:provider_with_mvvm/data/network/base_api_services.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future deleteApiResponse(String url) {
    // TODO: implement deleteApiResponse
    throw UnimplementedError();
  }

  @override
  Future getApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(url)).timeout(
            const Duration(seconds: 10),
          );
      responseJson = returnResponse(response);


    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future postApiResponse(String url, dynamic data) async{
    dynamic responseJson;
    try {
      final response = await http.post(Uri.parse(url), body: data).timeout(
        const Duration(seconds: 10),
      );
      responseJson = returnResponse(response);

    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException{
      throw TimeoutException();
    }

    return responseJson;
  }

  @override
  Future putApiResponse(String url) {
    // TODO: implement putApiResponse
    throw UnimplementedError();
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
