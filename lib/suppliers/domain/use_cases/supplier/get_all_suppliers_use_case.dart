import 'package:dartz/dartz.dart';
import 'package:eltawfiq_suppliers/core/error/failure.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/supplier_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/repository/suppliers_base_repository.dart';

class GetAllSuppliersUseCase extends BaseUseCase<List<SupplierEntity>, NoParameters>{
  SuppliersBaseRepository suppliersBaseRepository;
  GetAllSuppliersUseCase(this.suppliersBaseRepository);

  @override
  Future<Either<Failure, List<SupplierEntity>>> call(NoParameters parameter) async
  {
    return await suppliersBaseRepository.getSuppliers(parameter);
  }

}