import 'dart:async';

import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/company_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/company/get_all_companies_use_case.dart';
import 'package:flutter/cupertino.dart';

class CompaniesController extends ChangeNotifier{
  GetAllCompaniesUseCase getAllCompaniesUseCase;
  CompaniesController(this.getAllCompaniesUseCase);

  bool _getCompaniessLoading = false;
  String _getCompaniesErrorMessage = '';
  List<CompanyEntity>? _gettingCompanies;

  bool get getCompaniesIsLoading => _getCompaniessLoading;
  String get getCompaniesErrorMessage => _getCompaniesErrorMessage;
  List<CompanyEntity>? get gettingCompanies => _gettingCompanies;


  FutureOr<void> getCompanies(NoParameters parameters) async{
    _getCompaniessLoading = true;
    _getCompaniesErrorMessage = '';
    notifyListeners();

    try{
      final result = await getAllCompaniesUseCase(parameters);
      result.fold(
            (l) {
          _getCompaniessLoading = false;
          _getCompaniesErrorMessage = l.message;
          notifyListeners();
        },
            (r) {
          _getCompaniessLoading = false;
          _gettingCompanies = r;
          notifyListeners();
        },
      );
    }catch(e){
      _getCompaniesErrorMessage = 'An unexpected error occurred $e';
    }finally{
      _getCompaniessLoading = false;
      notifyListeners();
    }

  }

}