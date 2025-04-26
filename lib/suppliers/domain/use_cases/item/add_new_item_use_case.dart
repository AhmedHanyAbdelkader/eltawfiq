import 'package:dartz/dartz.dart';
import 'package:eltawfiq_suppliers/core/error/failure.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/repository/suppliers_base_repository.dart';
import 'package:equatable/equatable.dart';

class AddNewItemUseCase extends BaseUseCase<int, AddNewItemParameters>{
  SuppliersBaseRepository suppliersBaseRepository;
  AddNewItemUseCase(this.suppliersBaseRepository);
  @override
  Future<Either<Failure, int>> call(AddNewItemParameters parameter) async{
    return await suppliersBaseRepository.addNewItem(parameter);
  }

}


class AddNewItemParameters extends Equatable{
  final String? itemName;
  final String? itemImageUrl;
  final int? sectionId;
  final num? purchasingPrice;
  final num? sellingPrice;
  final int? itemSupplierId;
  final String? barcode;
  final String? itemCode;
  final List<String>? images;

  final num? dasta;
  final num? kartona;
  final num? balanceKetaa;
  final num? balanceKartona;
  final num? balanceDasta;

  const AddNewItemParameters({
    this.itemName,
    this.itemImageUrl,
    this.sectionId,
    this.purchasingPrice,
    this.sellingPrice,
    this.itemSupplierId,
    this.barcode,
    this.itemCode,
    this.images,

    this.dasta,
    this.kartona,
    this.balanceKetaa,
    this.balanceKartona,
    this.balanceDasta,
  });

  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = {};
    data['itemName'] = itemName;
    data['purchasingPrice'] = purchasingPrice;
    data['sellingPrice'] = sellingPrice;
    data['itemSupplierId'] = itemSupplierId;
    data['barcode'] = barcode;
    data['itemCode'] = itemCode;
    data['itemOrder'] = 0;
    data['sectionId'] = sectionId;
    data['images'] = images;

    data ['dasta'] = dasta;
    data ['kartona'] = kartona;
    data ['balance_ketaa'] = balanceKetaa;
    data ['balance_kartona'] = balanceKartona;
    data ['balance_dasta'] = balanceDasta;

    return data;
  }


  @override
  List<Object?> get props => [
    itemName,
    itemImageUrl,
    sectionId,
    purchasingPrice,
    sellingPrice,
    itemSupplierId,
    barcode,
    itemCode,
    images,

    dasta,
    kartona,
    balanceKetaa,
    balanceKartona,
    balanceDasta,
  ];
}




