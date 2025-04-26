import 'package:dartz/dartz.dart';
import 'package:eltawfiq_suppliers/core/error/failure.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/supplier_invoice_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/repository/suppliers_base_repository.dart';

class GetAllInvoicesUseCase extends BaseUseCase<List<SupplierInvoiceEntity>, NoParameters>{
  SuppliersBaseRepository suppliersBaseRepository;
  GetAllInvoicesUseCase(this.suppliersBaseRepository);
  @override
  Future<Either<Failure, List<SupplierInvoiceEntity>>> call(NoParameters parameter) async{
    return await suppliersBaseRepository.getInvoices(parameter);
  }

}