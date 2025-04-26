import 'package:dartz/dartz.dart';
import 'package:eltawfiq_suppliers/core/error/failure.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/repository/suppliers_base_repository.dart';
import 'package:equatable/equatable.dart';

class EditItemUseCase extends BaseUseCase<int, EditItemParameters>{
  SuppliersBaseRepository suppliersBaseRepository;
  EditItemUseCase(this.suppliersBaseRepository);
  @override
  Future<Either<Failure, int>> call(EditItemParameters parameter) async{
    return await suppliersBaseRepository.editItem(parameter);
  }

}


class EditItemParameters extends Equatable{
  final int? id;
  final String? itemName;
  final String? itemImageUrl;
  final int? sectionId;
  final num? purchasingPrice;
  final num? sellingPrice;
  final int? itemSupplierId;
  final String? barcode;
  final String? itemCode;
  final int? itemOrder;

  final num? dasta;
  final num? kartona;
  final num? balanceKetaa;
  final num? balanceKartona;
  final num? balanceDasta;


  const EditItemParameters({
    this.id,
    this.itemName,
    this.itemImageUrl,
    this.sectionId,
    this.purchasingPrice,
    this.sellingPrice,
    this.itemSupplierId,
    this.barcode,
    this.itemCode,
    this.itemOrder,

    this.dasta,
    this.kartona,
    this.balanceKetaa,
    this.balanceKartona,
    this.balanceDasta,
  });

  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = {};
    data['id'] = id;
    data['itemName'] = itemName;
    data['itemImageUrl'] = itemImageUrl;
    data['sectionId'] = sectionId;
    data['purchasingPrice'] = purchasingPrice;
    data['sellingPrice'] = sellingPrice;
    data['itemSupplierId'] = itemSupplierId;
    data['barcode'] = barcode;
    data['itemCode'] = itemCode;
    data['itemOrder'] = itemOrder;

    data['dasta'] = dasta;
    data['kartona'] = kartona;

    data['balance_ketaa'] = balanceKetaa;
    data['balance_kartona'] = balanceKartona;
    data['balance_dasta'] = balanceDasta;

    return data;
  }

  @override
  List<Object?> get props => [
    id,
    itemName,
    itemImageUrl,
    sectionId,
    purchasingPrice,
    sellingPrice,
    itemSupplierId,
    barcode,
    itemCode,
    itemOrder,

    dasta,
    kartona,

    balanceKetaa,
    balanceKartona,
    balanceDasta,
  ];
}