import 'package:equatable/equatable.dart';

class BankInfoEntity extends Equatable{
  final int? id;
  final int? supplierId;
  final String? bankName;
  final String? bankAccount;

  const BankInfoEntity({
    this.id,
    this.supplierId,
    this.bankName,
    this.bankAccount,
});

  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = {};
    data['bankName'] = bankName;
    data['bankAccount'] = bankAccount;
    return data;
  }

  @override
  List<Object?> get props => [
    id,
    supplierId,
    bankName,
    bankAccount,
  ];
}