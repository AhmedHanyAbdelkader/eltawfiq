import 'package:dartz/dartz.dart';
import 'package:eltawfiq_suppliers/core/error/failure.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/item_history_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/repository/suppliers_base_repository.dart';
import 'package:equatable/equatable.dart';

class GetItemsHistoryUseCase extends BaseUseCase<List<ItemHistoryEntity>, GetItemHistoryParameters>{
  SuppliersBaseRepository suppliersBaseRepository;
  GetItemsHistoryUseCase(this.suppliersBaseRepository);
  @override
  Future<Either<Failure, List<ItemHistoryEntity>>> call(GetItemHistoryParameters parameter) async{
    return await suppliersBaseRepository.getItemHistory(parameter);
  }

}

class GetItemHistoryParameters extends Equatable{
  final int itemId;
  final int supplierId;

  const GetItemHistoryParameters({
    required this.itemId,
    required this.supplierId,
});

  // Map<String, dynamic> toJson(){
  //   Map<String, dynamic> data = {};
  //   data['itemId'] = itemId;
  //   data['supplierId'] = supplierId;
  //   return data;
  // }

  @override
  List<Object?> get props => [
    itemId,
    supplierId,
  ];
}