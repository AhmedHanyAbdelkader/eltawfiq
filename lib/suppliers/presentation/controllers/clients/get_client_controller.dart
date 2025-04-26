import 'dart:async';

import 'package:eltawfiq_suppliers/suppliers/domain/entities/supplier_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/clients/get_client_use_case.dart';
import 'package:flutter/material.dart';

class GetClientController extends ChangeNotifier{
  GetClientUseCase getClientUseCase;
  GetClientController(this.getClientUseCase);

  bool _getClientsIsLoading = false;
  String _getClientErrorMessage = '';
  SupplierEntity? _gettingClient;

  bool get getClientIsLoading => _getClientsIsLoading;
  String get getClientErrorMessage => _getClientErrorMessage;
  SupplierEntity? get gettingClient => _gettingClient;


  FutureOr<void> getClient(int parameters) async{
    _getClientsIsLoading = true;
    _getClientErrorMessage = '';
    notifyListeners();

    try{
      final result = await getClientUseCase(parameters);
      result.fold(
            (l) {
              _getClientsIsLoading = false;
          _getClientErrorMessage = l.message;
          notifyListeners();
        },
            (r) {
          _getClientsIsLoading = false;
          _gettingClient = r;
          notifyListeners();
        },
      );
    }catch(e){
      _getClientErrorMessage = 'An unexpected error occurred $e';
    }finally{
      _getClientsIsLoading = false;
      notifyListeners();
    }

  }

}