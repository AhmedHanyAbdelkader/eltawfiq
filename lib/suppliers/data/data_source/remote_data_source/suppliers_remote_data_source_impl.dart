import 'dart:convert';
import 'package:eltawfiq_suppliers/authentication/data/models/search_result_model.dart';
import 'package:eltawfiq_suppliers/core/error/exceptions.dart';
import 'package:eltawfiq_suppliers/core/network/api_constance.dart';
import 'package:eltawfiq_suppliers/core/network/error_message_model.dart';
import 'package:eltawfiq_suppliers/core/network/network_info.dart';
import 'package:eltawfiq_suppliers/core/resources/string_manager.dart';
import 'package:eltawfiq_suppliers/core/shared_methods/handle_error_response_function.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/data/data_source/remote_data_source/suppliers_remote_data_source.dart';
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
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class SuppliersRemoteDataSourceImpl implements SuppliersRemoteDataSource{

  final http.Client client;
  final NetworkInfo networkInfo;

  SuppliersRemoteDataSourceImpl({required this.client, required this.networkInfo});

  @override
  Future<int> addNewSupplier(AddNewSupplierParameter addNewSupplierParameter) async{
    if (await networkInfo.isConnected) {
      final response = await client.post(
        Uri.parse(ApiConstance.suppliersEndPoint),
        headers: {
          'Content-Type': 'application/json',
          //'token' : token
        },
        body: json.encode(addNewSupplierParameter),
      );

      return response.statusCode == 201
          ? _handleCreateSupplierSuccessResponse(response)
          : handleErrorResponse(response);
    }
    else {
      throw NoInternetException(
          errorMessageModel: ErrorMessageModel(
              statueMessage: StringManager.noInternet,
              statusCode: 505
          )
      );
    }
  }
  Future<int> _handleCreateSupplierSuccessResponse(http.Response response) async {
    return response.statusCode;
  }

  @override
  Future<SupplierModel> getSupplier(int supplierId) async{
    if (await networkInfo.isConnected) {
      final response = await client.get(
        Uri.parse(ApiConstance.supplierEndPoint(supplierId)),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      return response.statusCode == 200
          ? _handleGetSupplierSuccessResponse(response)
          : handleErrorResponse(response);
    }
    else {
      throw NoInternetException(
          errorMessageModel: ErrorMessageModel(
              statueMessage: StringManager.noInternet,
              statusCode: 505
          )
      );
    }
  }

  Future<SupplierModel> _handleGetSupplierSuccessResponse(http.Response response) async{
    var jsn = json.decode(response.body);
    SupplierModel supplierModel = SupplierModel.fromJson(jsn);
    return supplierModel;
  }

  @override
  Future<int> deleteSupplier(int deleteSupplierParameters) async{
    if (await networkInfo.isConnected) {
      final response = await client.delete(
        Uri.parse(ApiConstance.deleteSupplierEndPoint(deleteSupplierParameters)),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      return response.statusCode == 204
          ? await _handleDeleteSupplierSuccessResponse(response)
          : handleErrorResponse(response);
    }
    else {
      throw NoInternetException(
        errorMessageModel: ErrorMessageModel(
          statueMessage: StringManager.noInternet,
          statusCode: 505,
        ),
      );
    }
  }
  Future<int> _handleDeleteSupplierSuccessResponse(http.Response response) async
  {
    return response.statusCode;
  }

  @override
  Future<int> editSupplier(EditSupplierParameters editSupplierParameters) async{
    if (await networkInfo.isConnected) {
      final response = await client.put(
        Uri.parse(ApiConstance.editSupplierEndPoint(editSupplierParameters.id!)),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(editSupplierParameters),
      );
      return response.statusCode == 204
          ? await _handleEditSupplierSuccessResponse(response)
          : handleErrorResponse(response);
    }
    else {
      throw NoInternetException(
        errorMessageModel: ErrorMessageModel(
          statueMessage: StringManager.noInternet,
          statusCode: 505,
        ),
      );
    }
  }

  Future<int> _handleEditSupplierSuccessResponse(http.Response response) async{
    return response.statusCode;
  }

  @override
  Future<List<SupplierModel>> getYourSuppliers(NoParameters noParameters) async{
    if (await networkInfo.isConnected) {
      final response = await client.get(
        Uri.parse(ApiConstance.suppliersEndPoint),
        headers: {
          'Content-Type': 'application/json',
          //'token' : token
        },
      );

      return response.statusCode == 200
          ? _handleSuppliersSuccessResponse(response) : handleErrorResponse(response);
    }
    else {
      throw NoInternetException(
          errorMessageModel: ErrorMessageModel(
              statueMessage: StringManager.noInternet,
              statusCode: 505
          )
      );
    }
  }
  Future<List<SupplierModel>> _handleSuppliersSuccessResponse(http.Response response) async {
    List jsn = json.decode(response.body);
    return List.from(jsn.map((supplier) => SupplierModel.fromJson(supplier)));
  }


  @override
  Future<List<SupplierModel>> getYourClients(NoParameters noParameters) async{
    if (await networkInfo.isConnected) {
      final response = await client.get(
        Uri.parse(ApiConstance.clientsEndPoint),
        headers: {
          'Content-Type': 'application/json',
          //'token' : token
        },
      );

      return response.statusCode == 200
          ? _handleSuppliersSuccessResponse(response) : handleErrorResponse(response);
    }
    else {
      throw NoInternetException(
          errorMessageModel: ErrorMessageModel(
              statueMessage: StringManager.noInternet,
              statusCode: 505
          )
      );
    }
  }

  @override
  Future<List<CompanyModel>> getCompanies(NoParameters noParameters) async{
    if (await networkInfo.isConnected) {
      final response = await client.get(
        Uri.parse(ApiConstance.companiesEndPoint),
        headers: {
          'Content-Type': 'application/json',
          //'token' : token
        },
      );

      return response.statusCode == 200
          ? _handleGetCompaniesSuccessResponse(response) : handleErrorResponse(response);
    }
    else {
      throw NoInternetException(
          errorMessageModel: ErrorMessageModel(
              statueMessage: StringManager.noInternet,
              statusCode: 505
          )
      );
    }
  }
  Future<List<CompanyModel>> _handleGetCompaniesSuccessResponse(http.Response response) async {
    List jsn = json.decode(response.body);
    return List.from(jsn.map((comp) => CompanyModel.fromJson(comp)));
  }

  @override
  Future<int> deleteCompany(int deleteCompanyParameters) async {
    if (await networkInfo.isConnected) {
      final response = await client.delete(
        Uri.parse(ApiConstance.deleteCompanyEndPoint(deleteCompanyParameters)),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      return response.statusCode == 204
          ? await _handleDeleteCompanySuccessResponse(response)
          : handleErrorResponse(response);
    }
    else {
      throw NoInternetException(
        errorMessageModel: ErrorMessageModel(
          statueMessage: StringManager.noInternet,
          statusCode: 505,
        ),
      );
    }
  }
  Future<int> _handleDeleteCompanySuccessResponse(http.Response response) async {
    return response.statusCode;
  }

  @override
  Future<int> editCompany(EditCompanyParameters editCompanyParameters) async{
    if (await networkInfo.isConnected) {
      final response = await client.put(
        Uri.parse(ApiConstance.editCompanyEndPoint(editCompanyParameters.id!)),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(editCompanyParameters.toJson()),
      );
      return response.statusCode == 204
          ? await _handleEditCompanySuccessResponse(response)
          : handleErrorResponse(response);
    }
    else {
      throw NoInternetException(
        errorMessageModel: ErrorMessageModel(
          statueMessage: StringManager.noInternet,
          statusCode: 505,
        ),
      );
    }
  }
  Future<int> _handleEditCompanySuccessResponse(http.Response response) async{
    return response.statusCode;
  }

  @override
  Future<int> addNewCompany(AddNewCompanyParameters addNewCompanyParameters) async{
    if (await networkInfo.isConnected) {
      final response = await client.post(
        Uri.parse(ApiConstance.companiesEndPoint),
        headers: {
          'Content-Type': 'application/json',
          //'token' : token
        },
        body: json.encode(addNewCompanyParameters),
      );

      return response.statusCode == 201
          ? _handleAddNewCompanySuccessResponse(response)
          : handleErrorResponse(response);
    }
    else {
      throw NoInternetException(
          errorMessageModel: ErrorMessageModel(
              statueMessage: StringManager.noInternet,
              statusCode: 505
          )
      );
    }
  }
  Future<int> _handleAddNewCompanySuccessResponse(http.Response response) async {
    return response.statusCode;
  }

  @override
  Future<int> addNewGroup(AddNewGroupParameters addNewGroupParameters)  async{
    if (await networkInfo.isConnected) {
      final response = await client.post(
        Uri.parse(ApiConstance.groupsEndPoint),
        headers: {
          'Content-Type': 'application/json',
          //'token' : token
        },
        body: json.encode(addNewGroupParameters),
      );

      return response.statusCode == 201
          ? _handleAddNewGroupSuccessResponse(response)
          : handleErrorResponse(response);
    }
    else {
      throw NoInternetException(
          errorMessageModel: ErrorMessageModel(
              statueMessage: StringManager.noInternet,
              statusCode: 505
          )
      );
    }
  }
  Future<int> _handleAddNewGroupSuccessResponse(http.Response response) async {
    return response.statusCode;
  }

  @override
  Future<int> deleteGroup(int deleteGroupParameters) async{
    if (await networkInfo.isConnected) {
      final response = await client.delete(
        Uri.parse(ApiConstance.deleteGroupEndPoint(deleteGroupParameters)),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      return response.statusCode == 204
          ? await _handleDeleteGroupSuccessResponse(response)
          : handleErrorResponse(response);
    }
    else {
      throw NoInternetException(
        errorMessageModel: ErrorMessageModel(
          statueMessage: StringManager.noInternet,
          statusCode: 505,
        ),
      );
    }
  }
  Future<int> _handleDeleteGroupSuccessResponse(http.Response response) async{
    return response.statusCode;
  }

  @override
  Future<int> editGroup(EditGroupParameters editGroupParameters) async{
    if (await networkInfo.isConnected) {
      final response = await client.put(
        Uri.parse(ApiConstance.editGroupEndPoint(editGroupParameters.id!)),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(editGroupParameters),
      );
      return response.statusCode == 204
          ? await _handleEditGroupSuccessResponse(response)
          : handleErrorResponse(response);
    }
    else {
      throw NoInternetException(
        errorMessageModel: ErrorMessageModel(
          statueMessage: StringManager.noInternet,
          statusCode: 505,
        ),
      );
    }
  }
  Future<int> _handleEditGroupSuccessResponse(http.Response response) async{
    return response.statusCode;
  }

  @override
  Future<List<GroupModel>> getGroups(NoParameters noParameters) async{
    if (await networkInfo.isConnected) {
      final response = await client.get(
        Uri.parse(ApiConstance.groupsEndPoint),
        headers: {
          'Content-Type': 'application/json',
          //'token' : token
        },
      );

      return response.statusCode == 200
          ? _handleGetGroupsSuccessResponse(response) : handleErrorResponse(response);
    }
    else {
      throw NoInternetException(
          errorMessageModel: ErrorMessageModel(
              statueMessage: StringManager.noInternet,
              statusCode: 505
          )
      );
    }
  }
  Future<List<GroupModel>> _handleGetGroupsSuccessResponse(http.Response response) async {
    List jsn = json.decode(response.body);
    return List.from(jsn.map((comp) => GroupModel.fromJson(comp)));
  }

  @override
  Future<int> addNewSection(AddNewSectionParameters addNewSectionParameters) async{
    if (await networkInfo.isConnected) {
      final response = await client.post(
        Uri.parse(ApiConstance.sectionsEndPoint),
        headers: {
          'Content-Type': 'application/json',
          //'token' : token
        },
        body: json.encode(addNewSectionParameters.toJson()),
      );

      return response.statusCode == 201
          ? _handleAddNewSectionSuccessResponse(response)
          : handleErrorResponse(response);
    }
    else {
      throw NoInternetException(
          errorMessageModel: ErrorMessageModel(
              statueMessage: StringManager.noInternet,
              statusCode: 505
          )
      );
    }
  }
  Future<int> _handleAddNewSectionSuccessResponse(http.Response response) async {
    return response.statusCode;
  }

  @override
  Future<int> deleteSection(int deleteSectionParameters) async{
    if (await networkInfo.isConnected) {
      final response = await client.delete(
        Uri.parse(ApiConstance.deleteSectionsEndPoint(deleteSectionParameters)),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      return response.statusCode == 204
          ? await _handleDeleteSectionSuccessResponse(response)
          : handleErrorResponse(response);
    }
    else {
      throw NoInternetException(
        errorMessageModel: ErrorMessageModel(
          statueMessage: StringManager.noInternet,
          statusCode: 505,
        ),
      );
    }
  }
  Future<int> _handleDeleteSectionSuccessResponse(http.Response response) async{
    return response.statusCode;
  }


  @override
  Future<int> editSection(UpdateSectionParameters editSectionParameters) async{
    if (await networkInfo.isConnected) {
      final response = await client.put(
        Uri.parse(ApiConstance.editSectionsEndPoint(editSectionParameters.id!)),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(editSectionParameters.toJson()),
      );
      return response.statusCode == 204
          ? await _handleEditSectionSuccessResponse(response)
          : handleErrorResponse(response);
    }
    else {
      throw NoInternetException(
        errorMessageModel: ErrorMessageModel(
          statueMessage: StringManager.noInternet,
          statusCode: 505,
        ),
      );
    }
  }
  Future<int> _handleEditSectionSuccessResponse(http.Response response) async{
    return response.statusCode;
  }


  @override
  Future<List<SectionModel>> getSections(NoParameters noParameters) async{
    if (await networkInfo.isConnected) {
      final response = await client.get(
        Uri.parse(ApiConstance.sectionsEndPoint),
        headers: {
          'Content-Type': 'application/json',
          //'token' : token
        },
      );

      return response.statusCode == 200
          ? _handleGetSectionsSuccessResponse(response) : handleErrorResponse(response);
    }
    else {
      throw NoInternetException(
          errorMessageModel: ErrorMessageModel(
              statueMessage: StringManager.noInternet,
              statusCode: 505
          )
      );
    }
  }
  Future<List<SectionModel>> _handleGetSectionsSuccessResponse(http.Response response) async {
    List jsn = json.decode(response.body);
    return List.from(jsn.map((comp) => SectionModel.fromJson(comp)));
  }

  @override
  Future<List<SupplierInvoiceModel>> getInvoices(NoParameters noParameters) async
  {
    if (await networkInfo.isConnected) {
      final response = await client.get(
        Uri.parse(ApiConstance.invoicesEndPoint),
        headers: {
          'Content-Type': 'application/json',
          //'token' : token
        },
      );


      return response.statusCode == 200
          ? _handleGetInvoicesSuccessResponse(response) : handleErrorResponse(response);
    }
    else {
      throw NoInternetException(
          errorMessageModel: ErrorMessageModel(
              statueMessage: StringManager.noInternet,
              statusCode: 505
          )
      );
    }
  }
  Future<List<SupplierInvoiceModel>> _handleGetInvoicesSuccessResponse(http.Response response) async {
    List jsn = json.decode(response.body);
    print(jsn);
    List<SupplierInvoiceModel> invoices = List<SupplierInvoiceModel>.from(jsn.map((inv) => SupplierInvoiceModel.fromJson(inv)));
    return invoices;
  }

  @override
  Future<SupplierInvoiceModel> getInvoiceById(int invId) async {
    if (await networkInfo.isConnected) {
      final response = await client.get(
        Uri.parse(ApiConstance.invoiceByIdEndPoint(invId)),
        headers: {
          'Content-Type': 'application/json',
          //'token' : token
        },
      );

      return response.statusCode == 200
          ? _handleGetInvoiceByIdSuccessResponse(response) : handleErrorResponse(response);
    }
    else {
      throw NoInternetException(
          errorMessageModel: ErrorMessageModel(
              statueMessage: StringManager.noInternet,
              statusCode: 505
          )
      );
    }
  }
  Future<SupplierInvoiceModel> _handleGetInvoiceByIdSuccessResponse(http.Response response) async {
    var jsn = json.decode(response.body);
    return SupplierInvoiceModel.fromJson(jsn);
  }

  @override
  Future<int> addNewInvoice(Map<String,dynamic> addNewSupplierInvoiceParameters) async {
  if (await networkInfo.isConnected) {
  final response = await client.post(
  Uri.parse(ApiConstance.invoicesEndPoint),
  headers: {
  'Content-Type': 'application/json',
  //'token' : token
  },
  body: json.encode(addNewSupplierInvoiceParameters),
  );

  return response.statusCode == 201
  ? _handleAddNewSupplierInvoiceSuccessResponse(response)
      : handleErrorResponse(response);
  }
  else {
  throw NoInternetException(
  errorMessageModel: ErrorMessageModel(
  statueMessage: StringManager.noInternet,
  statusCode: 505
  )
  );
  }
}
  Future<int> _handleAddNewSupplierInvoiceSuccessResponse(http.Response response) async {
    print('response.bodyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
    print(response.body);
    var jsn = json.decode(response.body);
    return jsn['id'];
    //return response.statusCode;
}

  @override
  Future<List<ItemModel>> getItems(NoParameters noParameters) async {
    if (await networkInfo.isConnected) {
      final response = await client.get(
        Uri.parse(ApiConstance.itemsEndPoint),
        headers: {
          'Content-Type': 'application/json',
          //'token' : token
        },
      ).timeout(const Duration(seconds: 30)); // Set timeout duration;

      return response.statusCode == 200
          ? _handleGetItemsSuccessResponse(response) : handleErrorResponse(response);
    }
    else {
      throw NoInternetException(
          errorMessageModel: ErrorMessageModel(
              statueMessage: StringManager.noInternet,
              statusCode: 505
          )
      );
    }
  }
  Future<List<ItemModel>> _handleGetItemsSuccessResponse(http.Response response) async {
    List jsn = json.decode(response.body);
    return List.from(jsn.map((item) => ItemModel.fromJson(item)));
  }


  @override
  Future<ItemModel> getItemDetails(int itemId) async{
    if (await networkInfo.isConnected) {
      final response = await client.get(
        Uri.parse(ApiConstance.itemDetailsEndPoint(itemId)),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      return response.statusCode == 200
          ? _handleGetItemDetailsSuccessResponse(response) : handleErrorResponse(response);
    }
    else {
      throw NoInternetException(
          errorMessageModel: ErrorMessageModel(
              statueMessage: StringManager.noInternet,
              statusCode: 505
          )
      );
    }
  }

  Future<ItemModel> _handleGetItemDetailsSuccessResponse(http.Response response) async {
    final jsn = json.decode(response.body);
    return ItemModel.fromJson(jsn);
  }

  @override
  Future<int> addNewItem(AddNewItemParameters addNewItemParameters) async{
    if (await networkInfo.isConnected) {
      final response = await client.post(
        Uri.parse(ApiConstance.itemsEndPoint),
        headers: {
          'Content-Type': 'application/json',
          //'token' : token
        },
        body: json.encode(addNewItemParameters.toJson()),
      );
      return response.statusCode == 201
          ? _handleAddNewItemSuccessResponse(response)
          : handleErrorResponse(response);
    }
    else {
      throw NoInternetException(
          errorMessageModel: ErrorMessageModel(
              statueMessage: StringManager.noInternet,
              statusCode: 505
          )
      );
    }
  }
  Future<int> _handleAddNewItemSuccessResponse(http.Response response) async {
    return response.statusCode;
  }

  @override
  Future<int> deleteItem(int deleteItemParameters) async {
  if (await networkInfo.isConnected) {
  final response = await client.delete(
  Uri.parse(ApiConstance.deleteItemEndPoint(deleteItemParameters)),
  headers: {
  'Content-Type': 'application/json',
  },
  );
  return response.statusCode == 204
  ? await _handleDeleteItemSuccessResponse(response)
      : handleErrorResponse(response);
  }
  else {
  throw NoInternetException(
  errorMessageModel: ErrorMessageModel(
  statueMessage: StringManager.noInternet,
  statusCode: 505,
  ),
  );
  }
}
Future<int> _handleDeleteItemSuccessResponse(http.Response response) async{
  return response.statusCode;
}

  @override
  Future<int> editItem(EditItemParameters editItemParameters) async{
    if (await networkInfo.isConnected) {
      final response = await client.put(
        Uri.parse(ApiConstance.editItemEndPoint(editItemParameters.id!)),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(editItemParameters.toJson()),
      );
      return response.statusCode == 204
          ? await _handleEditItemSuccessResponse(response)
          : handleErrorResponse(response);
    }
    else {
      throw NoInternetException(
        errorMessageModel: ErrorMessageModel(
          statueMessage: StringManager.noInternet,
          statusCode: 505,
        ),
      );
    }
  }
  Future<int> _handleEditItemSuccessResponse(http.Response response) async{
    return response.statusCode;
  }

  @override
  Future<List<SupplierModel>> getCompanySuppliers(int parameters) async
  {
    if (await networkInfo.isConnected) {
      final response = await client.get(
        Uri.parse(ApiConstance.companySuppliersEndPoint(parameters)),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      return response.statusCode == 200
          ? _handleSuppliersSuccessResponse(response) : handleErrorResponse(response);
    }
    else {
      throw NoInternetException(
          errorMessageModel: ErrorMessageModel(
              statueMessage: StringManager.noInternet,
              statusCode: 505
          )
      );
    }
  }

  @override
  Future<List<SupplierModel>> getSectionSuppliers(int parameters) async
  {
    if (await networkInfo.isConnected) {
      final response = await client.get(
        Uri.parse(ApiConstance.sectionSuppliersEndPoint(parameters)),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      return response.statusCode == 200
          ? _handleSuppliersSuccessResponse(response) : handleErrorResponse(response);
    }
    else {
      throw NoInternetException(
          errorMessageModel: ErrorMessageModel(
              statueMessage: StringManager.noInternet,
              statusCode: 505
          )
      );
    }
  }

  @override
  Future<List<SupplierPaymentModel>> getSupplierPayments(int supplierId) async {
    if (await networkInfo.isConnected) {
      final response = await client.get(
        Uri.parse(ApiConstance.supplierPayments(supplierId)),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      return response.statusCode == 200
          ? _handleSupplierPaymentsSuccessResponse(response) : handleErrorResponse(response);
    }
    else {
      throw NoInternetException(
          errorMessageModel: ErrorMessageModel(
              statueMessage: StringManager.noInternet,
              statusCode: 505
          )
      );
    }
  }

  Future<List<SupplierPaymentModel>> _handleSupplierPaymentsSuccessResponse(http.Response response) async{
    List jsn = json.decode(response.body);
    return List.from(jsn.map((payment) => SupplierPaymentModel.fromJson(payment)));
  }

  @override
  Future<List<SupplierInvoiceModel>> getSupplierInvoices(int supplierId) async {
    if (await networkInfo.isConnected) {
      final response = await client.get(
        Uri.parse(ApiConstance.supplierInvoices(supplierId)),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      return response.statusCode == 200
          ? _handleSupplierInvoiceSuccessResponse(response) : handleErrorResponse(response);
    }
    else {
      throw NoInternetException(
          errorMessageModel: ErrorMessageModel(
              statueMessage: StringManager.noInternet,
              statusCode: 505
          )
      );
    }
  }

  Future<List<SupplierInvoiceModel>> _handleSupplierInvoiceSuccessResponse(http.Response response) async{
    List jsn = json.decode(response.body);
    return List.from(jsn.map((invoice) => SupplierInvoiceModel.fromJson(invoice)));
  }

  @override
  Future<List<ItemModel>> getSupplierItems(int supplierId) async{
    if (await networkInfo.isConnected) {
      final response = await client.get(
        Uri.parse(ApiConstance.supplierItems(supplierId)),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      return response.statusCode == 200
          ? _handleSupplierItemsSuccessResponse(response) : handleErrorResponse(response);
    }
    else {
      throw NoInternetException(
          errorMessageModel: ErrorMessageModel(
              statueMessage: StringManager.noInternet,
              statusCode: 505
          )
      );
    }
  }

  Future<List<ItemModel>> _handleSupplierItemsSuccessResponse(http.Response response) async{
    List jsn = json.decode(response.body);
    return List.from(jsn.map((item) => ItemModel.fromJson(item)));
  }

  @override
  Future<int> addNewSupplierPayment(AddNewSupplierPaymentParameters addNewSupplierPaymentParameters) async {
    if (await networkInfo.isConnected) {
      final response = await client.post(
        Uri.parse(ApiConstance.addSupplierPaymentEndPoint),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(addNewSupplierPaymentParameters.toJson()),
      );

      return response.statusCode == 200
          ? _handleAddSupplierPaymentSuccessResponse(response) : handleErrorResponse(response);
    }
    else {
      throw NoInternetException(
          errorMessageModel: ErrorMessageModel(
              statueMessage: StringManager.noInternet,
              statusCode: 505
          )
      );
    }
  }

  Future<int> _handleAddSupplierPaymentSuccessResponse(http.Response response) async{
    return response.statusCode;
  }

  @override
  Future<List<ItemOperationModel>> getItemOperations(int itemId) async {
    if (await networkInfo.isConnected) {
      final response = await client.get(
        Uri.parse(ApiConstance.itemOperationsEndPoint(itemId)),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      return response.statusCode == 200
          ? _handleItemOperationSuccessResponse(response) : handleErrorResponse(response);
    }
    else {
      throw NoInternetException(
          errorMessageModel: ErrorMessageModel(
              statueMessage: StringManager.noInternet,
              statusCode: 505
          )
      );
    }
  }

  Future<List<ItemOperationModel>> _handleItemOperationSuccessResponse(http.Response response) async{
    List jsn = json.decode(response.body);
    return List.from(jsn.map((itemOperation) => ItemOperationModel.fromJson(itemOperation)));
  }

  @override
  Future<SearchResultModel> search(String query) async{
    if (await networkInfo.isConnected) {
      final response = await client.get(
        Uri.parse(ApiConstance.searchEndPoint(query)),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      return response.statusCode == 200 ? _handleSearchSuccessResponse(response) : handleErrorResponse(response);
    }
    else {
      throw NoInternetException(
          errorMessageModel: ErrorMessageModel(
              statueMessage: StringManager.noInternet,
              statusCode: 505
          )
      );
    }
  }
  Future<SearchResultModel> _handleSearchSuccessResponse(http.Response response) async {
    try {
      print(response.body);  // Print the complete body
      var jsn = json.decode(response.body);  // Decode JSON
      final model = SearchResultModel.fromJson(jsn);  // Map to model
      print(model);  // Print the mapped model
      return model;
    } catch (e) {
      print("Error parsing JSON: $e");  // Catch and log any errors
      throw Exception("Error parsing response: $e");
    }
  }

  @override
  Future<SupplierModel> getClient(int clientId) async{
    if (await networkInfo.isConnected) {
      final response = await client.get(
        Uri.parse(ApiConstance.clientEndPoint(clientId)),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      return response.statusCode == 200
          ? _handleGetSupplierSuccessResponse(response)
          : handleErrorResponse(response);
    }
    else {
      throw NoInternetException(
          errorMessageModel: ErrorMessageModel(
              statueMessage: StringManager.noInternet,
              statusCode: 505
          )
      );
    }
  }

  @override
  Future<List<ItemModel>> getHotItems(int supplierId) async{
    if (await networkInfo.isConnected) {
      final response = await client.get(
        Uri.parse(ApiConstance.hotItemsEndPoint(supplierId)),
        headers: {
          'Content-Type': 'application/json',
          //'token' : token
        },
      );


      return response.statusCode == 200
          ? _handleGetItemsSuccessResponse(response) : handleErrorResponse(response);
    }
    else {
      throw NoInternetException(
          errorMessageModel: ErrorMessageModel(
              statueMessage: StringManager.noInternet,
              statusCode: 505
          )
      );
    }
  }

  @override
  Future<List<ItemHistoryModel>> getItemHistory(GetItemHistoryParameters getItemHistoryParameters) async
  {
    if (await networkInfo.isConnected) {
      final response = await client.get(
        Uri.parse(ApiConstance.itemHistoryEndPoint(getItemHistoryParameters)),
        headers: {
          'Content-Type': 'application/json',
          //'token' : token
        },
      );

      return response.statusCode == 200
          ? _handleGetItemHistorySuccessResponse(response) : handleErrorResponse(response);
    }
    else {
      throw NoInternetException(
          errorMessageModel: ErrorMessageModel(
              statueMessage: StringManager.noInternet,
              statusCode: 505
          )
      );
    }
  }

  Future<List<ItemHistoryModel>>_handleGetItemHistorySuccessResponse(http.Response response) async{
    List jsn = json.decode(response.body);
    return List.from(jsn.map((itemHistory) => ItemHistoryModel.fromJson(itemHistory)));
  }







}