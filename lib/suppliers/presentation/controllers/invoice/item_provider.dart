import 'package:eltawfiq_suppliers/suppliers/domain/entities/item_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemProvider with ChangeNotifier {
  List<ItemEntity> _items = [];
  ItemEntity? _selectedItem;

  List<ItemEntity> get items => _items;
  ItemEntity? get selectedItem => _selectedItem;

  void setItems(List<ItemEntity> newItems) {
    _items = newItems;
    notifyListeners();
  }

  void setSelectedItem(ItemEntity item) {
    _selectedItem = item;
    notifyListeners();
  }

  void clearSelectedItem() {
    _selectedItem = null;
    notifyListeners();
  }
}
