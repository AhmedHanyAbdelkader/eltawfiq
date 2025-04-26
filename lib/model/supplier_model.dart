// class SupplierModel {
//   final int supplierId;
//   final String supplierName;
//   final String? supplierFullName;
//   final String? supplierPostalCode;
//   final String? companyName;
//   final List<String>? supplierPhoneNumbers;
//   final String? supplierWhatsappNumber;
//   final String? address;
//   final String? mapLocation;
//   final String? email;
//   final String? facebook;
//   final String? notes;
//   final double? supplierTotal;
//   final double? supplierPayed;
//   final double? supplierRemained;
//   final List<BankInfo>? bankInfos;
//   final int order;
//
//   SupplierModel({
//     required this.supplierId,
//     required this.supplierName,
//     this.supplierFullName,
//     this.supplierPostalCode,
//     this.companyName,
//     this.supplierPhoneNumbers,
//     this.supplierWhatsappNumber,
//     this.address,
//     this.mapLocation,
//     this.email,
//     this.facebook,
//     this.notes,
//     this.supplierTotal,
//     this.supplierPayed,
//     this.supplierRemained,
//     this.bankInfos,
//     this.order = 0,
//   });
//
//   factory SupplierModel.fromJson(Map<String, dynamic> json) {
//     return SupplierModel(
//       supplierId: json['supplier_id'],
//       supplierName: json['supplier_name'],
//       supplierFullName: json['supplier_full_name'],
//       supplierPostalCode: json['supplier_postal_code'],
//       companyName: json['company_name'],
//       supplierPhoneNumbers: json['supplier_phone_numbers'] != null
//           ? List<String>.from(json['supplier_phone_numbers'])
//           : null,
//       supplierWhatsappNumber: json['supplier_whatsapp_number'],
//       address: json['address'],
//       mapLocation: json['map_location'],
//       email: json['email'],
//       facebook: json['facebook'],
//       //supplierTotal: json['supplier_total'] != null ? double.parse(json['supplier_total']) : null,
//       //supplierPayed: json['supplier_payed'] != null ? double.parse(json['supplier_payed']) : null,
//       //supplierRemained: json['supplier_remained'] != null ? double.parse(json['supplier_remained']) : null,
//       notes: json['notes'],
//       order: json['order'],
//       bankInfos: json['bank_infos'] != null
//           ? (json['bank_infos'] as List).map((i) => BankInfo.fromJson(i)).toList()
//           : null,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = {};
//     data['supplier_id'] = supplierId;
//     data['supplier_name'] = supplierName;
//     data['supplier_full_name'] = supplierFullName;
//     data['supplier_postal_code'] = supplierPostalCode;
//     data['company_name'] = companyName;
//     data['supplier_phone_numbers'] = supplierPhoneNumbers;
//     data['supplier_whatsapp_number'] = supplierWhatsappNumber;
//     data['address'] = address;
//     data['map_location'] = mapLocation;
//     data['email'] = email;
//     data['facebook'] = facebook;
//     data['notes'] = notes;
//     data['supplier_total'] = supplierTotal;
//     data['supplier_payed'] = supplierPayed;
//     data['supplier_remained'] = supplierRemained;
//     if (bankInfos != null) {
//       data['bank_infos'] = bankInfos!.map((bankInfo) => bankInfo.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class BankInfo {
//   // int? id;
//   // int? supplierId;
//   String? bankName;
//   String? bankAccount;
//
//   BankInfo({
//     //this.id, this.supplierId,
//     this.bankName, this.bankAccount});
//
//   factory BankInfo.fromJson(Map<String, dynamic> json) {
//     return BankInfo(
//       // id: json['id'],
//       // supplierId: json['supplier_id'],
//       bankName: json['bank_name'],
//       bankAccount: json['bank_account'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       // 'id': id,
//       // 'supplier_id': supplierId,
//       'bank_name': bankName,
//       'bank_account': bankAccount,
//     };
//   }
// }



