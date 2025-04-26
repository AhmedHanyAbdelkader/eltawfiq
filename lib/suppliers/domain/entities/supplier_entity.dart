import 'package:eltawfiq_suppliers/suppliers/domain/entities/bank_info_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/company_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/group_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/phone_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/section_entity.dart';
import 'package:equatable/equatable.dart';

class SupplierEntity {
  final int? id;
  final String? supplierName;
  final String? supplierFullName;
  final String? supplierPostalCode;
  final List<PhoneEntity>? supplierPhoneNumbers;
  final String? supplierWhatsappNumber;
  final String? address;
  final String? mapLocation;
  final String? email;
  final String? facebook;
  final num? supplierTotal;
  final num? supplierPayed;
  final num? supplierRemained;
  final String? notes;
  final int? order;
  final List<BankInfoEntity>? bankInfos;
  final CompanyEntity? company;
  final GroupEntity? group;
  final String? supplierPosition;
  final SectionEntity? section;
  final bool? isSup;

  const SupplierEntity({
    this.id,
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
    this.supplierPosition,
    this.company,
    this.group,
    this.section,
    this.bankInfos,
    this.isSup,
});

  // @override
  // List<Object?> get props => [
  //   id,
  //   supplierName,
  //   supplierFullName,
  //   supplierPostalCode,
  //   //supplierPhoneNumbers,
  //   supplierWhatsappNumber,
  //   address,
  //   mapLocation,
  //   email,
  //   facebook,
  //   supplierTotal,
  //   supplierPayed,
  //   supplierRemained,
  //   notes,
  //   order,
  //   supplierPosition,
  //   company,
  //   group,
  //   section,
  //   bankInfos,
  // ];

}