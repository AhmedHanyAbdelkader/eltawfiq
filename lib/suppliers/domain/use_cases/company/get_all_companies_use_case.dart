import 'package:dartz/dartz.dart';
import 'package:eltawfiq_suppliers/core/error/failure.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/company_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/repository/suppliers_base_repository.dart';

class GetAllCompaniesUseCase extends BaseUseCase<List<CompanyEntity>, NoParameters>{
  SuppliersBaseRepository suppliersBaseRepository;
  GetAllCompaniesUseCase(this.suppliersBaseRepository);

  @override
  Future<Either<Failure, List<CompanyEntity>>> call(NoParameters parameter) async{
    return await suppliersBaseRepository.getCompanies(parameter);
  }


}