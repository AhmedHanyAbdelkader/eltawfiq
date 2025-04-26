

import 'package:dartz/dartz.dart';
import 'package:eltawfiq_suppliers/core/error/failure.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/bank_info_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/repository/suppliers_base_repository.dart';
import 'package:equatable/equatable.dart';

class EditSupplierUseCase extends BaseUseCase<int, EditSupplierParameters>{
  SuppliersBaseRepository suppliersBaseRepository;
  EditSupplierUseCase(this.suppliersBaseRepository);

  @override
  Future<Either<Failure, int>> call(EditSupplierParameters parameter) async
  {
    return await suppliersBaseRepository.editSupplier(parameter);
  }

}


class EditSupplierParameters extends Equatable{
  final int? id;
  final String? supplierName;
  final String? supplierFullName;
  final String? supplierPostalCode;
  final List<String>? supplierPhoneNumbers;
  final String? supplierWhatsappNumber;
  final String? address;
  final String? mapLocation;
  final String? email;
  final String? facebook;
  final int? supplierTotal;
  final int? supplierPayed;
  final int? supplierRemained;
  final String? notes;
  final int? order;
  final List<BankInfoEntity>? bankInfos;
  final int? companyId;
  final int? groupId;
  final String? supplierPosition;
  final int? sectionId;

  const EditSupplierParameters({
    this.id,
    this.supplierPosition,
    this.notes,
    this.supplierRemained,
    this.supplierPayed,
    this.supplierTotal,
    this.facebook,
    this.email,
    this.mapLocation,
    this.address,
    this.supplierWhatsappNumber,
    this.supplierPhoneNumbers,
    this.supplierPostalCode,
    this.supplierFullName,
    this.supplierName,
    this.order,
    this.bankInfos,
    this.companyId,
    this.groupId,
    this.sectionId,
});

  Map<String, dynamic> toJson(){
    return {
      "supplierName": supplierName,
      "supplierFullName": supplierFullName,
      "supplierPostalCode": supplierPostalCode,
      "supplierPhoneNumbers": supplierPhoneNumbers,
      "supplierWhatsappNumber": supplierWhatsappNumber,
      "address": address,
      "mapLocation": mapLocation,
      "email": email,
      "facebook": facebook,
      "supplierTotal": supplierTotal,
      "supplierPayed": supplierPayed,
      "supplierRemained": supplierRemained,
      "notes": notes,
      "orderr": order,
      "companyId": companyId,
      "supplierPosition": supplierPosition,
      "groupId": groupId,
      "secId": sectionId,
    };
  }

  @override
  List<Object?> get props => [
    id,
    supplierPosition,
    notes,
    supplierRemained,
    supplierPayed,
    supplierTotal,
    facebook,
    email,
    mapLocation,
    address,
    supplierWhatsappNumber,
    supplierPhoneNumbers,
    supplierPostalCode,
    supplierFullName,
    supplierName,
    order,
    bankInfos,
    companyId,
    groupId,
    sectionId,
  ];
}