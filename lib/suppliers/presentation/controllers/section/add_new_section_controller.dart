import 'dart:async';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/section/add_new_section_use_case.dart';
import 'package:flutter/cupertino.dart';

class AddNewSectionController extends ChangeNotifier{
  AddNewSectionUseCase addNewSectionUseCase;
  AddNewSectionController(this.addNewSectionUseCase);

  bool _addNewSectionIsLoading = false;
  String _addNewSectionErrorMessage = '';
  int? _addNewSectionResult;

  bool get addNewSectionIsLoading => _addNewSectionIsLoading;
  String get addNewSectionErrorMessage => _addNewSectionErrorMessage;
  int? get addNewSectionResult => _addNewSectionResult;

  FutureOr<void> addNewSection(AddNewSectionParameters addNewSectionParameter) async{
    _addNewSectionIsLoading = true;
    _addNewSectionErrorMessage = '';
    notifyListeners();

    try{
      final result = await addNewSectionUseCase(addNewSectionParameter);
      result.fold(
            (failure) {
          _addNewSectionErrorMessage = failure.message;
        },
            (result) {
          _addNewSectionResult = result;
        },
      );
    }catch(e){
      _addNewSectionErrorMessage = 'An unexpected error occurred $e';
    }finally{
      _addNewSectionIsLoading = false;
      notifyListeners();
    }
  }

}