import 'dart:async';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/supplier_invoice_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/supplier/supplier_invoices_use_case.dart';
import 'package:flutter/material.dart';

class GetSupplierInvoicesController extends ChangeNotifier{
  SupplierInvoicesUseCase supplierInvoicesUseCase;
  GetSupplierInvoicesController(this.supplierInvoicesUseCase);

  bool _getSupplierInvoicesIsLoading = false;
  String _getSupplierInvoicesErrorMessage = '';
  List<SupplierInvoiceEntity?>? _gettingSupplierInvoices;

  bool get getSupplierInvoicesIsLoading => _getSupplierInvoicesIsLoading;
  String get getSupplierInvoicesErrorMessage => _getSupplierInvoicesErrorMessage;
  List<SupplierInvoiceEntity?>? get gettingSupplierInvoices => _gettingSupplierInvoices;


  FutureOr<void> getSupplierInvoices({required int supplierId}) async{
    _getSupplierInvoicesIsLoading = true;
    _getSupplierInvoicesErrorMessage = '';
    notifyListeners();

    try{
      final result = await supplierInvoicesUseCase(supplierId);
      result.fold(
            (l) {
          _getSupplierInvoicesIsLoading = false;
          _getSupplierInvoicesErrorMessage = l.message;
          notifyListeners();
        },
            (r) {
          _getSupplierInvoicesIsLoading = false;
          _gettingSupplierInvoices = r;
          notifyListeners();
        },
      );
    }catch(e){
      _getSupplierInvoicesErrorMessage = 'An unexpected error occurred $e';
    }finally{
      _getSupplierInvoicesIsLoading = false;
      notifyListeners();
    }

  }

}