import 'dart:async';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/supplier_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/supplier/get_all_suppliers_use_case.dart';
import 'package:flutter/cupertino.dart';

class SupplierController extends ChangeNotifier{
  GetAllSuppliersUseCase getSuppliersUseCase;
  SupplierController(this.getSuppliersUseCase);

  bool _getSuppliersIsLoading = false;
  String _getSuppliersErrorMessage = '';
  List<SupplierEntity>? _gettingSuppliers;

  bool get getSuppliersIsLoading => _getSuppliersIsLoading;
  String get getSuppliersErrorMessage => _getSuppliersErrorMessage;
  List<SupplierEntity>? get gettingSuppliers => _gettingSuppliers;

  int? _currentSupplierId;
  int? get currentSupplierId => _currentSupplierId;

  FutureOr<void> getSuppliers(NoParameters parameters) async{
    _getSuppliersIsLoading = true;
    _getSuppliersErrorMessage = '';
    notifyListeners();
    try{
      final result = await getSuppliersUseCase(parameters);
      result.fold(
            (l) {
          _getSuppliersIsLoading = false;
          _getSuppliersErrorMessage = l.message;
          notifyListeners();
        },
            (r) {
          _getSuppliersIsLoading = false;
          _gettingSuppliers = r;
          notifyListeners();
        },
      );
    }catch(e){
      _getSuppliersErrorMessage = 'An unexpected error occurred $e';
    }finally{
      _getSuppliersIsLoading = false;
      notifyListeners();
    }

  }

  List<SupplierEntity> getSuggestions(String query) {
    if (_gettingSuppliers == null) return [];
    return _gettingSuppliers!.where((supplier) {
      return supplier.supplierName!.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  FutureOr<void> setCurrentSupplierId(int newSupplierId)async{
    _currentSupplierId = newSupplierId;
    notifyListeners();
  }

}