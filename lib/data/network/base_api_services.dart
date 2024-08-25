import 'dart:io';

abstract class BaseApiServices{

  Future<dynamic> getApiResponse(String url);

  Future<dynamic> postApiResponse(String url, dynamic data);

  Future<dynamic> putApiResponse(String url);

  Future<dynamic> deleteApiResponse(String url);

  Future<dynamic> uploadImage(String url, File imageFile);
}