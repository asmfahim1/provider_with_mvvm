import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:provider_with_mvvm/model/user_model.dart';
import 'package:provider_with_mvvm/repositories/auth_repository.dart';
import 'package:provider_with_mvvm/utils/general_utils.dart';
import 'package:provider_with_mvvm/utils/routes/route_name.dart';
import 'package:provider_with_mvvm/view_model/user_view_model.dart';


class AuthViewModel with ChangeNotifier {
  final _authRepo = AuthRepository();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  setLoading(bool value){
    _isLoading = value;
    notifyListeners();
  }


  Future<void> loginMethod(dynamic data, BuildContext context) async{

    setLoading(true);

    _authRepo.loginApiCall(data).then((value){

      setLoading(false);

      if (!context.mounted) return;

      final userViewMode = Provider.of<UserViewModel>(context, listen: false);
      userViewMode.saveUser(LoginModel(token: value['token']));

      Utils.flushBarErrorMessage('LoginSuccessfully', context);

      Navigator.pushNamed(context, RouteName.home);

      if (kDebugMode) {
        print('the values : ${value.toString()}');
      }

    }).onError((error, stackTrace){
      setLoading(false);

      if (kDebugMode) {

        if (!context.mounted) return;

        Utils.flushBarErrorMessage(error.toString(), context);
        print('Error occurred in the api calling : $error');
      }

    });


  }



  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

  setSignUpLoading(bool value){
    _signUpLoading = value;
    notifyListeners();
  }
  Future<void> signUpMethod(dynamic data, BuildContext context) async{

    setSignUpLoading(true);

    _authRepo.signUpApiCall(data).then((value){

      setSignUpLoading(false);

      if (!context.mounted) return;

      Utils.flushBarErrorMessage('Signup Successfully', context);

      Navigator.pushNamed(context, RouteName.login);

      if (kDebugMode) {
        print('the values : ${value.toString()}');
      }

    }).onError((error, stackTrace){
      setSignUpLoading(false);

      if (kDebugMode) {

        if (!context.mounted) return;

        Utils.flushBarErrorMessage(error.toString(), context);
        print('Error occurred in the api calling : $error');
      }

    });


  }


}