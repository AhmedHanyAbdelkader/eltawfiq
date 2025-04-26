import 'package:dartz/dartz.dart';
import 'package:eltawfiq_suppliers/core/error/failure.dart';
import 'package:eltawfiq_suppliers/suppliers_module/domain/entities/supplier_entity.dart';
import 'package:eltawfiq_suppliers/suppliers_module/domain/use_cases/add_new_supplier_use_case.dart';

abstract class SuppliersBaseRepository{
  Future<Either<Failure, List<SupplierEntity>>> getSuppliers(int id);
  Future<Either<Failure, int>> addNewSupplier(AddNewSupplierParameters addNewSupplierParameters);
}