import 'package:equatable/equatable.dart';

class ItemOperationEntity extends Equatable{
  final int? id;
  final int? itemId;
  final num? itemPrice;
  final num? itemTotal;
  final num? itemQuantity;
  final String? itemName;
  final int? invoiceId;
  final String? permDate;
  final String? type;

  const ItemOperationEntity({
    this.id,
    this.itemId,
    this.itemPrice,
    this.itemTotal,
    this.itemQuantity,
    this.itemName,
    this.invoiceId,
    this.permDate,
    this.type,
  });


  @override
  List<Object?> get props => [
    id,
    itemId,
    itemPrice,
    itemTotal,
    itemQuantity,
    itemName,
    invoiceId,
    permDate,
    type,
  ];


}