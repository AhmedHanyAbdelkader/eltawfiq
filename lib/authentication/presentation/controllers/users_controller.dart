import 'dart:async';
import 'package:eltawfiq_suppliers/authentication/domain/entities/user_entity.dart';
import 'package:eltawfiq_suppliers/authentication/domain/use_cases/get_users_use_case.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:flutter/cupertino.dart';

class UsersController extends ChangeNotifier{
  GetUsersUseCase getUsersUseCase;
  UsersController(this.getUsersUseCase);

  bool _getUsersIsLoading = false;
  String _getUsersErrorMessage = '';
  List<UserEntity>? _gettingUsers;

  bool get getUsersIsLoading => _getUsersIsLoading;
  String get getUsersErrorMessage => _getUsersErrorMessage;
  List<UserEntity>? get gettingUsers => _gettingUsers;

  FutureOr<void> getUsers(NoParameters noParameters) async
  {
     _getUsersIsLoading = true;
     _getUsersErrorMessage = '';
     notifyListeners();
     try{
       final result = await getUsersUseCase(noParameters);
       result.fold(
               (failure) {
                 _getUsersErrorMessage = failure.message;
               },
               (users) {
                 _gettingUsers = users;
               },
       );
     }catch(e){
       _getUsersErrorMessage = 'An unexpected error occurred $e';
     }finally{
       _getUsersIsLoading = false;
       notifyListeners();
     }
  }


}

