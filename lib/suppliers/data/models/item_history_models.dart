import 'package:eltawfiq_suppliers/suppliers/domain/entities/item_history_entity.dart';

class ItemHistoryModel extends ItemHistoryEntity{
  const ItemHistoryModel({
    super.itemName,
    super.id,
    super.invoiceId,
    super.itemPrice,
    super.date,
    super.type,
});

  factory ItemHistoryModel.fromJson(Map<String, dynamic> json) =>
      ItemHistoryModel(
        itemName: json['itemName'],
        type: json['type'],
        id: json['id'],
        invoiceId: json['invoiceId'],
        itemPrice: json['itemPrice'],
        date: json['date'],
      );

}