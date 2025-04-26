import 'dart:async';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/item_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/item/get_all_items_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/item/get_hot_items_use_case.dart';
import 'package:flutter/cupertino.dart';

class HotItemsController extends ChangeNotifier {
  GetHotItemsUseCase getHotItemsUseCase;
  HotItemsController(this.getHotItemsUseCase);

  bool _getItemsLoading = false;
  String _getItemsErrorMessage = '';
  List<ItemEntity>? _gettingItems;



  bool get getItemsIsLoading => _getItemsLoading;
  String get getItemsErrorMessage => _getItemsErrorMessage;
  List<ItemEntity>? get gettingItems => _gettingItems;



  Future<void> getHotItems(int supplierId) async {
    _getItemsLoading = true;
    _getItemsErrorMessage = '';
    notifyListeners();

    try {
      final result = await getHotItemsUseCase(supplierId);
      result.fold(
            (failure) {
          _getItemsLoading = false;
          _getItemsErrorMessage = failure.message;
          notifyListeners();
        },
            (items) {
          _getItemsLoading = false;
          _gettingItems = items;
          notifyListeners();
        },
      );
    } catch (e) {
      _getItemsErrorMessage = 'An unexpected error occurred $e';
      _getItemsLoading = false;
      notifyListeners();
    }
  }

  List<ItemEntity> getSuggestions(String query) {
    if (_gettingItems == null) return [];
    return _gettingItems!.where((item) {
      return item.name?.toLowerCase().contains(query.toLowerCase()) ?? false;
    }).toList();
  }


}
