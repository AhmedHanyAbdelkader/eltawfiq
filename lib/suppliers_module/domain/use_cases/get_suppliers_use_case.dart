import 'package:dartz/dartz.dart';
import 'package:eltawfiq_suppliers/core/error/failure.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers_module/domain/entities/supplier_entity.dart';

import '../repository/suppliers_base_repository.dart';

class GetSuppliersUseCase extends BaseUseCase<List<SupplierEntity>, int>{
  SuppliersBaseRepository suppliersBaseRepository;
  GetSuppliersUseCase(this.suppliersBaseRepository);

  @override
  Future<Either<Failure, List<SupplierEntity>>> call(int parameter) async{
    return await suppliersBaseRepository.getSuppliers(parameter);
  }

}