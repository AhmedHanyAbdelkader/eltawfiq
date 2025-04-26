import 'dart:async';

import 'package:eltawfiq_suppliers/data/app_data_source.dart';
import 'package:eltawfiq_suppliers/model/item_model.dart';
import 'package:eltawfiq_suppliers/model/supplier_model.dart';
import 'package:flutter/material.dart';

class ItemSearchProvider extends ChangeNotifier {

  AppDataSource appDataSource;
  ItemSearchProvider(this.appDataSource);

  bool _searchItemIsLoading = false;
  String _searchItemErrorMessage = "";
  List<ItemModel>? _searchItemResult;
  bool get searchItemIsLoading => _searchItemIsLoading;
  String get searchItemErrorMessage => _searchItemErrorMessage;
  List<ItemModel>? get searchItemResult => _searchItemResult;

  FutureOr<void> serachItem(
      {required String query, required int userId}) async {
    _searchItemIsLoading = true;
    notifyListeners();
    try {
      final result = await appDataSource.searchItems(
          query: query, userId: userId);
      _searchItemResult = result;
    } catch (e) {
      _searchItemErrorMessage = e.toString();
    } finally {
      _searchItemIsLoading = false;
      notifyListeners();
    }
  }
}


class SupplierSearchProvider extends ChangeNotifier {

  AppDataSource appDataSource;
  SupplierSearchProvider(this.appDataSource);

  bool _searchSupplierIsLoading = false;
  String _searchSupplierErrorMessage = "";
  List<SupplierModel>? _searchSupplierResult;
  bool get searchSupplierIsLoading =>  _searchSupplierIsLoading;
  String get searchSupplierErrorMessage =>  _searchSupplierErrorMessage;
  List<SupplierModel>? get searchSupplierResult => _searchSupplierResult;

  FutureOr<void> serachSupplier({required String query})async{
    _searchSupplierIsLoading = true;
    notifyListeners();
    try{
      final result = await appDataSource.searchSuppliers(query);
      _searchSupplierResult = result;
    }catch(e){
      _searchSupplierErrorMessage = e.toString();
    }finally{
      _searchSupplierIsLoading = false;
      notifyListeners();
    }
  }

  }
