import 'dart:async';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/item_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/supplier/supplier_items_use_case.dart';
import 'package:flutter/material.dart';

class GetSupplierItemsController extends ChangeNotifier{
  SupplierItemsUseCase supplierItemsUseCase;
  GetSupplierItemsController(this.supplierItemsUseCase);

  bool _getSupplierItemsIsLoading = false;
  String _getSupplierItemsErrorMessage = '';
  List<ItemEntity>? _gettingSupplierItems;

  bool get getSupplierItemsIsLoading => _getSupplierItemsIsLoading;
  String get getSupplierItemsErrorMessage => _getSupplierItemsErrorMessage;
  List<ItemEntity>? get gettingSupplierItems => _gettingSupplierItems;


  FutureOr<void> getSupplierItems(int parameters) async{
    _getSupplierItemsIsLoading = true;
    _getSupplierItemsErrorMessage = '';
    notifyListeners();

    try{
      final result = await supplierItemsUseCase(parameters);
      result.fold(
            (l) {
              _getSupplierItemsIsLoading = false;
          _getSupplierItemsErrorMessage = l.message;
          notifyListeners();
        },
            (r) {
          _getSupplierItemsIsLoading = false;
          _gettingSupplierItems = r;
          notifyListeners();
        },
      );
    }catch(e){
      _getSupplierItemsErrorMessage = 'An unexpected error occurred $e';
    }finally{
      _getSupplierItemsIsLoading = false;
      notifyListeners();
    }

  }

}