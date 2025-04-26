import 'package:eltawfiq_suppliers/authentication/domain/entities/user_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/invoice_item_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/supplier_entity.dart';

class SupplierInvoiceEntity {
  final int? id;
  final String? invDate;
  final int? invSupplierId;
  final int? userId;
  final num? total;
  final num? payedAmount;
  final num? remainedAmount;
  final String? invoiceImageUrl;
  final SupplierEntity? supplier;
  final UserEntity? user;
  final List<InvoiceItemEntity>? invoiceItems;
  final String? type;
  final List<String?>? images;

  const SupplierInvoiceEntity({
      this.id,
      this.invDate,
      this.invSupplierId,
      this.userId,
      this.total,
      this.payedAmount,
      this.remainedAmount,
      this.invoiceImageUrl,
      this.supplier,
      this.user,
      this.invoiceItems,
      this.type,
    this.images,
});

  // @override
  // List<Object?> get props => [
  //   id,
  //   invDate,
  //   invSupplierId,
  //   userId,
  //   total,
  //   payedAmount,
  //   remainedAmount,
  //   invoiceImageUrl,
  //   supplier,
  //   user,
  //   invoiceItems,
  // ];
}


