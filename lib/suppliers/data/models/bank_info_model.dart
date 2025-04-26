import 'package:eltawfiq_suppliers/suppliers/domain/entities/bank_info_entity.dart';

class BankInfoModel extends BankInfoEntity{
  const BankInfoModel({
    super.id,
    super.supplierId,
    super.bankName,
    super.bankAccount,
});

  factory BankInfoModel.fromJson(Map<String, dynamic> json) =>
      BankInfoModel(
        id: json['id'],
        supplierId: json['supplierId'],
        bankName: json['bankName'],
        bankAccount: json['bankAccount'],
      );
}