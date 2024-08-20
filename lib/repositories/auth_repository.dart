

import 'package:provider_with_mvvm/data/network/base_api_services.dart';
import 'package:provider_with_mvvm/data/network/network_api_services.dart';
import 'package:provider_with_mvvm/resources/app_urls.dart';

class AuthRepository{

  final BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> loginApiCall(dynamic data) async{
    try{
      dynamic response  = _apiServices.postApiResponse(AppUrls.loginEndPoint, data);
      return response;
    }catch(error){
      rethrow;
    }
  }

  Future<dynamic> signUpApiCall(dynamic data) async{
    try{
      dynamic response  = _apiServices.postApiResponse(AppUrls.registerEndPoint, data);
      return response;
    }catch(error){
      rethrow;
    }
  }

}