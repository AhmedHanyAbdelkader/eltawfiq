import 'dart:async';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/section/edit_section_use_case.dart';
import 'package:flutter/cupertino.dart';

class EditSecttionController extends ChangeNotifier{
  EditSecttionUseCase editSectionUseCase;
  EditSecttionController(this.editSectionUseCase);

  bool _editSectionIsLoading = false;
  String _editSectionErrorMessage = '';
  int? _editSectionResult;

  bool get editSectionIsLoading => _editSectionIsLoading;
  String get editSectionErrorMessage => _editSectionErrorMessage;
  int? get editSectionResult => _editSectionResult;

  FutureOr<void> editSections(UpdateSectionParameters editSectionParameters) async
  {
    _editSectionIsLoading = true;
    _editSectionErrorMessage = '';
    notifyListeners();
    try{
      final result = await editSectionUseCase(editSectionParameters);
      result.fold(
            (failure) {
          _editSectionErrorMessage = failure.message;
        },
            (result) {
          _editSectionResult = result;
        },
      );
    }catch(e){
      _editSectionErrorMessage = 'An unexpected error occurred $e';
    }finally{
      _editSectionIsLoading = false;
      notifyListeners();
    }
  }


}