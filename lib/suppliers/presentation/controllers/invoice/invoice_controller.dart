import 'dart:async';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/supplier_invoice_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/invoice/get_all_invoices_use_case.dart';
import 'package:flutter/material.dart';

class InvoiceController extends ChangeNotifier{
  GetAllInvoicesUseCase getAllInvoicesUseCase;
  InvoiceController(this.getAllInvoicesUseCase);


  bool _getInvoicesLoading = false;
  String _getInvoicesErrorMessage = '';
  List<SupplierInvoiceEntity?>? _gettingInvoices;

  bool get getInvoicesIsLoading => _getInvoicesLoading;
  String get getInvoicesErrorMessage => _getInvoicesErrorMessage;
  List<SupplierInvoiceEntity?>? get gettingInvoices => _gettingInvoices;


  FutureOr<void> getInvoices(NoParameters parameters) async {
    _getInvoicesLoading = true;
    _getInvoicesErrorMessage = '';
    notifyListeners();

    try {
      final result = await getAllInvoicesUseCase(parameters);
      result.fold(
            (l) {
          _getInvoicesLoading = false;
          _getInvoicesErrorMessage = l.message;
          notifyListeners();
        },
            (r) {
          _getInvoicesLoading = false;
          _gettingInvoices = r;
          notifyListeners();
        },
      );
    } catch (e) {
      _getInvoicesErrorMessage = 'An unexpected error occurred $e';
    } finally {
      _getInvoicesLoading = false;
      notifyListeners();
    }
  }
  
  
}