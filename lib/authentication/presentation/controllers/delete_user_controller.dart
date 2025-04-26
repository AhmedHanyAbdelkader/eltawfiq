import 'dart:async';

import 'package:eltawfiq_suppliers/authentication/domain/use_cases/delete_user_use_case.dart';
import 'package:flutter/cupertino.dart';

class DeleteUserController extends ChangeNotifier{
  DeleteUserUseCase deleteUserUseCase;
  DeleteUserController(this.deleteUserUseCase);

  bool _deleteUserIsLoading = false;
  String _deleteUserErrorMessage = '';
  int? _deleteUserResult;

  bool get deleteUserIsLoading => _deleteUserIsLoading;
  String get deleteUserErrorMessage => _deleteUserErrorMessage;
  int? get deleteUserResult => _deleteUserResult;

  FutureOr<void> deleteUser(int userId)async
  {
    _deleteUserIsLoading = true;
    _deleteUserErrorMessage = '';
    notifyListeners();
    try{
      final result = await deleteUserUseCase(userId);
      result.fold(
            (l) {
          _deleteUserErrorMessage = l.message;
        },
            (r) {
          _deleteUserResult = r;
        },
      );
    }catch(e){
      _deleteUserErrorMessage = 'An unexpected error occurred $e';
    }finally{
      _deleteUserIsLoading = false;
      notifyListeners();
    }
  }
}