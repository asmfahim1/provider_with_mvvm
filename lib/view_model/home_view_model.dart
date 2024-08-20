
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider_with_mvvm/data/response/api_response.dart';
import 'package:provider_with_mvvm/model/movie_list_model.dart';
import 'package:provider_with_mvvm/repositories/home_repository.dart';
import 'package:provider_with_mvvm/utils/general_utils.dart';

class HomeViewModel with ChangeNotifier {

  final _homeRepo = HomeRepository();


  ApiResponse<MovieList> movieList = ApiResponse.loading();
  setMovieListLoading(ApiResponse<MovieList> response){
    movieList = response;
    notifyListeners();
  }



  Future<void> getMovieListFromApi() async{
    setMovieListLoading(ApiResponse.loading());

    _homeRepo.getMovieListApiCall().then((value){

      print('========response is : $value');

      setMovieListLoading(ApiResponse.completed(value));


    }).onError((error, stackTrace){
      setMovieListLoading(ApiResponse.error(error.toString()));

      if (kDebugMode) {
        print('Error occurred in the api calling : $error');
      }

    });


  }
}