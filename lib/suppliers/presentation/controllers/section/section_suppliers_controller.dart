import 'dart:async';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/supplier_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/section/get_all_section_suppliers_use_case.dart';
import 'package:flutter/material.dart';

class SectionSupplierController extends ChangeNotifier{
  GetAllSectionSuppliersUseCase getAllSectionSuppliersUseCase;
  SectionSupplierController(this.getAllSectionSuppliersUseCase);

  bool _getSectionSuppliersIsLoading = false;
  String _getSectionSuppliersErrorMessage = '';
  List<SupplierEntity>? _gettingSectionSuppliers;

  bool get getSectionSuppliersIsLoading => _getSectionSuppliersIsLoading;
  String get getSectionSuppliersErrorMessage => _getSectionSuppliersErrorMessage;
  List<SupplierEntity>? get gettingSectionSuppliers => _gettingSectionSuppliers;


  FutureOr<void> getSuppliers(int parameters) async{
    _getSectionSuppliersIsLoading = true;
    _getSectionSuppliersErrorMessage = '';
    notifyListeners();

    try{
      final result = await getAllSectionSuppliersUseCase(parameters);
      result.fold(
            (l) {
          _getSectionSuppliersIsLoading = false;
          _getSectionSuppliersErrorMessage = l.message;
          notifyListeners();
        },
            (r) {
          _getSectionSuppliersIsLoading = false;
          _gettingSectionSuppliers = r;
          notifyListeners();
        },
      );
    }catch(e){
      _getSectionSuppliersErrorMessage = 'An unexpected error occurred $e';
    }finally{
      _getSectionSuppliersIsLoading = false;
      notifyListeners();
    }

  }


  List<SupplierEntity> getSuggestions(String query) {
    if (_gettingSectionSuppliers == null) return [];
    return _gettingSectionSuppliers!.where((supplier) {
      return supplier.supplierName!.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }


}