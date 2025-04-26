import 'package:equatable/equatable.dart';

class SupplierPaymentEntity extends Equatable{
  final int? id;
  final int? supplierId;
  final num? payedAmountFromSupplierTotal;
  final num? remainedAmountFromSupplierTotal;
  final String? paymentDate;
  final String? paymentImage;

  const SupplierPaymentEntity({
    this.id,
    this.supplierId,
    this.payedAmountFromSupplierTotal,
    this.remainedAmountFromSupplierTotal,
    this.paymentDate,
    this.paymentImage,
});

  @override
  List<Object?> get props => [
    id,
    supplierId,
    payedAmountFromSupplierTotal,
    remainedAmountFromSupplierTotal,
    paymentDate,
    paymentImage,
  ];
}