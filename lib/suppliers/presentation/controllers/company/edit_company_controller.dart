import 'dart:async';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/company/edit_company_use_case.dart';
import 'package:flutter/cupertino.dart';

class EditCompanyController extends ChangeNotifier{
  EditCompanyUseCase editCompanyUseCase;
  EditCompanyController(this.editCompanyUseCase);

  bool _editCompanyIsLoading = false;
  String _editCompanyErrorMessage = '';
  int? _editCompanyResult;

  bool get editCompanyIsLoading => _editCompanyIsLoading;
  String get editCompanyErrorMessage => _editCompanyErrorMessage;
  int? get editCompanyResult => _editCompanyResult;

  FutureOr<void> editCompany(EditCompanyParameters editCompanyParameters) async
  {
    _editCompanyIsLoading = true;
    _editCompanyErrorMessage = '';
    notifyListeners();
    try{
      final result = await editCompanyUseCase(editCompanyParameters);
      result.fold(
            (failure) {
          _editCompanyErrorMessage = failure.message;
        },
            (result) {
          _editCompanyResult = result;
        },
      );
    }catch(e){
      _editCompanyErrorMessage = 'An unexpected error occurred $e';
    }finally{
      _editCompanyIsLoading = false;
      notifyListeners();
    }
  }


}