import 'dart:async';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/supplier_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/supplier/get_supplier_use_case.dart';
import 'package:flutter/cupertino.dart';

class GetSupplierController extends ChangeNotifier{
  GetSupplierUseCase getSupplierUseCase;
  GetSupplierController(this.getSupplierUseCase);

  bool _getSuppliersIsLoading = false;
  String _getSupplierErrorMessage = '';
  SupplierEntity? _gettingSupplier;

  bool get getSupplierIsLoading => _getSuppliersIsLoading;
  String get getSupplierErrorMessage => _getSupplierErrorMessage;
  SupplierEntity? get gettingSupplier => _gettingSupplier;


  FutureOr<void> getSupplier(int parameters) async{
    _getSuppliersIsLoading = true;
    _getSupplierErrorMessage = '';
    notifyListeners();

    try{
      final result = await getSupplierUseCase(parameters);
      result.fold(
            (l) {
              _getSuppliersIsLoading = false;
          _getSupplierErrorMessage = l.message;
          notifyListeners();
        },
            (r) {
          _getSuppliersIsLoading = false;
          _gettingSupplier = r;
          notifyListeners();
        },
      );
    }catch(e){
      _getSupplierErrorMessage = 'An unexpected error occurred $e';
    }finally{
      _getSuppliersIsLoading = false;
      notifyListeners();
    }

  }

}