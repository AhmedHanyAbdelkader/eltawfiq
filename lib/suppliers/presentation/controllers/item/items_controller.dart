import 'dart:async';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/item_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/item/get_all_items_use_case.dart';
import 'package:flutter/cupertino.dart';

// class ItemsController extends ChangeNotifier {
//   GetAllItemsUseCase getAllItemsUseCase;
//   ItemsController(this.getAllItemsUseCase);
//
//   bool _getItemsLoading = false;
//   String _getItemsErrorMessage = '';
//   List<ItemEntity>? _gettingItems;
//
//   // Separate list for invoice items
//   List<ItemEntity> _invoiceItems = [];
//
//   double _invoiceTotal = 0.0;
//   double _invoicePaid = 0.0;
//   double _invoiceRemain = 0.0;
//   double get invoiceTotal => _invoiceTotal;
//   double get invoiceRemain => _invoiceRemain;
//   double get invoicePaid => _invoicePaid;
//
//   bool get getItemsIsLoading => _getItemsLoading;
//   String get getItemsErrorMessage => _getItemsErrorMessage;
//   List<ItemEntity>? get gettingItems => _gettingItems;
//
//   // Getter for invoice items
//   List<ItemEntity> get invoiceItems => _invoiceItems;
//
//   Future<void> getItems(NoParameters parameters) async {
//     _getItemsLoading = true;
//     _getItemsErrorMessage = '';
//     notifyListeners();
//
//     try {
//       final result = await getAllItemsUseCase(parameters);
//       result.fold(
//             (failure) {
//           _getItemsLoading = false;
//           _getItemsErrorMessage = failure.message;
//           notifyListeners();
//         },
//             (items) {
//           _getItemsLoading = false;
//           _gettingItems = items;
//           notifyListeners();
//         },
//       );
//     } catch (e) {
//       _getItemsErrorMessage = 'An unexpected error occurred $e';
//       _getItemsLoading = false;
//       notifyListeners();
//     }
//   }
//
//   List<ItemEntity> getSuggestions(String query) {
//     if (_gettingItems == null) return [];
//     return _gettingItems!.where((item) {
//       return item.name?.toLowerCase().contains(query.toLowerCase()) ?? false;
//     }).toList();
//   }
//
//
//
//   // Separate logic for invoice management:
//
//   // Add item to invoice list
//   void addItemToInvoice(ItemEntity item) {
//     _invoiceTotal += item?.itemTotalPrice?.toDouble() ?? 0.0;
//     _invoiceItems.add(item);
//     notifyListeners();
//   }
//
//
//   // Remove item from invoice list
//   void removeItemFromInvoice(ItemEntity item) {
//     _invoiceItems.remove(item);
//     notifyListeners();
//   }
//
//   // Update item in the invoice list
//   void updateInvoiceItem(ItemEntity updatedItem) {
//     final index = _invoiceItems.indexWhere((item) => item.id == updatedItem.id);
//     if (index != -1) {
//       _invoiceItems[index] = updatedItem;
//       notifyListeners();
//     }
//   }
//
//
//
//
//   void calculateInvoiceTotal(double newItemTotal) async{
//     _invoiceTotal += newItemTotal;
//     _invoiceRemain = _invoiceTotal - _invoicePaid;
//     notifyListeners();
//   }
//
//   void setInvoicePaid(double newPaidAmount) async{
//     _invoicePaid = newPaidAmount;
//     notifyListeners();
//   }
//
//
// }




class ItemsController extends ChangeNotifier {
  GetAllItemsUseCase getAllItemsUseCase;
  ItemsController(this.getAllItemsUseCase);

  bool _getItemsLoading = false;
  String _getItemsErrorMessage = '';
  List<ItemEntity>? _gettingItems;

  // Separate list for invoice items
  List<ItemEntity> _invoiceItems = [];

  bool get getItemsIsLoading => _getItemsLoading;
  String get getItemsErrorMessage => _getItemsErrorMessage;
  List<ItemEntity>? get gettingItems => _gettingItems;

  // Getter for invoice items
  List<ItemEntity> get invoiceItems => _invoiceItems;

  double _invoiceTotal = 0.0;
  double get invoiceTotal => _invoiceTotal;

  Future<void> getItems(NoParameters parameters) async {
    _getItemsLoading = true;
    _getItemsErrorMessage = '';
    notifyListeners();

    try {
      final result = await getAllItemsUseCase(parameters);
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


  // Separate logic for invoice management:

  // Add item to invoice list
  void addItemToInvoice(ItemEntity item) {
    _invoiceItems.add(item);
    _calculateInvoiceTotal();  // Recalculate the total after adding an item
    notifyListeners();
  }


  // Remove item from invoice list
  void removeItemFromInvoice(ItemEntity item) {
    _invoiceItems.remove(item);
    _calculateInvoiceTotal();  // Recalculate the total after adding an item
    notifyListeners();
  }

  // Update item in the invoice list
  void updateInvoiceItem(ItemEntity updatedItem) {
    final index = _invoiceItems.indexWhere((item) => item.id == updatedItem.id);
    if (index != -1) {
      _invoiceItems[index] = updatedItem;
      _calculateInvoiceTotal();  // Recalculate the total after adding an item
      notifyListeners();
    }
  }


  // Method to calculate the total price of invoice items
  void _calculateInvoiceTotal() {
    _invoiceTotal = _invoiceItems.fold(0.0, (sum, item) => sum + (item.itemTotalPrice ?? 0.0));
    // This assumes itemTotalPrice is a double. If it's nullable, default to 0.0 if null.
  }


  ItemEntity? _currentItem;
  ItemEntity? get currentItem => _currentItem;


  setCurrentItem(ItemEntity? newItemEntity) async{
    _currentItem = newItemEntity;
    notifyListeners();
  }

  updateCurrentItem(ItemEntity newUpdateItemEntity) async{
    _currentItem = newUpdateItemEntity;
    notifyListeners();
  }


clearItemsList(){
  _invoiceItems.clear();
  notifyListeners();
}


}