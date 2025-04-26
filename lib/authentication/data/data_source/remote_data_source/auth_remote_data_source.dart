

import 'package:eltawfiq_suppliers/authentication/data/models/role_model.dart';
import 'package:eltawfiq_suppliers/authentication/data/models/user_model.dart';
import 'package:eltawfiq_suppliers/authentication/domain/use_cases/add_new_role_use_case.dart';
import 'package:eltawfiq_suppliers/authentication/domain/use_cases/add_new_user_use_case.dart';
import 'package:eltawfiq_suppliers/authentication/domain/use_cases/edit_role_use_case.dart';
import 'package:eltawfiq_suppliers/authentication/domain/use_cases/edit_user_use_case.dart';
import 'package:eltawfiq_suppliers/authentication/domain/use_cases/login_user_use_case.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> loginUser(LoginUserParameters loginUserParameters);
  Future<List<UserModel>> getUsers(NoParameters noParameters);
  Future<List<RoleModel>> getRoles(NoParameters noParameters);
  Future<int> addNewUser(AddNewUserParameters addNewUserParameters);
  Future<int> addNewRole(AddNewRoleParameters addNewRoleParameters);
  Future<int>editUser(EditUserParameters editUserParameters);
  Future<int>deleteUser(int deleteUserParameters);

  Future<int>editRole(EditRoleParameters editRoleParameters);
  Future<int>deleteRole(int deleteRoleParameters);
}