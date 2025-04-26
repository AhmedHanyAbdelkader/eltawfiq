import 'package:dartz/dartz.dart';
import 'package:eltawfiq_suppliers/core/error/failure.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/repository/suppliers_base_repository.dart';
import 'package:equatable/equatable.dart';

class AddNewSupplierPaymentUseCase extends BaseUseCase<int,AddNewSupplierPaymentParameters>{
  SuppliersBaseRepository suppliersBaseRepository;
  AddNewSupplierPaymentUseCase(this.suppliersBaseRepository);

  @override
  Future<Either<Failure, int>> call(AddNewSupplierPaymentParameters parameter) async {
    return await suppliersBaseRepository.addNewSupplierPayment(parameter);
  }

}


class AddNewSupplierPaymentParameters extends Equatable{
  final int? supplierId;
  final num? payed;
  final num? remained;
  final String? date;
  final String? paymentImage;
  final String? type;

  const AddNewSupplierPaymentParameters({
    this.supplierId,
    this.payed,
    this.remained,
    this.date,
    this.paymentImage,
    this.type,
  });

  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = {};
    data['supplierId'] = supplierId;
    data['payedAmountFromSupplierTotal'] = payed;
    data['remainedAmountFromSupplierTotal'] = remained;
    data['paymentDate'] = date;
    data['paymentImage'] = paymentImage;
    data['type'] = type;
    return data;
  }


  @override
  List<Object?> get props => [
    supplierId,
    payed,
    remained,
    date,
    paymentImage,
  ];

}