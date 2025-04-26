import 'dart:async';

import 'package:eltawfiq_suppliers/data/app_data_source.dart';
import 'package:eltawfiq_suppliers/model/company_model.dart';
import 'package:eltawfiq_suppliers/model/group_model.dart';
import 'package:eltawfiq_suppliers/model/invoice_model.dart';
import 'package:eltawfiq_suppliers/model/item_model.dart';
import 'package:eltawfiq_suppliers/model/payment_model.dart';
import 'package:eltawfiq_suppliers/model/section_model.dart';
import 'package:eltawfiq_suppliers/model/supplier_model.dart';
import 'package:flutter/cupertino.dart';

class AppStateProvider extends ChangeNotifier{
  AppDataSource appDataSource;
  AppStateProvider(this.appDataSource);

  bool _getSectionsIsLoading = false;
  String _getSectionsErrorMessage = "";
  List<SectionModel>? _getSectionsResult;
  bool get getSectionsIsLoading =>  _getSectionsIsLoading;
  String get getSectionsErrorMessage =>  _getSectionsErrorMessage;
  List<SectionModel>? get getSectionsResult => _getSectionsResult;

  bool _addSectionIsLoading = false;
  String _addSectionErrorMessage = "";
  SectionModel? _addSectionResult;
  bool get addSectionsIsLoading =>  _addSectionIsLoading;
  String get addSectionErrorMessage =>  _addSectionErrorMessage;
  SectionModel? get addSectionResult => _addSectionResult;

  bool _getItemsForSectionIsLoading = false;
  String _getItemsForSectionErrorMessage = "";
  List<ItemModel>? _getItemsForSectionResult;
  bool get getItemsForSectionIsLoading =>  _getItemsForSectionIsLoading;
  String get getItemsForSectionErrorMessage =>  _getItemsForSectionErrorMessage;
  List<ItemModel>? get getItemsForSectionResult => _getItemsForSectionResult;

  SectionModel? _currentSection;
  SectionModel? get currentSection => _currentSection;
  Future<void> changeCurrentSection({required SectionModel newSection}) async {
    _currentSection = newSection;
    notifyListeners();
  }

  ItemModel? _currentItem;
  ItemModel? get currentItem => _currentItem;
  Future<void> changeCurrentItem({required ItemModel newItem}) async {
    _currentItem = newItem;
    notifyListeners();
  }


