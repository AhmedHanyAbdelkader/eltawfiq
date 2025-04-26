import 'package:equatable/equatable.dart';

class ItemHistoryEntity extends Equatable{
  final String? itemName;
  final int? id;
  final int? invoiceId;
  final num? itemPrice;
  final String? date;
  final String? type;

  const ItemHistoryEntity({
    this.itemName,
    this.id,
    this.invoiceId,
    this.itemPrice,
    this.date,
    this.type,
});

  @override
  List<Object?> get props => [
    itemName,
    id,
    invoiceId,
    itemPrice,
    date,
    type,
  ];

}