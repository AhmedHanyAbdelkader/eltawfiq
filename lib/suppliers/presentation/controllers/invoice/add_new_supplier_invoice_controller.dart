import 'dart:async';

import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/invoice/add_new_supplier_invoice_use_case.dart';
import 'package:flutter/material.dart';

class AddNewSupplierInvoiceController extends ChangeNotifier{
  AddNewSupplierInvoiceUseCase addNewSupplierInvoiceUseCase;
  AddNewSupplierInvoiceController(this.addNewSupplierInvoiceUseCase);

  bool _addNewSupplierInvoiceIsLoading = false;
  String _addNewSupplierInvoiceErrorMessage = '';
  int? _addNewSupplierInvoiceResult;

  bool get addNewSupplierInvoiceIsLoading => _addNewSupplierInvoiceIsLoading;
  String get addNewSupplierInvoiceErrorMessage => _addNewSupplierInvoiceErrorMessage;
  int? get addNewSupplierInvoiceResult => _addNewSupplierInvoiceResult;

  FutureOr<void> addNewSupplierInvoice(Map<String,dynamic> addNewSupplierInvoiceParameter) async{
    _addNewSupplierInvoiceIsLoading = true;
    _addNewSupplierInvoiceErrorMessage = '';
    notifyListeners();

    try{
      final result = await addNewSupplierInvoiceUseCase(addNewSupplierInvoiceParameter);
      result.fold(
            (failure) {
          _addNewSupplierInvoiceErrorMessage = failure.message;
        },
            (result) {
          _addNewSupplierInvoiceResult = result;
        },
      );
    }catch(e){
      _addNewSupplierInvoiceErrorMessage = 'An unexpected error occurred $e';
    }finally{
      _addNewSupplierInvoiceIsLoading = false;
      notifyListeners();
    }
  }

  FutureOr<void> reset()async{
    _addNewSupplierInvoiceIsLoading = false;
    _addNewSupplierInvoiceErrorMessage = '';
    _addNewSupplierInvoiceResult = null;
    notifyListeners();
  }
}