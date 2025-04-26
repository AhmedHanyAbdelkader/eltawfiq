import 'package:dartz/dartz.dart';
import 'package:eltawfiq_suppliers/core/error/failure.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/repository/suppliers_base_repository.dart';

class DeleteCompanyUseCase extends BaseUseCase<int, int>{
  SuppliersBaseRepository suppliersBaseRepository;
  DeleteCompanyUseCase(this.suppliersBaseRepository);

  @override
  Future<Either<Failure, int>> call(int parameter) async {
    return await suppliersBaseRepository.deleteCompany(parameter);
  }

}