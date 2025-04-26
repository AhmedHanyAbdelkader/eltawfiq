import 'dart:async';

import 'package:eltawfiq_suppliers/authentication/domain/use_cases/add_new_user_use_case.dart';
import 'package:flutter/cupertino.dart';

class AddNewUserController extends ChangeNotifier{
  AddNewUserUseCase addNewUserUseCase;
  AddNewUserController(this.addNewUserUseCase);

  bool _addNewUserIsLoading = false;
  String _addNewUserErrorMessage = '';
  int? _addNewUserResult;

  bool get addNewUserIsLoading => _addNewUserIsLoading;
  String get addNewUserErrorMessage => _addNewUserErrorMessage;
  int? get addNewUserResult => _addNewUserResult;

  FutureOr<void> addNewUser(AddNewUserParameters addNewUserParameters) async
  {
     _addNewUserIsLoading = true;
     _addNewUserErrorMessage = '';
     notifyListeners();
     try{
       final result = await addNewUserUseCase(addNewUserParameters);
       result.fold(
               (failure) {
                 _addNewUserErrorMessage = failure.message;
               },
               (result) {
                 _addNewUserResult = result;
               },
       );
     }catch(e){
       _addNewUserErrorMessage = 'An unexpected error occurred $e';
     }finally{
       _addNewUserIsLoading = false;
       notifyListeners();
     }
  }

}