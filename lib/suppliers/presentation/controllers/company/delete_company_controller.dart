import 'dart:async';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/company/delete_company_use_case.dart';
import 'package:flutter/cupertino.dart';

class DeleteCompanyController extends ChangeNotifier{
  DeleteCompanyUseCase deleteCompanyUseCase;
  DeleteCompanyController(this.deleteCompanyUseCase);

  bool _deleteCompanyIsLoading = false;
  String _deleteCompanyErrorMessage = '';
  int? _deleteCompanyResult;

  bool get deleteIsLoading => _deleteCompanyIsLoading;
  String get deleteCompanyErrorMessage => _deleteCompanyErrorMessage;
  int? get deleteCompanyResult => _deleteCompanyResult;

  FutureOr<void> deleteCompany(int companyId)async
  {
    _deleteCompanyIsLoading = true;
    _deleteCompanyErrorMessage = '';
    notifyListeners();
    try{
      final result = await deleteCompanyUseCase(companyId);
      result.fold(
            (l) {
          _deleteCompanyErrorMessage = l.message;
        },
            (r) {
          _deleteCompanyResult = r;
        },
      );
    }catch(e){
      _deleteCompanyErrorMessage = 'An unexpected error occurred $e';
    }finally{
      _deleteCompanyIsLoading = false;
      notifyListeners();
    }
  }

}