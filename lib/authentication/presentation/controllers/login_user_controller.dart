import 'dart:async';
import 'package:eltawfiq_suppliers/authentication/data/data_source/local_data_source/shred_prefs_helper.dart';
import 'package:eltawfiq_suppliers/authentication/domain/entities/user_entity.dart';
import 'package:eltawfiq_suppliers/authentication/domain/use_cases/login_user_use_case.dart';
import 'package:eltawfiq_suppliers/authentication/domain/use_cases/save_token_use_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginUserController extends ChangeNotifier{

 // final SaveTokenUseCase saveTokenUseCase;

  LoginUserUseCase loginUserUseCase;
  LoginUserController(this.loginUserUseCase,
     // this.saveTokenUseCase
      );

  bool _loginUserIsLoading = false;
  String _loginUserErrorMessage = '';
  UserEntity? _loginUserResult;

  bool get loginUserIsLoading => _loginUserIsLoading;
  String get editUserErrorMessage => _loginUserErrorMessage;
  UserEntity? get loginUserResult => _loginUserResult;

  FutureOr<void> loginUser(LoginUserParameters loginUserParameter) async
  {
    _loginUserIsLoading = true;
    _loginUserErrorMessage = '';
    notifyListeners();
    try{
      final result = await loginUserUseCase(loginUserParameter);
      result.fold(
            (failure) {
          _loginUserErrorMessage = failure.message;
        },
            (result) async{
          _loginUserResult = result;
          await saveToken(result.id.toString(), result.userRoleEntity!.role);
        },
      );
    }catch(e){
      _loginUserErrorMessage = 'An unexpected error occurred $e';
    }finally{
      _loginUserIsLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveToken(String token, String role)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    SharedPreferencesHelper sharedPreferencesHelper = SharedPreferencesHelper(prefs);
    await sharedPreferencesHelper.saveToken(token,role);
  }

}