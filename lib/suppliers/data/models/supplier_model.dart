import 'package:eltawfiq_suppliers/suppliers/data/models/bank_info_model.dart';
import 'package:eltawfiq_suppliers/suppliers/data/models/company_model.dart';
import 'package:eltawfiq_suppliers/suppliers/data/models/group_model.dart';
import 'package:eltawfiq_suppliers/suppliers/data/models/phone_model.dart';
import 'package:eltawfiq_suppliers/suppliers/data/models/section_model.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/supplier_entity.dart';

class SupplierModel extends SupplierEntity{
  const SupplierModel({
    super.id,
    super.supplierName,
    super.supplierFullName,
    super.supplierPostalCode,
    super.supplierPhoneNumbers,
    super.supplierWhatsappNumber,
    super.address,
    super.mapLocation,
    super.email,
    super.facebook,
    super.supplierTotal,
    super.supplierPayed,
    super.supplierRemained,
    super.notes,
    super.order,
    super.supplierPosition,
    super.company,
    super.group,
    super.section,
    super.bankInfos,
    super.isSup,
});



  factory SupplierModel.fromJson(Map<String, dynamic> json) =>
      SupplierModel(
        id: json['id'],
        supplierName: json['supplierName'],
        supplierFullName: json['supplierFullName'],
        supplierPostalCode: json['supplierPostalCode'],
        supplierPhoneNumbers: json['phones'] != null ? List.from(json['phones'].map((phone) => PhoneModel.fromJson(phone))) : null,
        supplierWhatsappNumber: json['supplierWhatsappNumber'],
        address: json['address'],
        mapLocation: json['mapLocation'],
        email: json['email'],
        facebook: json['facebook'],
        supplierTotal: json['supplierTotal'],
        supplierPayed: json['supplier_totalpaidto'],
        supplierRemained: json['supplier_totalpaidfrom'],
        notes: json['notes'],
        order: json['orderr'],
        supplierPosition: json['supplierPosition'],
        company: json['company'] != null ? CompanyModel.fromJson(json['company']) : null,
        group: json['group'] != null ? GroupModel.fromJson(json['group']) : null,
        section: json['section'] != null ? SectionModel.fromJson(json['section']) : null,
        bankInfos: json['bankInfos'] != null ? (json['bankInfos'] as List<dynamic>)
            .map((e) => BankInfoModel.fromJson(e as Map<String, dynamic>))
            .toList()
            : null,
        isSup: json['issupp'],
      );


}