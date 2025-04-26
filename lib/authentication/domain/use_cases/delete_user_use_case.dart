
import 'package:dartz/dartz.dart';
import 'package:eltawfiq_suppliers/authentication/domain/repository/auth_base_repository.dart';
import 'package:eltawfiq_suppliers/core/error/failure.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';

class DeleteUserUseCase extends BaseUseCase<int, int>{
  AuthBaseRepository authBaseRepository;
  DeleteUserUseCase(this.authBaseRepository);

  @override
  Future<Either<Failure, int>> call(int parameter) async
  {
    return await authBaseRepository.deleteUser(parameter);
  }

}