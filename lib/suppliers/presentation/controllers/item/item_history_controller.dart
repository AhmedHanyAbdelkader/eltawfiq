import 'package:eltawfiq_suppliers/suppliers/domain/entities/item_history_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/item/get_item_history_use_case.dart';
import 'package:flutter/cupertino.dart';

class ItemHistoryController extends ChangeNotifier {
  GetItemsHistoryUseCase getItemsHistoryUseCase;
  ItemHistoryController(this.getItemsHistoryUseCase);

  bool _getItemHistoryLoading = false;
  String _getItemHistoryErrorMessage = '';
  List<ItemHistoryEntity>? _gettingItemHistory;


  bool get getItemHistoryIsLoading => _getItemHistoryLoading;
  String get getItemHistoryErrorMessage => _getItemHistoryErrorMessage;
  List<ItemHistoryEntity>? get gettingItemHistory => _gettingItemHistory;


  Future<void> getItemHistory(GetItemHistoryParameters getItemHistoryParameters) async {
    _getItemHistoryLoading = true;
    _getItemHistoryErrorMessage = '';
    notifyListeners();

    try {
      final result = await getItemsHistoryUseCase(getItemHistoryParameters);
      result.fold(
            (failure) {
          _getItemHistoryLoading = false;
          _getItemHistoryErrorMessage = failure.message;
          notifyListeners();
        },
            (itemHistory) {
          _getItemHistoryLoading = false;
          _gettingItemHistory = itemHistory;
          notifyListeners();
        },
      );
    } catch (e) {
      _getItemHistoryErrorMessage = 'An unexpected error occurred $e';
      _getItemHistoryLoading = false;
      notifyListeners();
    }
  }



}
