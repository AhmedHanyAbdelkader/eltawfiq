import 'dart:async';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/item_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/item/get_all_items_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/item/item_details_use_case.dart';
import 'package:flutter/cupertino.dart';

class ItemDetailsController extends ChangeNotifier{
  ItemDetailsUseCase itemDetailsUseCase;
  ItemDetailsController(this.itemDetailsUseCase);

  bool _getItemDetailsLoading = false;
  String _getItemDetailsErrorMessage = '';
  ItemEntity? _gettingItemDetails;

  bool get getItemDetailsIsLoading => _getItemDetailsLoading;
  String get getItemDetailsErrorMessage => _getItemDetailsErrorMessage;
  ItemEntity? get gettingItemDetails => _gettingItemDetails;


  FutureOr<void> getItemDetails(int itemId) async {
    _getItemDetailsLoading = true;
    _getItemDetailsErrorMessage = '';
    _gettingItemDetails = null;
    notifyListeners();

    try {
      final result = await itemDetailsUseCase(itemId);
      result.fold(
            (l) {
          _getItemDetailsLoading = false;
          _getItemDetailsErrorMessage = l.message;
          notifyListeners();
        },
            (r) {
          _getItemDetailsLoading = false;
          _gettingItemDetails = r;
          notifyListeners();
        },
      );
    } catch (e) {
      _getItemDetailsErrorMessage = 'An unexpected error occurred $e';
    } finally {
      _getItemDetailsLoading = false;
      notifyListeners();
    }
  }


  
}