import 'package:eltawfiq_suppliers/authentication/data/models/search_result_model.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/data/models/company_model.dart';
import 'package:eltawfiq_suppliers/suppliers/data/models/group_model.dart';
import 'package:eltawfiq_suppliers/suppliers/data/models/item_history_models.dart';
import 'package:eltawfiq_suppliers/suppliers/data/models/item_model.dart';
import 'package:eltawfiq_suppliers/suppliers/data/models/item_operation_model.dart';
import 'package:eltawfiq_suppliers/suppliers/data/models/section_model.dart';
import 'package:eltawfiq_suppliers/suppliers/data/models/supplier_invoice_model.dart';
import 'package:eltawfiq_suppliers/suppliers/data/models/supplier_model.dart';
import 'package:eltawfiq_suppliers/suppliers/data/models/supplier_payment_model.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/item_history_entity.dart';
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

abstract class SuppliersRemoteDataSource {
  Future<List<SupplierModel>> getYourClients(NoParameters noParameters);
  Future<SupplierModel> getClient(int clientId);

  Future<List<SupplierModel>> getYourSuppliers(NoParameters noParameters);
  Future<SupplierModel> getSupplier(int supplierId);
  Future<int> addNewSupplier(AddNewSupplierParameter addNewSupplierParameter);
  Future<int>editSupplier(EditSupplierParameters editSupplierParameters);
  Future<int>deleteSupplier(int deleteSupplierParameters);
  Future<List<SupplierPaymentModel>> getSupplierPayments(int supplierId);
  Future<List<SupplierInvoiceModel>> getSupplierInvoices(int supplierId);
  Future<List<ItemModel>> getSupplierItems(int supplierId);
  Future<int> addNewSupplierPayment(AddNewSupplierPaymentParameters addNewSupplierPaymentParameters);

  Future<List<CompanyModel>> getCompanies(NoParameters noParameters);
  Future<int> addNewCompany(AddNewCompanyParameters addNewCompanyParameters);
  Future<int>editCompany(EditCompanyParameters editCompanyParameters);
  Future<int>deleteCompany(int deleteCompanyParameters);
  Future<List<SupplierModel>> getCompanySuppliers(int parameters);


  Future<List<GroupModel>> getGroups(NoParameters noParameters);
  Future<int> addNewGroup(AddNewGroupParameters addNewGroupParameters);
  Future<int>editGroup(EditGroupParameters editGroupParameters);
  Future<int>deleteGroup(int deleteGroupParameters);

  Future<List<SectionModel>> getSections(NoParameters noParameters);
  Future<int> addNewSection(AddNewSectionParameters addNewSectionParameters);
  Future<int>editSection(UpdateSectionParameters editSectionParameters);
  Future<int>deleteSection(int deleteSectionParameters);
  Future<List<SupplierModel>> getSectionSuppliers(int parameters);

  Future<List<SupplierInvoiceModel>> getInvoices(NoParameters noParameters);
  Future<SupplierInvoiceModel> getInvoiceById(int invId);
  Future<int> addNewInvoice(Map<String,dynamic> addNewSupplierInvoiceParameters);


  Future<List<ItemModel>> getItems(NoParameters noParameters);
  Future<List<ItemHistoryModel>> getItemHistory(GetItemHistoryParameters getItemHistoryParameters);
  Future<List<ItemModel>> getHotItems(int supplierId);
  Future<int> addNewItem(AddNewItemParameters addNewItemParameters);
  Future<int>deleteItem(int deleteItemParameters);
  Future<int>editItem(EditItemParameters editItemParameters);
  Future<List<ItemOperationModel>> getItemOperations(int itemId);
  Future<ItemModel> getItemDetails(int itemId);

  Future<SearchResultModel> search(String query);

}