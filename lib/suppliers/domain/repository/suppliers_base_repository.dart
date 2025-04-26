import 'package:dartz/dartz.dart';
import 'package:eltawfiq_suppliers/authentication/data/models/search_result_model.dart';
import 'package:eltawfiq_suppliers/authentication/domain/entities/search_result_entity.dart';
import 'package:eltawfiq_suppliers/core/error/failure.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/company_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/group_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/item_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/item_history_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/item_operation_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/section_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/supplier_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/supplier_invoice_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/supplier_payment_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/company/add_new_company_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/company/edit_company_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/group/add_new_group_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/group/edit_group_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/item/add_new_item_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/item/edit_item_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/item/get_item_history_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/payment/add_new_supplier_payment_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/section/add_new_section_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/section/edit_section_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/supplier/add_new_supplier_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/supplier/edit_supplier_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/invoice/add_new_supplier_invoice_use_case.dart';

abstract class SuppliersBaseRepository {
  Future<Either<Failure, List<SupplierEntity>>> getClients(NoParameters noParameters);
  Future<Either<Failure, SupplierEntity>> getClient(int clientId);

  Future<Either<Failure, List<SupplierEntity>>> getSuppliers(NoParameters noParameters);
  Future<Either<Failure, SupplierEntity>> getSupplier(int supplierId);
  Future<Either<Failure, int>> addNewSupplier(AddNewSupplierParameter addNewSupplierParameter);
  Future<Either<Failure, int>> editSupplier(EditSupplierParameters editSupplierParameters);
  Future<Either<Failure, int>> deleteSupplier(int deleteSupplierParameter);
  Future<Either<Failure, List<SupplierPaymentEntity>>> getSupplierPayments(int supplierId);
  Future<Either<Failure, List<SupplierInvoiceEntity>>> getSupplierInvoices(int supplierId);
  Future<Either<Failure, List<ItemEntity>>> getSupplierItems(int supplierId);
  Future<Either<Failure, int>> addNewSupplierPayment(AddNewSupplierPaymentParameters addNewSupplierPaymentParameters);


  Future<Either<Failure, List<CompanyEntity>>> getCompanies(NoParameters noParameters);
  Future<Either<Failure, int>> addNewCompany(AddNewCompanyParameters addNewCompanyParameters);
  Future<Either<Failure, int>> editCompany(EditCompanyParameters editCompanyParameters);
  Future<Either<Failure, int>> deleteCompany(int deleteCompanyParameter);
  Future<Either<Failure, List<SupplierEntity>>> getCompanySuppliers(int companyIdParameter);


  Future<Either<Failure, List<GroupEntity>>> getGroups(NoParameters noParameters);
  Future<Either<Failure, int>> addNewGroup(AddNewGroupParameters addNewGroupParameters);
  Future<Either<Failure, int>> editGroup(EditGroupParameters editGroupParameters);
  Future<Either<Failure, int>> deleteGroup(int deleteGroupParameter);


  Future<Either<Failure, List<SectionEntity>>> getSections(NoParameters noParameters);
  Future<Either<Failure, int>> addNewSection(AddNewSectionParameters addNewSectionParameters);
  Future<Either<Failure, int>> editSection(UpdateSectionParameters updateSectionParameters);
  Future<Either<Failure, int>> deleteSection(int deleteSectionParameter);
  Future<Either<Failure, List<SupplierEntity>>> getSectionSuppliers(int sectionIdParameter);


  Future<Either<Failure, List<SupplierInvoiceEntity>>> getInvoices(NoParameters noParameters);
  Future<Either<Failure, SupplierInvoiceEntity>> getInvoiceById(int id);
  Future<Either<Failure, int>> addNewInvoice(Map<String,dynamic> addNewSupplierInvoiceParameters);


  Future<Either<Failure, List<ItemEntity>>> getItems(NoParameters noParameters);
  Future<Either<Failure, List<ItemHistoryEntity>>> getItemHistory(GetItemHistoryParameters getItemHistoryParameters);
  Future<Either<Failure, List<ItemEntity>>> getHotItems(int supplierId);
  Future<Either<Failure, int>> addNewItem(AddNewItemParameters addNewItemParameters);
  Future<Either<Failure, int>> deleteItem(int deleteItemParameter);
  Future<Either<Failure, int>> editItem(EditItemParameters editGroupParameters);
  Future<Either<Failure, List<ItemOperationEntity>>> getItemOperations(int itemId);
  Future<Either<Failure, ItemEntity>> getItemDetails(int itemId);

  Future<Either<Failure, SearchResultsEntity>> search(String query);





}