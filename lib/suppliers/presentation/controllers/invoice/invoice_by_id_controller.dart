import 'dart:async';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/supplier_invoice_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/invoice/get_invoice_by_id_use_case.dart';
import 'package:flutter/material.dart';

class InvoiceByIdController extends ChangeNotifier{
  GetInvoiceByIdUseCase getInvoiceByIdUseCase;
  InvoiceByIdController(this.getInvoiceByIdUseCase);


  bool _getInvoiceByIdsLoading = false;
  String _getInvoiceByIdsErrorMessage = '';
  SupplierInvoiceEntity? _gettingInvoiceByIds;

  bool get getInvoiceByIdsIsLoading => _getInvoiceByIdsLoading;
  String get getInvoiceByIdsErrorMessage => _getInvoiceByIdsErrorMessage;
  SupplierInvoiceEntity? get gettingInvoiceByIds => _gettingInvoiceByIds;


  FutureOr<void> getInvoiceByIds(int parameters) async {
    _getInvoiceByIdsLoading = true;
    _getInvoiceByIdsErrorMessage = '';
    notifyListeners();

    try {
      final result = await getInvoiceByIdUseCase(parameters);
      result.fold(
            (l) {
          _getInvoiceByIdsLoading = false;
          _getInvoiceByIdsErrorMessage = l.message;
          notifyListeners();
        },
            (r) {
          _getInvoiceByIdsLoading = false;
          _gettingInvoiceByIds = r;
          notifyListeners();
        },
      );
    } catch (e) {
      _getInvoiceByIdsErrorMessage = 'An unexpected error occurred $e';
    } finally {
      _getInvoiceByIdsLoading = false;
      notifyListeners();
    }
  }
  
  
}