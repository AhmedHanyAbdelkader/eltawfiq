import 'dart:async';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/item_operation_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/item/get_item_operations_use_case.dart';
import 'package:flutter/material.dart';

class ItemOperationsController extends ChangeNotifier{
  GetItemOperationsUseCase getItemOperationsUseCase;
  ItemOperationsController(this.getItemOperationsUseCase);

  bool _getItemOperationsLoading = false;
  String _getItemOperationsErrorMessage = '';
  List<ItemOperationEntity>? _gettingItemOperations;

  bool get getItemOperationsIsLoading => _getItemOperationsLoading;
  String get getItemOperationsErrorMessage => _getItemOperationsErrorMessage;
  List<ItemOperationEntity>? get gettingItemOperations => _gettingItemOperations;


  FutureOr<void> getItemOperations(int itemId) async {
    _getItemOperationsLoading = true;
    _getItemOperationsErrorMessage = '';
    notifyListeners();

    try {
      final result = await getItemOperationsUseCase(itemId);
      result.fold(
            (l) {
          _getItemOperationsLoading = false;
          _getItemOperationsErrorMessage = l.message;
          notifyListeners();
        },
            (r) {
          _getItemOperationsLoading = false;
          _gettingItemOperations = r;
          notifyListeners();
        },
      );
    } catch (e) {
      _getItemOperationsErrorMessage = 'An unexpected error occurred $e';
    } finally {
      _getItemOperationsLoading = false;
      notifyListeners();
    }
  }


  
}