  FutureOr<void>getSections()async{
    _getSectionsIsLoading = true;
    notifyListeners();
    try{
      final result =await appDataSource.getAllSections();
      _getSectionsResult = result;
    }catch(error){
      _getSectionsErrorMessage = error.toString();
    }finally{
      _getSectionsIsLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveSectionsOrder(List<SectionModel> sections) async {
    try {
      await appDataSource.updateSectionsOrder(sections);
    } catch (error) {
      _getSectionsErrorMessage = error.toString();
      notifyListeners();
    }
  }

  Future<void> saveSuppliersOrder(List<SupplierModel> suppliers) async {
    try {
      await appDataSource.updateSuppliersOrder(suppliers);
    } catch (error) {
      _getSectionsErrorMessage = error.toString();
      notifyListeners();
    }
  }

  Future<void> saveItemsOrder(List<ItemModel> items) async {
    try {
      await appDataSource.updateItemsOrder(items);
    } catch (error) {
      _getSectionsErrorMessage = error.toString();
      notifyListeners();
    }
  }


  FutureOr<void> createSection({required String sectorName, required String sectorImagePath}) async {
    _addSectionIsLoading = true;
    notifyListeners();
    try{
      final result = await appDataSource.createSection(sectorName: sectorName, sectorImagePath: sectorImagePath);
      _addSectionResult = result;
    }catch(error){
      _addSectionErrorMessage = error.toString();
    }finally{
      _addSectionIsLoading = false;
      notifyListeners();
    }
  }

  Future<void> getItemsForSection({required int sectionId, required int userId}) async {
    _getItemsForSectionIsLoading = true;
    notifyListeners();
    try {
      final result = await appDataSource.getItemsForSection(sectionId: sectionId, userId: userId);
      _getItemsForSectionResult = result;
    } catch (error) {
      _getItemsForSectionErrorMessage = error.toString();
    } finally {
      _getItemsForSectionIsLoading = false;
      notifyListeners();
    }
  }


  bool _createSupplierIsLoading = false;
  String _createSupplierErrorMessage = "";
  SupplierModel? _createSupplierResult;
  bool get createSupplierIsLoading =>  _createSupplierIsLoading;
  String get createSupplierErrorMessage =>  _createSupplierErrorMessage;
  SupplierModel? get createSupplierResult => _createSupplierResult;

  // FutureOr<void> createSupplier({
  // required String supplierName,
  // String? supplierPhoneNumber,
  // String? supplierWhatsappNumber,})async{
  //   _createSupplierIsLoading = true;
  //   notifyListeners();
  //   try{
  //     final result =await appDataSource.createSupplier(
  //         supplierName: supplierName,
  //         supplierPhoneNumber: supplierPhoneNumber,
  //       supplierWhatsappNumber: supplierWhatsappNumber
  //     );
  //     _createSupplierResult = result;
  //   }catch(e){
  //     _createSupplierErrorMessage = e.toString();
  //   }finally{
  //     _createSupplierIsLoading = false;
  //     notifyListeners();
  //   }
  // }


  Future<void> createSupplier({
    required SupplierModel supplier,
    required String token,
  }) async {
    _createSupplierIsLoading = true;
    notifyListeners();
    try {
      final result = await appDataSource.createSupplier(supplier: supplier , token: token);
      _createSupplierResult = result;
    } catch (e) {
      _createSupplierErrorMessage = e.toString();
    } finally {
      _createSupplierIsLoading = false;
      notifyListeners();
    }
  }



  bool _getSuppliersIsLoading = false;
  String _getSuppliersErrorMessage = "";
  List<SupplierModel>? _getSuppliersResult;
  bool get getSuppliersIsLoading =>  _getSuppliersIsLoading;
  String get getSuppliersErrorMessage =>  _getSuppliersErrorMessage;
  List<SupplierModel>? get getSuppliersResult => _getSuppliersResult;

  FutureOr<void>getSuppliers({required int id})async{
    _getSuppliersIsLoading = true;
    notifyListeners();
    try{
      final result = await appDataSource.getSuppliers(id: id);
      _getSuppliersResult = result;
    }catch(e){
      _getSuppliersErrorMessage = e.toString();
    }finally{
      _getSuppliersIsLoading = false;
      notifyListeners();
    }
  }



  bool _getSupplierItemsIsLoading = false;
  final String _getSupplierItemsErrorMessage = "";
  List<ItemModel>? _getSupplierItemsResult;
  bool get getSupplierItemsIsLoading =>  _getSupplierItemsIsLoading;
  String get getSupplierItemsErrorMessage =>  _getSupplierItemsErrorMessage;
  List<ItemModel>? get getSupplierItemsResult => _getSupplierItemsResult;

  FutureOr<void> getSupplierItems({required int id})async{
    _getSupplierItemsIsLoading = true;
    notifyListeners();
    try{
      final result =await appDataSource.getSupplierItems(id: id);
      _getSupplierItemsResult = result;
    }catch(e){
      _getSuppliersErrorMessage = e.toString();
    }finally{
      _getSupplierItemsIsLoading = false;
      notifyListeners();
    }
  }

  SupplierModel? _currentSupplier;
  SupplierModel? get currentSupplier => _currentSupplier;
  Future<void> changeCurrentISupplier({required SupplierModel newSupplier}) async {
    _currentSupplier = newSupplier;
    notifyListeners();
  }



  bool _getSupplierInvoicesIsLoading = false;
  final String _getSupplierInvoicesErrorMessage = "";
  List<InvoiceModel>? _getSupplierInvoicesResult;
  bool get getSupplierInvoicesIsLoading =>  _getSupplierInvoicesIsLoading;
  String get getSupplierInvoicesErrorMessage =>  _getSupplierInvoicesErrorMessage;
  List<InvoiceModel>? get getSupplierInvoicesResult => _getSupplierInvoicesResult;

  FutureOr<void> getSupplierInvoices({required int id, required int supplierId})async{
    _getSupplierInvoicesIsLoading = true;
    notifyListeners();
    try{
      final result =await appDataSource.getSupplierInvoices(id: id,supplierId: supplierId);
      _getSupplierInvoicesResult = result;
    }catch(e){
      _getSuppliersErrorMessage = e.toString();
    }finally{
      _getSupplierInvoicesIsLoading = false;
      notifyListeners();
    }
  }


  final List<ItemModel> _getInvoiceItems = [];
  List<ItemModel> get getInvoiceItems => _getInvoiceItems;
  FutureOr<void> addNewItemToInvoice(ItemModel? newItem)async{
    _getInvoiceItems.add(newItem!);
    notifyListeners();
  }

  FutureOr<void> emptyTheInvoiceItems()async{
    _getInvoiceItems.clear();
    notifyListeners();
  }





  int? _getInvoiceTotal = 0;
  int? get getInvoiceTotal => _getInvoiceTotal;

  FutureOr<void> calculateInvoiceTotal() async {
    int total = 0; // Initialize total outside the loop
    for (int i = 0; i < _getInvoiceItems.length; i++) {
      total += (_getInvoiceItems[i].itemTotal == 0
          ? _getInvoiceItems[i].purchasingPrice
          : _getInvoiceItems[i].itemTotal)!;
    }
    _getInvoiceTotal = total; // Assign total to _getInvoiceTotal after the loop
    notifyListeners(); // Notify listeners once after the total is calculated
  }



  bool _getSupplierPaymentsIsLoading = false;
  String _getSupplierPaymentsErrorMessage = "";
  List<PaymentModel>? _getSupplierPaymentsResult;
  bool get getSupplierPaymentsIsLoading =>  _getSupplierPaymentsIsLoading;
  String get getSupplierPaymentsErrorMessage =>  _getSupplierPaymentsErrorMessage;
  List<PaymentModel>? get getSupplierPaymentsResult => _getSupplierPaymentsResult;

  FutureOr<void> getSupplierPayments({required int supplierId})async{
    _getSupplierPaymentsIsLoading = true;
    notifyListeners();
    try{
      final result =await appDataSource.getSupplierPayments(supplierId: supplierId);
      _getSupplierPaymentsResult = result;
    }catch(e){
      _getSupplierPaymentsErrorMessage = e.toString();
    }finally{
      _getSupplierPaymentsIsLoading = false;
      notifyListeners();
    }
  }



  bool _makeSupplierPaymentsIsLoading = false;
  String _makeSupplierPaymentsErrorMessage = "";
  PaymentModel? _makeSupplierPaymentsResult;
  bool get maketSupplierPaymentsIsLoading =>  _makeSupplierPaymentsIsLoading;
  String get makeSupplierPaymentsErrorMessage =>  _makeSupplierPaymentsErrorMessage;
  PaymentModel? get makeSupplierPaymentsResult => _makeSupplierPaymentsResult;

  FutureOr<void> makeSupplierPayments({
    required int supplierId,
    required int payedAmountFromSupplierTotal,
    required int remainedAmountFromSupplierTotal,
  })async{
    _makeSupplierPaymentsIsLoading = true;
    notifyListeners();
    try{
      final result =await appDataSource.makeSupplierPayment(
          supplierId: supplierId,
        payedAmountFromSupplierTotal:payedAmountFromSupplierTotal ,
        remainedAmountFromSupplierTotal: remainedAmountFromSupplierTotal,
      );
      _makeSupplierPaymentsResult = result;
    }catch(e){
      _makeSupplierPaymentsErrorMessage = e.toString();
    }finally{
      _makeSupplierPaymentsIsLoading = false;
      notifyListeners();
    }
  }


  bool _storeInvoiceIsLoading = false;
  String _storeInvoiceErrorMessage = "";
  int? _storeInvoiceResult;
  bool get storeInvoiceIsLoading =>  _storeInvoiceIsLoading;
  String get storeInvoiceErrorMessage =>  _storeInvoiceErrorMessage;
  int? get storeInvoiceResult => _storeInvoiceResult;

  FutureOr<void>storeInvoice ({required StoreInvoiceParameters storeInvoiceParameters})async{
    _storeInvoiceIsLoading = true;
    notifyListeners();
    try{
      final result =await appDataSource.storeInvoice(storeInvoiceParameters);
      _storeInvoiceResult = result;
    }catch(e){
      _storeInvoiceErrorMessage = e.toString();
    }finally{
      _storeInvoiceIsLoading = false;
      notifyListeners();
    }
  }


  bool _addItemIsLoading = false;
  String _addItemErrorMessage = "";
  int? _addItemResult;
  bool get addItemIsLoading =>  _addItemIsLoading;
  String get addItemErrorMessage =>  _addItemErrorMessage;
  int? get addItemResult => _addItemResult;

  FutureOr<void> addItem({required AddNewItemParameters addNewItemParameters}) async {
    _addItemIsLoading = true;
    notifyListeners();
    try{
      //final result = appDataSource.addItem(addNewItemParameters: addNewItemParameters);
      //_addSectionResult = result;
    }catch(e){
      _addItemErrorMessage = e.toString();
    }finally{
      _addItemIsLoading = false;
      notifyListeners();
    }
  }


  bool _searchItemIsLoading = false;
  String _searchItemErrorMessage = "";
  List<ItemModel>? _searchItemResult;
  bool get searchItemIsLoading =>  _searchItemIsLoading;
  String get searchItemErrorMessage =>  _searchItemErrorMessage;
  List<ItemModel>? get searchItemResult => _searchItemResult;

  FutureOr<void> serachItem({required String query, required int userId})async{
    _searchItemIsLoading = true;
    notifyListeners();
    try{
      final result = await appDataSource.searchItems(query: query,userId: userId);
      _searchItemResult = result;
    }catch(e){
      _searchItemErrorMessage = e.toString();
    }finally{
      _searchItemIsLoading = false;
      notifyListeners();
    }
  }



  bool _getCompaniesIsLoading = false;
  String _getCompaniesErrorMessage = "";
  List<CompanyModel>? _getCompaniesResult;
  bool get getCompaniesIsLoading =>  _getCompaniesIsLoading;
  String get getCompaniesErrorMessage =>  _getCompaniesErrorMessage;
  List<CompanyModel>? get getCompaniesResult => _getCompaniesResult;

  FutureOr<void> getCompanies({required String token})async{
    _getCompaniesIsLoading = true;
    notifyListeners();
    try{
      final result = await appDataSource.getAllCompanies(token);
      _getCompaniesResult = result;
    }catch(e){
      _getCompaniesErrorMessage = e.toString();
    }finally{
      _getCompaniesIsLoading = false;
      notifyListeners();
    }
  }



  bool _getCompanyIsLoading = false;
  String _getCompanyErrorMessage = "";
  CompanyModel? _getCompanyResult;
  bool get getCompanyIsLoading =>  _getCompanyIsLoading;
  String get getCompanyErrorMessage =>  _getCompanyErrorMessage;
  CompanyModel? get getCompanyResult => _getCompanyResult;

  FutureOr<void> getCompany({required String token, required int id})async{
    _getCompanyIsLoading = true;
    notifyListeners();
    try{
      final result = await appDataSource.getCompany(token: token, id: id);
      _getCompanyResult = result;
    }catch(e){
      _getCompanyErrorMessage = e.toString();
    }finally{
      _getCompanyIsLoading = false;
      notifyListeners();
    }
  }





  bool _createCompanyIsLoading = false;
  String _createCompanyErrorMessage = "";
  CompanyModel? _createCompanyResult;
  bool get createCompanyIsLoading =>  _createCompanyIsLoading;
  String get createCompanyErrorMessage =>  _createCompanyErrorMessage;
  CompanyModel? get createCompanyResult => _createCompanyResult;

  FutureOr<void> createCompany({required String token, required CompanyModel companyModel})async{
    _createCompanyIsLoading = true;
    notifyListeners();
    try{
      final result = await appDataSource.createCompany(token: token,company: companyModel);
      _createCompanyResult = result;
    }catch(e){
      _createCompanyErrorMessage = e.toString();
    }finally{
      _createCompanyIsLoading = false;
      notifyListeners();
    }
  }

  void resetCreateCompanyState() {
    _createCompanyIsLoading = false;
    _createCompanyErrorMessage = "";
    _createCompanyResult = null;
    notifyListeners();
  }






  bool _getGroupsIsLoading = false;
  String _getGroupsErrorMessage = "";
  List<GroupModel>? _getGroupsResult;
  bool get getGroupsIsLoading =>  _getGroupsIsLoading;
  String get getGroupsErrorMessage =>  _getGroupsErrorMessage;
  List<GroupModel>? get getGroupsResult => _getGroupsResult;

  FutureOr<void> getGroups({required String token})async{
    _getGroupsIsLoading = true;
    notifyListeners();
    try{
      final result = await appDataSource.getAllGroups(token);
      _getGroupsResult = result;
    }catch(e){
      _getGroupsErrorMessage = e.toString();
    }finally{
      _getGroupsIsLoading = false;
      notifyListeners();
    }
  }






  bool _createGroupIsLoading = false;
  String _createGroupErrorMessage = "";
  GroupModel? _createGroupResult;
  bool get createGroupIsLoading =>  _createGroupIsLoading;
  String get createGroupErrorMessage =>  _createGroupErrorMessage;
  GroupModel? get createGroupResult => _createGroupResult;

  FutureOr<void> createGroup({required String token, required GroupModel groupModel})async{
    _createGroupIsLoading = true;
    notifyListeners();
    try{
      final result = await appDataSource.createGroup(token: token, group: groupModel);
      _createGroupResult = result;
    }catch(e){
      _createGroupErrorMessage = e.toString();
    }finally{
      _createGroupIsLoading = false;
      notifyListeners();
    }
  }

  void resetCreateGroupState() {
    _createGroupIsLoading = false;
    _createGroupErrorMessage = "";
    _createGroupResult = null;
    notifyListeners();
  }



  bool _searchSupplierIsLoading = false;
  String _searchSupplierErrorMessage = "";
  List<SupplierModel>? _searchSupplierResult;
  bool get searchSupplierIsLoading =>  _searchSupplierIsLoading;
  String get searchSupplierErrorMessage =>  _searchSupplierErrorMessage;
  List<SupplierModel>? get searchSupplierResult => _searchSupplierResult;

  FutureOr<void> serachSupplier({required String query})async{
    _searchSupplierIsLoading = true;
    notifyListeners();
    try{
      final result = await appDataSource.searchSuppliers(query);
      _searchSupplierResult = result;
    }catch(e){
      _searchSupplierErrorMessage = e.toString();
    }finally{
      _searchSupplierIsLoading = false;
      notifyListeners();
    }
  }


  FutureOr<void> resetSearchScreen()async{
     _searchSupplierIsLoading = false;
     _searchSupplierErrorMessage = "";
    _searchSupplierResult = null;
      _searchItemIsLoading = false;
      _searchItemErrorMessage = "";
     _searchItemResult = null;

     notifyListeners();
  }



}