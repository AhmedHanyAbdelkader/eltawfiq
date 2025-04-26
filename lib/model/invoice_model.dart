import 'package:eltawfiq_suppliers/model/item_model.dart';
import 'package:eltawfiq_suppliers/model/payment_model.dart';
import 'package:eltawfiq_suppliers/model/supplier_model.dart';

class InvoiceModel {
  final int id;
  final String? invDate;
  final int? invSupplierId;
  final double? total;
  int? createdById;
  List<PaymentModel>? payments;
  List<ItemModel>? items;
  String? invoiceImageUrl;
  double? payedAmount;
  double? remainedAmount;
  SupplierModel? invoiceSupplier;

  InvoiceModel({
    required this.id,
    required this.invDate,
    required this.invSupplierId,
    required this.total,
    this.createdById,
    this.payments,
    this.items,
    this.invoiceImageUrl,
    this.payedAmount,
    this.remainedAmount,
    this.invoiceSupplier,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) => InvoiceModel(
    id: json['id'],
    invDate: json['inv_date'],
    invSupplierId: json['inv_supplier_id'],
    total: json['total'] != null ? double.parse(json['total']) : null, // Convert string to double
    createdById: json["created_by_id"],
    payments: json["payments"] == null ? null : (json["payments"] as List).map((e) => PaymentModel.fromJson(e)).toList(),
    items: json["items"] == null ? null : (json["items"] as List).map((e) => ItemModel.fromJson(e)).toList(),
    invoiceImageUrl: json['invoice_image_url'],
    payedAmount: json['payed_amount'] != null
        ? double.parse(json['payed_amount'])
        : null,
    remainedAmount: json['remained_amount'] != null
        ? double.parse(json['remained_amount'])
        : null,
    invoiceSupplier: json['supplier'] != null
        ? SupplierModel.fromJson(json['supplier'])
        : null,
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['inv_date'] = invDate;
    data['inv_supplier_id'] = invSupplierId;
    data['total'] = total?.toString(); // Convert double to string for serialization
    data['created_by_id'] = createdById;
    if (payments != null) {
      data['payments'] = payments?.map((e) => e.toJson()).toList();
    }
    if (items != null) {
      data['items'] = items?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}



class StoreInvoiceParameters {
  int invSupplierId;
  int createdById;
  double total;
  double payedAmount;
  double remainedAmount;
  List<ItemModel> items;
  String imagePath;


  StoreInvoiceParameters({
    required this.invSupplierId,
    required this.createdById,
    required this.total,
    required this.payedAmount,
    required this.remainedAmount,
    required this.items,
    required this.imagePath,
});

}