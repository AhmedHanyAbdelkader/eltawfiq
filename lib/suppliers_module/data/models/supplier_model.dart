import 'package:eltawfiq_suppliers/suppliers_module/domain/entities/supplier_entity.dart';

class SupplierModel extends SupplierEntity{

  const SupplierModel({
    super.address,
    super.bankInfo,
    super.company,
    super.companyId,
    super.companyName,
    super.email,
    super.facebook,
    super.group,
    super.groupId,
    super.mapLocation,
    super.notes,
    super.order,
    super.section,
    super.sectionId,
    super.supplierFullName,
    super.supplierId,
    super.supplierName,
    super.supplierPayed,
    super.supplierPhoneNumbers,
    super.supplierPosition,
    super.supplierPostalCode,
    super.supplierRemained,
    super.supplierTotal,
    super.supplierWhatsappNumber,
});


  factory SupplierModel.fromJson(Map<String,dynamic> json) =>
      SupplierModel(
        email: json[''],
        supplierId:  json[''],
        companyName:  json[''],
        supplierPosition:  json[''],
        sectionId:  json[''],
        groupId:  json[''],
        companyId:  json[''],
        company:  json[''],
        order:  json[''],
        notes:  json[''],
        facebook:  json[''],
        mapLocation:  json[''],
        address:  json[''],
        supplierWhatsappNumber:  json[''],
        supplierPhoneNumbers:  json[''],
        supplierFullName:  json[''],
        bankInfo:  json[''],
        group:  json[''],
        section:  json[''],
        supplierName:  json[''],
        supplierPayed:  json[''],
        supplierPostalCode:  json[''],
        supplierRemained:  json[''],
        supplierTotal:  json[''],
      );

}