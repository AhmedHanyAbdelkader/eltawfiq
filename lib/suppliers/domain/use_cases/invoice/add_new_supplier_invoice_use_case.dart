import 'package:dartz/dartz.dart';
import 'package:eltawfiq_suppliers/core/error/failure.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/invoice_item_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/repository/suppliers_base_repository.dart';
import 'package:equatable/equatable.dart';

class AddNewSupplierInvoiceUseCase extends BaseUseCase<int, Map<String,dynamic>>{
  SuppliersBaseRepository suppliersBaseRepository;
  AddNewSupplierInvoiceUseCase(this.suppliersBaseRepository);
  @override
  Future<Either<Failure, int>> call(Map<String,dynamic> parameter) async{
    return await suppliersBaseRepository.addNewInvoice(parameter);
  }

}


class AddNewSupplierInvoiceParameters extends Equatable{
  final String? invDate;
  final int? invSupplierId;
  final int? userId;
  final num? total;
  final num? payedAmount;
  final num? remainedAmount;
  final String? invoiceImageUrl;
  final List<InvoiceItemEntity>? invoiceItems;
  final String? type;
  final List<String>? images;

  const AddNewSupplierInvoiceParameters({
    this.invDate,
    this.invSupplierId,
    this.userId,
    this.total,
    this.payedAmount,
    this.remainedAmount,
    this.invoiceImageUrl,
    this.invoiceItems,
    this.type,
    this.images,
  });

  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = {};
    data['invDate'] = invDate;
    data['invSupplierId'] = invSupplierId;
    data['total'] = total;
    data['userId'] = userId;
    data['invoiceImageUrl'] = invoiceImageUrl;
    data['type'] = type;
    data['payedAmount'] = payedAmount;
    data['remainedAmount'] = remainedAmount;
    data['invoiceItems'] = invoiceItems;
    data['images'] = images;
    return data;
  }

  @override
  List<Object?> get props => [
    invDate,
    invSupplierId,
    userId,
    total,
    payedAmount,
    remainedAmount,
    invoiceImageUrl,
    invoiceItems,
    type,
    images
  ];
}


