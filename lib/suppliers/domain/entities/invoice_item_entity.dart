import 'package:eltawfiq_suppliers/suppliers/domain/entities/item_entity.dart';
import 'package:equatable/equatable.dart';

class InvoiceItemEntity extends Equatable{
  final int? id;
  final int? invoiceId;
  final int? itemId;
  final num? itemQuantity;
  final num? itemPrice;
  final num? itemTotal;
  final ItemEntity? item;

  final num? dasta;
  final num? kartona;
  final num? ketaa;
  final String? type;



  const InvoiceItemEntity({
    this.id,
    this.invoiceId,
    this.itemId,
    this.itemQuantity,
    this.itemPrice,
    this.itemTotal,
    this.item,
    this.dasta,
    this.kartona,
    this.ketaa,
    this.type,
  });

  @override
  List<Object?> get props => [
    id,
    invoiceId,
    itemId,
    itemQuantity,
    itemPrice,
    itemTotal,
    item,
    dasta,
    kartona,
    ketaa,
    type,
  ];

}




