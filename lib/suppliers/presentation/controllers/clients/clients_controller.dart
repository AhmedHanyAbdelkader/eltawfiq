import 'dart:async';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/supplier_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/clients/get_all_clients_use_case.dart';
import 'package:flutter/material.dart';

class ClientsController extends ChangeNotifier{
  GetAllClientsUseCase getAllClientsUseCase;
  ClientsController(this.getAllClientsUseCase);

  bool _getClientsIsLoading = false;
  String _getClientsErrorMessage = '';
  List<SupplierEntity>? _gettingClients;

  bool get getClientsIsLoading => _getClientsIsLoading;
  String get getClientsErrorMessage => _getClientsErrorMessage;
  List<SupplierEntity>? get gettingClients => _gettingClients;


  FutureOr<void> getClients(NoParameters parameters) async{
    _getClientsIsLoading = true;
    _getClientsErrorMessage = '';
    notifyListeners();

    try{
      final result = await getAllClientsUseCase(parameters);
      result.fold(
            (l) {
          _getClientsIsLoading = false;
          _getClientsErrorMessage = l.message;
          notifyListeners();
        },
            (r) {
          _getClientsIsLoading = false;
          _gettingClients = r;
          notifyListeners();
        },
      );
    }catch(e){
      _getClientsErrorMessage = 'An unexpected error occurred $e';
    }finally{
      _getClientsIsLoading = false;
      notifyListeners();
    }

  }


  List<SupplierEntity> getSuggestions(String query) {
    if (_gettingClients == null) return [];
    return _gettingClients!.where((supplier) {
      return supplier.supplierName!.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }


}