import 'package:eltawfiq_suppliers/model/company_model.dart';
import 'package:eltawfiq_suppliers/model/group_model.dart';
import 'package:eltawfiq_suppliers/model/section_model.dart';

class SupplierModel {
  int? supplierId;
  String? supplierName;
  String? supplierFullName;
  String? supplierPostalCode;
  String? companyName;
  List<dynamic>? supplierPhoneNumbers;
  String? supplierWhatsappNumber;
  String? address;
  String? mapLocation;
  String? email;
  String? facebook;
  String? supplierTotal;
  String? supplierPayed;
  String? supplierRemained;
  String? notes;
  int? order;
  List<dynamic>? bankInfo;
  CompanyModel? company;
  GroupModel? group;
  String? supplierPosition;
  SectionModel? section;
  int? companyId;
  int? groupId;
  int? sectionId;

  SupplierModel({
    this.supplierId,
    this.supplierName,
    this.supplierFullName,
    this.supplierPostalCode,
    this.companyName,
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
    this.bankInfo,
    this.company,
    this.group,
    this.supplierPosition,
    this.section,
    this.companyId,
    this.groupId,
    this.sectionId,
  });




  factory SupplierModel.fromJson(Map<String, dynamic> json) => SupplierModel(
      supplierId : json["supplier_id"],
      supplierName : json["supplier_name"],
      supplierFullName : json["supplier_full_name"],
      supplierPostalCode : json["supplier_postal_code"],
      supplierPhoneNumbers : json["supplier_phone_numbers"],
      supplierWhatsappNumber : json["supplier_whatsapp_number"],
      address : json["address"],
      mapLocation : json["map_location"],
      email : json["email"],
      facebook : json["facebook"],
      supplierTotal : json["supplier_total"],
      supplierPayed : json["supplier_payed"],
      supplierRemained : json["supplier_remained"],
      notes : json["notes"],
      order : json["order"],
      bankInfo : json["bank_info"] ?? [], 
      company: json['company'] != null ? CompanyModel.fromJson(json['company']) : null,
      group: json['group'] != null ? GroupModel.fromJson(json['group']) : null,
      section: json['section'] != null ? SectionModel.fromJson(json['section']) : null,
      supplierPosition: json['supplier_position'],
  );


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['supplier_id'] = supplierId;
    data['supplier_name'] = supplierName;
    data['supplier_full_name'] = supplierFullName;
    data['supplier_postal_code'] = supplierPostalCode;
    //data['company_name'] = companyName;
    data['supplier_phone_numbers'] = supplierPhoneNumbers;
    data['supplier_whatsapp_number'] = supplierWhatsappNumber;
    data['address'] = address;
    data['map_location'] = mapLocation;
    data['email'] = email;
    data['facebook'] = facebook;
    data['notes'] = notes;
    data['supplier_total'] = supplierTotal;
    data['supplier_payed'] = supplierPayed;
    data['supplier_remained'] = supplierRemained;
    if (bankInfo != null) {
      data['bank_info'] = bankInfo!.map((bankInfo) => bankInfo.toJson()).toList();
    }
    data['order'] = order;
    data['supplier_position'] = supplierPosition;
    data['company_id'] = companyId;
    data['group_id'] = groupId;
    data['sec_id'] = sectionId;
    return data;
  }
}

class BankInfo {
  // int? id;
  // int? supplierId;
  String? bankName;
  String? bankAccount;

  BankInfo({
    // this.id, this.supplierId,
    this.bankName,
    this.bankAccount,
  });

  factory BankInfo.fromJson(Map<String, dynamic> json) {
    return BankInfo(
      // id: json['id'],
      // supplierId: json['supplier_id'],
      bankName: json['bank_name'] ?? '',
      bankAccount: json['bank_account'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      // 'supplier_id': supplierId,
      'bank_name': bankName,
      'bank_account': bankAccount,
    };
  }
}
