import 'dart:async';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/company/add_new_company_use_case.dart';
import 'package:flutter/cupertino.dart';

class AddNewCompanyController extends ChangeNotifier{
  AddNewCompanyUseCase addNewCompanyUseCase;
  AddNewCompanyController(this.addNewCompanyUseCase);

  bool _addNewCompanyIsLoading = false;
  String _addNewCompanyErrorMessage = '';
  int? _addNewCompanyResult;

  bool get addNewCompanyIsLoading => _addNewCompanyIsLoading;
  String get addNewCompanyErrorMessage => _addNewCompanyErrorMessage;
  int? get addNewCompanyResult => _addNewCompanyResult;

  FutureOr<void> addNewCompany(AddNewCompanyParameters addNewCompanyParameter) async{
    _addNewCompanyIsLoading = true;
    _addNewCompanyErrorMessage = '';
    notifyListeners();

    try{
      final result = await addNewCompanyUseCase(addNewCompanyParameter);
      result.fold(
            (failure) {
          _addNewCompanyErrorMessage = failure.message;
        },
            (result) {
          _addNewCompanyResult = result;
        },
      );
    }catch(e){
      _addNewCompanyErrorMessage = 'An unexpected error occurred $e';
    }finally{
      _addNewCompanyIsLoading = false;
      notifyListeners();
    }
  }

}