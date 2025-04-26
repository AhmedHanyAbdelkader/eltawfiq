import 'dart:async';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/supplier/edit_supplier_use_case.dart';
import 'package:flutter/cupertino.dart';

class EditSupplierController extends ChangeNotifier{
  EditSupplierUseCase editSupplierUseCase;
  EditSupplierController(this.editSupplierUseCase);

  bool _editSupplierIsLoading = false;
  String _editSupplierErrorMessage = '';
  int? _editSupplierResult;

  bool get editSupplierIsLoading => _editSupplierIsLoading;
  String get editSupplierErrorMessage => _editSupplierErrorMessage;
  int? get editSupplierResult => _editSupplierResult;

  FutureOr<void> editSupplier(EditSupplierParameters editSupplierParameter) async
  {
    _editSupplierIsLoading = true;
    _editSupplierErrorMessage = '';
    notifyListeners();
    try{
      final result = await editSupplierUseCase(editSupplierParameter);
      result.fold(
            (failure) {
          _editSupplierErrorMessage = failure.message;
        },
            (result) {
          _editSupplierResult = result;
        },
      );
    }catch(e){
      _editSupplierErrorMessage = 'An unexpected error occurred $e';
    }finally{
      _editSupplierIsLoading = false;
      notifyListeners();
    }
  }

}