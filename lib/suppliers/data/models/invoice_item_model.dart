import 'package:eltawfiq_suppliers/suppliers/data/models/item_model.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/invoice_item_entity.dart';

class InvoiceItemModel extends InvoiceItemEntity{
  const InvoiceItemModel({
    super.id,
    super.invoiceId,
    super.itemId,
    super.item,
    super.itemQuantity,
    super.itemPrice,
    super.itemTotal,
    super.kartona,
    super.dasta,
    super.ketaa,
    super.type,

});

  factory InvoiceItemModel.fromJson(Map<String, dynamic> json) =>
      InvoiceItemModel(
        id: json['id'],
        invoiceId: json['invoiceId'],
        itemId: json['itemId'],
        item: json['item'] != null ? ItemModel.fromJson(json['item']) : null,
        itemQuantity: json['itemQuantity'],
        itemPrice: json['itemPrice'],
        itemTotal: json['itemTotal'],
        kartona: json['kartona'] != null ? json['kartona'] : null,
        dasta: json['dasta'] != null ? json['dasta'] : null,
        ketaa: json['ketaa'] != null ? json['ketaa'] : null,
        type: json['type'] != null ? json['type'] : null,
      );

}