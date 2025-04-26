import 'dart:async';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/item/delete_item_use_case.dart';
import 'package:flutter/material.dart';

class DeleteItemController extends ChangeNotifier{
  DeleteItemUseCase deleteItemUseCase;
  DeleteItemController(this.deleteItemUseCase);

  bool _deleteItemIsLoading = false;
  String _deleteItemErrorMessage = '';
  int? _deleteItemResult;

  bool get deleteItemIsLoading => _deleteItemIsLoading;
  String get deleteItemErrorMessage => _deleteItemErrorMessage;
  int? get deleteItemResult => _deleteItemResult;

  FutureOr<void> deleteItem(int itemId)async
  {
    _deleteItemIsLoading = true;
    _deleteItemErrorMessage = '';
    notifyListeners();
    try{
      final result = await deleteItemUseCase(itemId);
      result.fold(
            (l) {
          _deleteItemErrorMessage = l.message;
        },
            (r) {
          _deleteItemResult = r;
        },
      );
    }catch(e){
      _deleteItemErrorMessage = 'An unexpected error occurred $e';
    }finally{
      _deleteItemIsLoading = false;
      notifyListeners();
    }
  }

}