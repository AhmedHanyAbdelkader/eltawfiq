import 'dart:async';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/Section/delete_Section_use_case.dart';
import 'package:flutter/cupertino.dart';

class DeleteSectionController extends ChangeNotifier{
  DeleteSectionUseCase deleteSectionUseCase;
  DeleteSectionController(this.deleteSectionUseCase);

  bool _deleteSectionIsLoading = false;
  String _deleteSectionErrorMessage = '';
  int? _deleteSectionResult;

  bool get deleteSectionIsLoading => _deleteSectionIsLoading;
  String get deleteSectionErrorMessage => _deleteSectionErrorMessage;
  int? get deleteSectionResult => _deleteSectionResult;

  FutureOr<void> deleteSection(int sectionId)async
  {
    _deleteSectionIsLoading = true;
    _deleteSectionErrorMessage = '';
    notifyListeners();
    try{
      final result = await deleteSectionUseCase(sectionId);
      result.fold(
            (l) {
          _deleteSectionErrorMessage = l.message;
        },
            (r) {
          _deleteSectionResult = r;
        },
      );
    }catch(e){
      _deleteSectionErrorMessage = 'An unexpected error occurred $e';
    }finally{
      _deleteSectionIsLoading = false;
      notifyListeners();
    }
  }

}