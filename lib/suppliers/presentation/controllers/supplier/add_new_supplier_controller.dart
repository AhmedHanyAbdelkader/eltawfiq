import 'dart:async';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/supplier/add_new_supplier_use_case.dart';
import 'package:flutter/cupertino.dart';

class AddNewSupplierController extends ChangeNotifier{

  AddNewSupplierUseCase addNewSupplierUseCase;
  AddNewSupplierController(this.addNewSupplierUseCase);

  bool _addNewSupplierIsLoading = false;
  String _addNewSupplierErrorMessage = '';
  int? _addNewSupplierResult;

  bool get addNewSupplierIsLoading => _addNewSupplierIsLoading;
  String get addNewSupplierErrorMessage => _addNewSupplierErrorMessage;
  int? get addNewSupplierResult => _addNewSupplierResult;

  FutureOr<void> addNewSupplier(AddNewSupplierParameter addNewSupplierParameter) async{
    _addNewSupplierIsLoading = true;
    _addNewSupplierErrorMessage = '';
    notifyListeners();

    try{
     final result = await addNewSupplierUseCase(addNewSupplierParameter);
     result.fold(
             (failure) {
               _addNewSupplierErrorMessage = failure.message;
             },
             (result) {
               _addNewSupplierResult = result;
             },
     );
    }catch(e){
      _addNewSupplierErrorMessage = 'An unexpected error occurred $e';
    }finally{
      _addNewSupplierIsLoading = false;
      notifyListeners();
    }
  }

}