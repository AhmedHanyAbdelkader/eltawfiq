import 'package:eltawfiq_suppliers/suppliers/domain/entities/company_entity.dart';

class CompanyModel extends CompanyEntity{

  const CompanyModel({
    super.id,
    super.companyName,
    super.companyDescription,
});

  factory CompanyModel.fromJson(Map<String, dynamic> json) =>
      CompanyModel(
        id: json['id'],
        companyName: json['companyName'],
        companyDescription: json['companyDescription'],
      );
}