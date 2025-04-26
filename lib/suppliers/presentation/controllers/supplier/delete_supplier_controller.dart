import 'dart:async';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/supplier/delete_supplier_use_case.dart';
import 'package:flutter/cupertino.dart';

class DeleteSupplierController extends ChangeNotifier{
  DeleteSupplierUseCase deleteSupplierUseCase;
  DeleteSupplierController(this.deleteSupplierUseCase);

  bool _deleteSupplierIsLoading = false;
  String _deleteSupplierErrorMessage = '';
  int? _deleteSupplierResult;

  bool get deleteSupplierIsLoading => _deleteSupplierIsLoading;
  String get deleteSupplierErrorMessage => _deleteSupplierErrorMessage;
  int? get deleteSupplierResult => _deleteSupplierResult;

  FutureOr<void> deleteSupplier(int supplierId)async
  {
    _deleteSupplierIsLoading = true;
    _deleteSupplierErrorMessage = '';
    notifyListeners();
    try{
      final result = await deleteSupplierUseCase(supplierId);
      result.fold(
            (l) {
          _deleteSupplierErrorMessage = l.message;
        },
            (r) {
          _deleteSupplierResult = r;
        },
      );
    }catch(e){
      _deleteSupplierErrorMessage = 'An unexpected error occurred $e';
    }finally{
      _deleteSupplierIsLoading = false;
      notifyListeners();
    }
  }

}