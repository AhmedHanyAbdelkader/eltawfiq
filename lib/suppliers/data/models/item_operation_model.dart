import 'package:eltawfiq_suppliers/suppliers/domain/entities/item_operation_entity.dart';

class ItemOperationModel extends ItemOperationEntity{
  const ItemOperationModel({
    super.id,
    super.invoiceId,
    super.itemId,
    super.itemName,
    super.itemPrice,
    super.itemQuantity,
    super.itemTotal,
    super.permDate,
    super.type,
});

  factory ItemOperationModel.fromJson(Map<String, dynamic> json) =>
      ItemOperationModel(
        id: json['id'],
        itemName: json['itemName'],
        itemPrice: json['itemPrice'],
        itemQuantity: json['itemQuantity'],
        itemId: json['itemId'],
        itemTotal: json['itemTotal'],
        invoiceId: json['invoiceId'],
        permDate: json['permDate'],
        type: json['type'],
      );
}