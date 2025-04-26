import 'package:dartz/dartz.dart';
import 'package:eltawfiq_suppliers/authentication/domain/entities/role_entity.dart';
import 'package:eltawfiq_suppliers/authentication/domain/entities/user_entity.dart';
import 'package:eltawfiq_suppliers/authentication/domain/use_cases/add_new_role_use_case.dart';
import 'package:eltawfiq_suppliers/authentication/domain/use_cases/add_new_user_use_case.dart';
import 'package:eltawfiq_suppliers/authentication/domain/use_cases/edit_role_use_case.dart';
import 'package:eltawfiq_suppliers/authentication/domain/use_cases/edit_user_use_case.dart';
import 'package:eltawfiq_suppliers/authentication/domain/use_cases/login_user_use_case.dart';
import 'package:eltawfiq_suppliers/core/error/failure.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';

abstract class AuthBaseRepository {
  Future<Either<Failure, UserEntity>> loginUser(LoginUserParameters loginUserParameters);
  Future<Either<Failure, List<UserEntity>>> getUsers(NoParameters noParameters);
  Future<Either<Failure, List<RoleEntity>>> getRoles(NoParameters noParameters);
  Future<Either<Failure, int>> addNewUser(AddNewUserParameters addNewUserParameters);
  Future<Either<Failure, int>> addNewRole(AddNewRoleParameters addNewRoleParameters);
  Future<Either<Failure, int>> editUser(EditUserParameters editUserParameters);
  Future<Either<Failure, int>> deleteUser(int deleteUserParameter);

  Future<Either<Failure, int>> editRole(EditRoleParameters editRoleParameters);
  Future<Either<Failure, int>> deleteRole(int deleteRoleParameter);


  // Future<void> saveToken(String token);
  // Future<Either<Failure, String>> getToken(NoParameters noParameters);
  // Future<void> clearToken();

}