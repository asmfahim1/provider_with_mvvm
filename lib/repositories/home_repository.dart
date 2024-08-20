
import 'package:provider_with_mvvm/data/network/base_api_services.dart';
import 'package:provider_with_mvvm/data/network/network_api_services.dart';
import 'package:provider_with_mvvm/model/movie_list_model.dart';
import 'package:provider_with_mvvm/resources/app_urls.dart';

class HomeRepository {

  final BaseApiServices _apiServices = NetworkApiServices();

  Future<MovieList> getMovieListApiCall() async{
    try{
      dynamic response  = await _apiServices.getApiResponse(AppUrls.movieListEndPoint);
      return response = MovieList.fromJson(response);
    }catch(error){
      rethrow;
    }
  }
}