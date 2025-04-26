import 'dart:async';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/payment/add_new_supplier_payment_use_case.dart';
import 'package:flutter/material.dart';

class AddNewSupplierPaymentController extends ChangeNotifier{

  AddNewSupplierPaymentUseCase addNewSupplierPaymentUseCase;
  AddNewSupplierPaymentController(this.addNewSupplierPaymentUseCase);

  bool _addNewSupplierPaymentIsLoading = false;
  String _addNewSupplierPaymentErrorMessage = '';
  int? _addNewSupplierPaymentResult;

  bool get addNewSupplierPaymentIsLoading => _addNewSupplierPaymentIsLoading;
  String get addNewSupplierPaymentErrorMessage => _addNewSupplierPaymentErrorMessage;
  int? get addNewSupplierPaymentResult => _addNewSupplierPaymentResult;

  FutureOr<void> addNewSupplierPayment(AddNewSupplierPaymentParameters addNewSupplierPaymentParameters) async{
    _addNewSupplierPaymentIsLoading = true;
    _addNewSupplierPaymentErrorMessage = '';
    notifyListeners();

    try{
      final result = await addNewSupplierPaymentUseCase(addNewSupplierPaymentParameters);
      result.fold(
            (failure) {
          _addNewSupplierPaymentErrorMessage = failure.message;
        },
            (result) {
          _addNewSupplierPaymentResult = result;
        },
      );
    }catch(e){
      _addNewSupplierPaymentErrorMessage = 'An unexpected error occurred $e';
    }finally{
      _addNewSupplierPaymentIsLoading = false;
      notifyListeners();
    }
  }


}