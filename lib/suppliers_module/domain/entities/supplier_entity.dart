import 'package:eltawfiq_suppliers/suppliers_module/domain/entities/company_entity.dart';
import 'package:eltawfiq_suppliers/suppliers_module/domain/entities/group_entity.dart';
import 'package:eltawfiq_suppliers/suppliers_module/domain/entities/section_entity.dart';
import 'package:equatable/equatable.dart';

class SupplierEntity extends Equatable{
  final int? supplierId;
  final String? supplierName;
  final String? supplierFullName;
  final String? supplierPostalCode;
  final String? companyName;
  final List<dynamic>? supplierPhoneNumbers;
  final String? supplierWhatsappNumber;
  final String? address;
  final String? mapLocation;
  final String? email;
  final String? facebook;
  final String? supplierTotal;
  final String? supplierPayed;
  final String? supplierRemained;
  final String? notes;
  final int? order;
  final List<dynamic>? bankInfo;
  final CompanyEntity? company;
  final GroupEntity? group;
  final String? supplierPosition;
  final SectionEntity? section;
  final int? companyId;
  final int? groupId;
  final int? sectionId;

  const SupplierEntity({
    this.supplierId,
    this.email,
    this.supplierName,
    this.companyName,
    this.company,
    this.notes,
    this.facebook,
    this.mapLocation,
    this.address,
    this.supplierWhatsappNumber,
    this.bankInfo,
    this.supplierPostalCode,
    this.supplierPhoneNumbers,
    this.supplierFullName,
    this.group,
    this.section,
    this.supplierPosition,
    this.groupId,
    this.sectionId,
    this.companyId,
    this.order,
    this.supplierPayed,
    this.supplierTotal,
    this.supplierRemained,
});


  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();


}