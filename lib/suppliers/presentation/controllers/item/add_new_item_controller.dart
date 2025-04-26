import 'dart:async';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/item/add_new_item_use_case.dart';
import 'package:flutter/material.dart';

class AddNewItemController extends ChangeNotifier{
  AddNewItemUseCase addNewItemUseCase;
  AddNewItemController(this.addNewItemUseCase);

  bool _addNewItemIsLoading = false;
  String _addNewItemErrorMessage = '';
  int? _addNewItemResult;

  bool get addNewItemIsLoading => _addNewItemIsLoading;
  String get addNewItemErrorMessage => _addNewItemErrorMessage;
  int? get addNewItemResult => _addNewItemResult;

  FutureOr<void> addNewItem(AddNewItemParameters addNewItemParameter) async{
    _addNewItemIsLoading = true;
    _addNewItemErrorMessage = '';
    notifyListeners();

    try{
      final result = await addNewItemUseCase(addNewItemParameter);
      result.fold(
            (failure) {
          _addNewItemErrorMessage = failure.message;
        },
            (result) {
          _addNewItemResult = result;
        },
      );
    }catch(e){
      _addNewItemErrorMessage = 'An unexpected error occurred $e';
    }finally{
      _addNewItemIsLoading = false;
      notifyListeners();
    }
  }

}