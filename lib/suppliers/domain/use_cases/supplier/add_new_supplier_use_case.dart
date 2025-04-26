import 'package:dartz/dartz.dart';
import 'package:eltawfiq_suppliers/core/error/failure.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/bank_info_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/phone_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/repository/suppliers_base_repository.dart';
import 'package:equatable/equatable.dart';

class AddNewSupplierUseCase extends BaseUseCase<int, AddNewSupplierParameter>{
  SuppliersBaseRepository suppliersBaseRepository;
  AddNewSupplierUseCase(this.suppliersBaseRepository);

  @override
  Future<Either<Failure, int>> call(AddNewSupplierParameter parameter) async{
    return await suppliersBaseRepository.addNewSupplier(parameter);
  }

}


class AddNewSupplierParameter extends Equatable{
  final String? supplierName;
  final String? supplierFullName;
  final String? supplierPostalCode;
  final List<PhoneEntity>? supplierPhoneNumbers;
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
  final bool issupp;

  const AddNewSupplierParameter({
  this.supplierName,
  this.supplierFullName,
  this.supplierPostalCode,
  this.supplierPhoneNumbers,
  this.supplierWhatsappNumber,
  this.address,
  this.mapLocation,
  this.email,
  this.facebook,
  this.supplierTotal,
  this.supplierPayed,
  this.supplierRemained,
  this.notes,
  this.order,
  this.bankInfos,
  this.companyId,
  this.groupId,
  this.supplierPosition,
  this.sectionId,
  required this.issupp,
  });

  Map<String, dynamic> toJson() {
    return {
      "supplierName": supplierName,
      "supplierFullName": supplierFullName,
      "supplierPostalCode": supplierPostalCode,
      "phones": supplierPhoneNumbers,
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
      "bankInfos": bankInfos,
      "issupp" : issupp,
    };
  }

  @override
  List<Object?> get props => [
    supplierName,
    supplierFullName,
    supplierPostalCode,
    supplierPhoneNumbers,
    supplierWhatsappNumber,
    address,
    mapLocation,
    email,
    facebook,
    supplierTotal,
    supplierPayed,
    supplierRemained,
    notes,
    order,
    bankInfos,
    companyId,
    groupId,
    supplierPosition,
    sectionId,
    issupp,
  ];
}

