import 'dart:async';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/group/edit_group_use_case.dart';
import 'package:flutter/cupertino.dart';

class EditGroupController extends ChangeNotifier{
  EditGroupUseCase editGroupUseCase;
  EditGroupController(this.editGroupUseCase);

  bool _editGroupIsLoading = false;
  String _editGroupErrorMessage = '';
  int? _editGroupResult;

  bool get editGroupIsLoading => _editGroupIsLoading;
  String get editGroupErrorMessage => _editGroupErrorMessage;
  int? get editGroupResult => _editGroupResult;

  FutureOr<void> editGroups(EditGroupParameters editGroupParameters) async
  {
    _editGroupIsLoading = true;
    _editGroupErrorMessage = '';
    notifyListeners();
    try{
      final result = await editGroupUseCase(editGroupParameters);
      result.fold(
            (failure) {
          _editGroupErrorMessage = failure.message;
        },
            (result) {
          _editGroupResult = result;
        },
      );
    }catch(e){
      _editGroupErrorMessage = 'An unexpected error occurred $e';
    }finally{
      _editGroupIsLoading = false;
      notifyListeners();
    }
  }


}