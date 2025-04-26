import 'dart:async';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/supplier_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/company/get_all_company_suppliers_use_case.dart';
import 'package:flutter/cupertino.dart';

class CompanySupplierController extends ChangeNotifier{
  GetAllCompanySuppliersUseCase getAllCompanySuppliersUseCase;
  CompanySupplierController(this.getAllCompanySuppliersUseCase);

  bool _getCompanySuppliersIsLoading = false;
  String _getCompanySuppliersErrorMessage = '';
  List<SupplierEntity>? _gettingCompanySuppliers;

  bool get getCompanySuppliersIsLoading => _getCompanySuppliersIsLoading;
  String get getCompanySuppliersErrorMessage => _getCompanySuppliersErrorMessage;
  List<SupplierEntity>? get gettingCompanySuppliers => _gettingCompanySuppliers;


  FutureOr<void> getSuppliers(int parameters) async{
    _getCompanySuppliersIsLoading = true;
    _getCompanySuppliersErrorMessage = '';
    notifyListeners();

    try{
      final result = await getAllCompanySuppliersUseCase(parameters);
      result.fold(
            (l) {
          _getCompanySuppliersIsLoading = false;
          _getCompanySuppliersErrorMessage = l.message;
          notifyListeners();
        },
            (r) {
          _getCompanySuppliersIsLoading = false;
          _gettingCompanySuppliers = r;
          notifyListeners();
        },
      );
    }catch(e){
      _getCompanySuppliersErrorMessage = 'An unexpected error occurred $e';
    }finally{
      _getCompanySuppliersIsLoading = false;
      notifyListeners();
    }

  }


  List<SupplierEntity> getSuggestions(String query) {
    if (_gettingCompanySuppliers == null) return [];
    return _gettingCompanySuppliers!.where((supplier) {
      return supplier.supplierName!.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }


}