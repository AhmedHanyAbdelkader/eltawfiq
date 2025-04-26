import 'dart:async';
import 'package:eltawfiq_suppliers/authentication/domain/use_cases/edit_role_use_case.dart';
import 'package:flutter/cupertino.dart';

class EditRoleController extends ChangeNotifier{
  EditRoleUseCase editRoleUseCase;
  EditRoleController(this.editRoleUseCase);

  bool _editRoleIsLoading = false;
  String _editRoleErrorMessage = '';
  int? _editRoleResult;

  bool get editRoleIsLoading => _editRoleIsLoading;
  String get editRoleErrorMessage => _editRoleErrorMessage;
  int? get editRoleResult => _editRoleResult;

  FutureOr<void> editRole(EditRoleParameters editRoleParameter) async
  {
    _editRoleIsLoading = true;
    _editRoleErrorMessage = '';
    notifyListeners();
    try{
      final result = await editRoleUseCase(editRoleParameter);
      result.fold(
            (failure) {
          _editRoleErrorMessage = failure.message;
        },
            (result) {
          _editRoleResult = result;
        },
      );
    }catch(e){
      _editRoleErrorMessage = 'An unexpected error occurred $e';
    }finally{
      _editRoleIsLoading = false;
      notifyListeners();
    }
  }
}