import 'package:eltawfiq_suppliers/suppliers_module/data/models/supplier_model.dart';
import 'package:eltawfiq_suppliers/suppliers_module/domain/use_cases/add_new_supplier_use_case.dart';

abstract class SuppliersRemoteDataSource {
  Future<List<SupplierModel>> getYourSuppliers(int id);
  Future<int> addNewSupplier(AddNewSupplierParameters addNewSupplierParameters);
}