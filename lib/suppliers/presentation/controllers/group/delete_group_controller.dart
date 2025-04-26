import 'dart:async';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/group/delete_group_use_case.dart';
import 'package:flutter/cupertino.dart';

class DeleteGroupController extends ChangeNotifier{
  DeleteGroupUseCase deleteGroupUseCase;
  DeleteGroupController(this.deleteGroupUseCase);

  bool _deleteGroupIsLoading = false;
  String _deleteGroupErrorMessage = '';
  int? _deleteGroupResult;

  bool get deleteGroupIsLoading => _deleteGroupIsLoading;
  String get deleteGroupErrorMessage => _deleteGroupErrorMessage;
  int? get deleteGroupResult => _deleteGroupResult;

  FutureOr<void> deleteGroup(int groupId)async
  {
    _deleteGroupIsLoading = true;
    _deleteGroupErrorMessage = '';
    notifyListeners();
    try{
      final result = await deleteGroupUseCase(groupId);
      result.fold(
            (l) {
          _deleteGroupErrorMessage = l.message;
        },
            (r) {
          _deleteGroupResult = r;
        },
      );
    }catch(e){
      _deleteGroupErrorMessage = 'An unexpected error occurred $e';
    }finally{
      _deleteGroupIsLoading = false;
      notifyListeners();
    }
  }

}