import 'dart:async';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/supplier_payment_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/payment/supplier_payments_use_case.dart';
import 'package:flutter/material.dart';

class GetSupplierPaymentsPaymentsController extends ChangeNotifier{
  SupplierPaymentsUseCase supplierPaymentsUseCase;
  GetSupplierPaymentsPaymentsController(this.supplierPaymentsUseCase);

  bool _getSupplierPaymentsIsLoading = false;
  String _getSupplierPaymentsErrorMessage = '';
  List<SupplierPaymentEntity>? _gettingSupplierPayments;

  bool get getSupplierPaymentsIsLoading => _getSupplierPaymentsIsLoading;
  String get getSupplierPaymentsErrorMessage => _getSupplierPaymentsErrorMessage;
  List<SupplierPaymentEntity>? get gettingSupplierPayments => _gettingSupplierPayments;


  FutureOr<void> getSupplierPayments(int parameters) async{
    _getSupplierPaymentsIsLoading = true;
    _getSupplierPaymentsErrorMessage = '';
    notifyListeners();

    try{
      final result = await supplierPaymentsUseCase(parameters);
      result.fold(
            (l) {
              _getSupplierPaymentsIsLoading = false;
          _getSupplierPaymentsErrorMessage = l.message;
          notifyListeners();
        },
            (r) {
          _getSupplierPaymentsIsLoading = false;
          _gettingSupplierPayments = r;
          notifyListeners();
        },
      );
    }catch(e){
      _getSupplierPaymentsErrorMessage = 'An unexpected error occurred $e';
    }finally{
      _getSupplierPaymentsIsLoading = false;
      notifyListeners();
    }

  }

}