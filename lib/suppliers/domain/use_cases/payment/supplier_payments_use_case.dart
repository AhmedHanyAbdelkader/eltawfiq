import 'package:dartz/dartz.dart';
import 'package:eltawfiq_suppliers/core/error/failure.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/supplier_payment_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/repository/suppliers_base_repository.dart';

class SupplierPaymentsUseCase extends BaseUseCase<List<SupplierPaymentEntity>, int>{
  SuppliersBaseRepository suppliersBaseRepository;
  SupplierPaymentsUseCase(this.suppliersBaseRepository);
  @override
  Future<Either<Failure, List<SupplierPaymentEntity>>> call(int parameter) async {
    return await suppliersBaseRepository.getSupplierPayments(parameter);
  }

}