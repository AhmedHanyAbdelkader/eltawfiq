
import 'package:dartz/dartz.dart';
import 'package:eltawfiq_suppliers/authentication/data/data_source/remote_data_source/auth_remote_data_source.dart';
import 'package:eltawfiq_suppliers/authentication/domain/entities/role_entity.dart';
import 'package:eltawfiq_suppliers/authentication/domain/entities/user_entity.dart';
import 'package:eltawfiq_suppliers/authentication/domain/repository/auth_base_repository.dart';
import 'package:eltawfiq_suppliers/authentication/domain/use_cases/add_new_role_use_case.dart';
import 'package:eltawfiq_suppliers/authentication/domain/use_cases/add_new_user_use_case.dart';
import 'package:eltawfiq_suppliers/authentication/domain/use_cases/edit_role_use_case.dart';
import 'package:eltawfiq_suppliers/authentication/domain/use_cases/edit_user_use_case.dart';
import 'package:eltawfiq_suppliers/authentication/domain/use_cases/login_user_use_case.dart';
import 'package:eltawfiq_suppliers/core/error/exceptions.dart';
import 'package:eltawfiq_suppliers/core/error/failure.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';

class AuthRepo extends AuthBaseRepository{
  AuthRemoteDataSource authRemoteDataSource;
  //AuthLocalDataSource authLocalDataSource;

  AuthRepo(this.authRemoteDataSource, );
  @override
  Future<Either<Failure, List<UserEntity>>> getUsers(NoParameters noParameters) async{
    try{
      final result = await authRemoteDataSource.getUsers(noParameters);
      return Right(result);
    }on ServerException catch(failure){
      return Left(ServerFailure(failure.errorMessageModel.statueMessage));
    }
  }

  @override
  Future<Either<Failure, int>> addNewUser(AddNewUserParameters addNewUserParameters) async{
    try{
      final result = await authRemoteDataSource.addNewUser(addNewUserParameters);
      return Right(result);
    }on ServerException catch(failure){
      return Left(ServerFailure(failure.errorMessageModel.statueMessage));
    }
  }

  @override
  Future<Either<Failure, List<RoleEntity>>> getRoles(NoParameters noParameters) async
  {
    try{
      final result = await authRemoteDataSource.getRoles(noParameters);
      return Right(result);
    }on ServerException catch(failure){
      return Left(ServerFailure(failure.errorMessageModel.statueMessage));
    }
  }

  @override
  Future<Either<Failure, int>> addNewRole(AddNewRoleParameters addNewRoleParameters) async
  {
    try{
      final result = await authRemoteDataSource.addNewRole(addNewRoleParameters);
      return Right(result);
    }on ServerException catch(failure){
      return Left(ServerFailure(failure.errorMessageModel.statueMessage));
    }
  }

  @override
  Future<Either<Failure, int>> deleteUser(int deleteUserParameter) async
  {
    try {
      final result = await authRemoteDataSource.deleteUser(deleteUserParameter);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statueMessage));
    }
  }

  @override
  Future<Either<Failure, int>> editUser(EditUserParameters editUserParameters) async
  {
    try {
      final result = await authRemoteDataSource.editUser(editUserParameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statueMessage));
    }
  }

  @override
  Future<Either<Failure, int>> deleteRole(int deleteRoleParameter) async
  {
    try {
      final result = await authRemoteDataSource.deleteRole(deleteRoleParameter);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statueMessage));
    }
  }

  @override
  Future<Either<Failure, int>> editRole(EditRoleParameters editRoleParameters) async
  {
    try {
      final result = await authRemoteDataSource.editRole(editRoleParameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statueMessage));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> loginUser(LoginUserParameters loginUserParameters) async
  {
    try {
      final result = await authRemoteDataSource.loginUser(loginUserParameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statueMessage));
    }
  }

  // @override
  // Future<void> clearToken() {
  //   return authLocalDataSource.clearToken();
  // }
  //
  // @override
  // Future<Either<Failure,String>> getToken(NoParameters noParameters) async{
  //   try {
  //     final result = await authLocalDataSource.getToken(noParameters);
  //     return Right(result);
  //   } on ServerException catch (failure) {
  //     return Left(ServerFailure(failure.errorMessageModel.statueMessage));
  //   }
  // }
  //
  // @override
  // Future<void> saveToken(String token) {
  //   return authLocalDataSource.saveToken(token);
  // }





}