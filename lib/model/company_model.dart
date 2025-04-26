import 'package:eltawfiq_suppliers/model/supplier_model.dart';

class CompanyModel {
  final int? companyId;
  final String companyName;
  final String? companyDescription;
  List<SupplierModel>? suppliers;

  CompanyModel({
    this.companyId,
    required this.companyName,
    this.companyDescription,
     this.suppliers,
});

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
      companyId: json['company_id'],
      companyName: json['company_name'],
      companyDescription: json['company_description'],
      suppliers: _parseSuppliers(json['suppliers']),
  );


  static List<SupplierModel> _parseSuppliers(dynamic suppliersJson) {
    if (suppliersJson == null) {
      return [];
    }
    if (suppliersJson is List) {
      return suppliersJson.map((supplier) {
        if (supplier is Map<String, dynamic>) {
          return SupplierModel.fromJson(supplier);
        } else {
          throw TypeError();
        }
      }).toList();
    } else {
      throw TypeError();
    }
  }


  Map<String, dynamic> toJson() {
    return {
      'company_name': companyName,
      'company_description': companyDescription,
    };
  }

}

