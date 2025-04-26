
import 'package:dartz/dartz.dart';
import 'package:eltawfiq_suppliers/authentication/domain/entities/role_entity.dart';
import 'package:eltawfiq_suppliers/authentication/domain/repository/auth_base_repository.dart';
import 'package:eltawfiq_suppliers/core/error/failure.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';

class GetRolesUseCase extends BaseUseCase<List<RoleEntity>, NoParameters>
{
  AuthBaseRepository authBaseRepository;
  GetRolesUseCase(this.authBaseRepository);

  @override
  Future<Either<Failure, List<RoleEntity>>> call(NoParameters parameter) async
  {
    return await authBaseRepository.getRoles(parameter);
  }

}

