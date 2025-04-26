import 'dart:async';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/group_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/group/get_all_groups_use_case.dart';
import 'package:flutter/cupertino.dart';

class GroupsController extends ChangeNotifier{
  GroupsUseCase getAllGroupsUseCase;
  GroupsController(this.getAllGroupsUseCase);

  bool _getGroupsLoading = false;
  String _getGroupsErrorMessage = '';
  List<GroupEntity>? _gettingGroups;

  bool get getGroupsIsLoading => _getGroupsLoading;
  String get getGroupsErrorMessage => _getGroupsErrorMessage;
  List<GroupEntity>? get gettingGroups => _gettingGroups;


  FutureOr<void> getGroups(NoParameters parameters) async{
    _getGroupsLoading = true;
    _getGroupsErrorMessage = '';
    notifyListeners();

    try{
      final result = await getAllGroupsUseCase(parameters);
      result.fold(
            (l) {
          _getGroupsLoading = false;
          _getGroupsErrorMessage = l.message;
          notifyListeners();
        },
            (r) {
          _getGroupsLoading = false;
          _gettingGroups = r;
          notifyListeners();
        },
      );
    }catch(e){
      _getGroupsErrorMessage = 'An unexpected error occurred $e';
    }finally{
      _getGroupsLoading = false;
      notifyListeners();
    }

  }

}