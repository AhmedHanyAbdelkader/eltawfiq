import 'package:eltawfiq_suppliers/suppliers/domain/entities/supplier_payment_entity.dart';

class SupplierPaymentModel extends SupplierPaymentEntity{
  const SupplierPaymentModel({
    super.id,
    super.supplierId,
    super.payedAmountFromSupplierTotal,
    super.remainedAmountFromSupplierTotal,
    super.paymentDate,
    super.paymentImage,
});

  factory SupplierPaymentModel.fromJson(Map<String, dynamic> json) =>
      SupplierPaymentModel(
        id: json['id'],
        supplierId: json['supplierId'],
        payedAmountFromSupplierTotal: json['payedAmountFromSupplierTotal'],
        remainedAmountFromSupplierTotal: json['remainedAmountFromSupplierTotal'],
        paymentDate: json['paymentDate'],
        paymentImage: json['paymentImage'],
      );

}