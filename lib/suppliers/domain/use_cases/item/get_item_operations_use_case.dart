import 'package:dartz/dartz.dart';
import 'package:eltawfiq_suppliers/core/error/failure.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/item_operation_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/repository/suppliers_base_repository.dart';

class GetItemOperationsUseCase extends BaseUseCase<List<ItemOperationEntity>, int>{
  SuppliersBaseRepository suppliersBaseRepository;
  GetItemOperationsUseCase(this.suppliersBaseRepository);

  @override
  Future<Either<Failure, List<ItemOperationEntity>>> call(int parameter) async{
    return await suppliersBaseRepository.getItemOperations(parameter);
  }

}