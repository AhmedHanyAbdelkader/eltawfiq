import 'dart:async';

import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/item/edit_item_use_case.dart';
import 'package:flutter/material.dart';

class EditItemController extends ChangeNotifier{
  EditItemUseCase editItemUseCase;
  EditItemController(this.editItemUseCase);

  bool _editItemIsLoading = false;
  String _editItemErrorMessage = '';
  int? _editItemResult;

  bool get editItemIsLoading => _editItemIsLoading;
  String get editItemErrorMessage => _editItemErrorMessage;
  int? get editItemResult => _editItemResult;

  FutureOr<void> editItems(EditItemParameters editItemParameters) async
  {
    _editItemIsLoading = true;
    _editItemErrorMessage = '';
    notifyListeners();
    try{
      final result = await editItemUseCase(editItemParameters);
      result.fold(
            (failure) {
          _editItemErrorMessage = failure.message;
        },
            (result) {
          _editItemResult = result;
        },
      );
    }catch(e){
      _editItemErrorMessage = 'An unexpected error occurred $e';
    }finally{
      _editItemIsLoading = false;
      notifyListeners();
    }
  }


}