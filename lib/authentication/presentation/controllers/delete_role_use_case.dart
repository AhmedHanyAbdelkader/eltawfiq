import 'dart:async';

import 'package:eltawfiq_suppliers/authentication/domain/use_cases/delete_role_use_case.dart';
import 'package:flutter/cupertino.dart';

class DeleteRoleController extends ChangeNotifier{
  DeleteRoleUseCase deleteRoleUseCase;
  DeleteRoleController(this.deleteRoleUseCase);

  bool _deleteRoleIsLoading = false;
  String _deleteRoleErrorMessage = '';
  int? _deleteRoleResult;

  bool get deleteRoleIsLoading => _deleteRoleIsLoading;
  String get deleteRoleErrorMessage => _deleteRoleErrorMessage;
  int? get deleteRoleResult => _deleteRoleResult;

  FutureOr<void> deleteRole(int roleId)async
  {
    _deleteRoleIsLoading = true;
    _deleteRoleErrorMessage = '';
    notifyListeners();
    try{
      final result = await deleteRoleUseCase(roleId);
      result.fold(
            (l) {
          _deleteRoleErrorMessage = l.message;
        },
            (r) {
          _deleteRoleResult = r;
        },
      );
    }catch(e){
      _deleteRoleErrorMessage = 'An unexpected error occurred $e';
    }finally{
      _deleteRoleIsLoading = false;
      notifyListeners();
    }
  }
}