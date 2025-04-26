import 'package:dartz/dartz.dart';
import 'package:eltawfiq_suppliers/authentication/domain/entities/user_entity.dart';
import 'package:eltawfiq_suppliers/authentication/domain/repository/auth_base_repository.dart';
import 'package:eltawfiq_suppliers/core/error/failure.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';

class GetUsersUseCase extends BaseUseCase<List<UserEntity>, NoParameters>{
  AuthBaseRepository authBaseRepository;
  GetUsersUseCase(this.authBaseRepository);

  @override
  Future<Either<Failure, List<UserEntity>>> call(NoParameters parameter) async{
    return await authBaseRepository.getUsers(parameter);
  }

}