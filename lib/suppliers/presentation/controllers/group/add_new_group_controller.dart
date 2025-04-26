import 'dart:async';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/group/add_new_group_use_case.dart';
import 'package:flutter/cupertino.dart';

class AddNewGroupController extends ChangeNotifier{
  AddNewGroupUseCase addNewGroupUseCase;
  AddNewGroupController(this.addNewGroupUseCase);

  bool _addNewGroupIsLoading = false;
  String _addNewGroupErrorMessage = '';
  int? _addNewGroupResult;

  bool get addNewGroupIsLoading => _addNewGroupIsLoading;
  String get addNewGroupErrorMessage => _addNewGroupErrorMessage;
  int? get addNewGroupResult => _addNewGroupResult;

  FutureOr<void> addNewGroup(AddNewGroupParameters addNewGroupParameter) async{
    _addNewGroupIsLoading = true;
    _addNewGroupErrorMessage = '';
    notifyListeners();

    try{
      final result = await addNewGroupUseCase(addNewGroupParameter);
      result.fold(
            (failure) {
          _addNewGroupErrorMessage = failure.message;
        },
            (result) {
          _addNewGroupResult = result;
        },
      );
    }catch(e){
      _addNewGroupErrorMessage = 'An unexpected error occurred $e';
    }finally{
      _addNewGroupIsLoading = false;
      notifyListeners();
    }
  }

}