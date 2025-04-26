import 'dart:async';
import 'package:eltawfiq_suppliers/authentication/domain/use_cases/add_new_role_use_case.dart';
import 'package:flutter/cupertino.dart';

class AddNewRoleController extends ChangeNotifier{
  AddNewRoleUseCase addNewRoleUseCase;
  AddNewRoleController(this.addNewRoleUseCase);

  bool _addNewRoleIsLoading = false;
  String _addNewRoleErrorMessage = '';
  int? _addNewRoleResult;

  bool get addNewRoleIsLoading => _addNewRoleIsLoading;
  String get addNewRoleErrorMessage => _addNewRoleErrorMessage;
  int? get addNewRoleResult => _addNewRoleResult;

  FutureOr<void> addNewRole(AddNewRoleParameters addNewRoleParameters)async
  {
     _addNewRoleIsLoading = true;
     _addNewRoleErrorMessage = '';
     notifyListeners();
     try{
       final result = await addNewRoleUseCase(addNewRoleParameters);
       result.fold(
               (failure) {
                 _addNewRoleErrorMessage = failure.message;
               },
               (result) {
                 _addNewRoleResult = result;
               },
       );
     }catch(e){
       _addNewRoleErrorMessage = 'An unexpected error occurred $e';
     }finally{
       _addNewRoleIsLoading = false;
       notifyListeners();
     }

  }

}