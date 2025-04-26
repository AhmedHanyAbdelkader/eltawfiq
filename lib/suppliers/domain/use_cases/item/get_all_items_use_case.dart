import 'package:dartz/dartz.dart';
import 'package:eltawfiq_suppliers/core/error/failure.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/item_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/repository/suppliers_base_repository.dart';

class GetAllItemsUseCase extends BaseUseCase<List<ItemEntity>, NoParameters>{
  SuppliersBaseRepository suppliersBaseRepository;
  GetAllItemsUseCase(this.suppliersBaseRepository);
  @override
  Future<Either<Failure, List<ItemEntity>>> call(NoParameters parameter) async{
    return await suppliersBaseRepository.getItems(parameter);
  }

}