import 'package:dartz/dartz.dart';
import 'package:eltawfiq_suppliers/core/error/failure.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/supplier_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/repository/suppliers_base_repository.dart';

class GetSupplierUseCase extends BaseUseCase<SupplierEntity, int>{
  SuppliersBaseRepository suppliersBaseRepository;
  GetSupplierUseCase(this.suppliersBaseRepository);
  @override
  Future<Either<Failure, SupplierEntity>> call(int parameter) async{
    return await suppliersBaseRepository.getSupplier(parameter);
  }

}