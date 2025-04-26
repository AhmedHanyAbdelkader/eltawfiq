import 'package:dartz/dartz.dart';
import 'package:eltawfiq_suppliers/core/error/failure.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/item_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/repository/suppliers_base_repository.dart';

class SupplierItemsUseCase extends BaseUseCase<List<ItemEntity>, int>{
  SuppliersBaseRepository suppliersBaseRepository;
  SupplierItemsUseCase(this.suppliersBaseRepository);
  @override
  Future<Either<Failure, List<ItemEntity>>> call(int parameter) async {
    return await suppliersBaseRepository.getSupplierItems(parameter);
  }

}