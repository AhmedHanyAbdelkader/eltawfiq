import 'dart:async';
import 'package:eltawfiq_suppliers/authentication/domain/use_cases/edit_user_use_case.dart';
import 'package:flutter/cupertino.dart';

class EditUserController extends ChangeNotifier{
  EditUserUseCase editUserUseCase;
  EditUserController(this.editUserUseCase);

  bool _editUserIsLoading = false;
  String _editUserErrorMessage = '';
  int? _editUserResult;

  bool get editUserIsLoading => _editUserIsLoading;
  String get editUserErrorMessage => _editUserErrorMessage;
  int? get editUserResult => _editUserResult;

  FutureOr<void> editUser(EditUserParameters editUserParameter) async
  {
    _editUserIsLoading = true;
    _editUserErrorMessage = '';
    notifyListeners();
    try{
      final result = await editUserUseCase(editUserParameter);
      result.fold(
            (failure) {
          _editUserErrorMessage = failure.message;
        },
            (result) {
          _editUserResult = result;
        },
      );
    }catch(e){
      _editUserErrorMessage = 'An unexpected error occurred $e';
    }finally{
      _editUserIsLoading = false;
      notifyListeners();
    }
  }
}