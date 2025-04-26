import 'package:eltawfiq_suppliers/authentication/data/models/user_model.dart';
import 'package:eltawfiq_suppliers/suppliers/data/models/invoice_item_model.dart';
import 'package:eltawfiq_suppliers/suppliers/data/models/supplier_model.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/supplier_invoice_entity.dart';

class SupplierInvoiceModel extends SupplierInvoiceEntity{
  const SupplierInvoiceModel({
    super.id,
    super.invDate,
    super.invSupplierId,
    super.supplier,
    super.userId,
    super.user,
    super.invoiceImageUrl,
    super.invoiceItems,
    super.total,
    super.payedAmount,
    super.remainedAmount,
    super.type,
    super.images,
});

  factory SupplierInvoiceModel.fromJson(Map<String, dynamic> json) =>
      SupplierInvoiceModel(
        id: json['id'],
        invDate: json['invDate'] != null ? json['invDate'] : null,
        invSupplierId: json['invSupplierId'],
        supplier: json['supplier'] != null ? SupplierModel.fromJson(json['supplier']) : null,
        user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
        userId: json['userId'] != null ? json['userId'] : null,
        invoiceImageUrl: json['invoiceImageUrl'],
        invoiceItems: json['invoiceItems'] != null ? List.from(json['invoiceItems'].map((invItem) => InvoiceItemModel.fromJson(invItem))) : null,
        total: json['total'],
        payedAmount: json['payedAmount'],
        remainedAmount: json['remainedAmount'],
        type: json['type'],
        images: json['images'] != null ? List<String>.from(json['images']) : null,
      );

}