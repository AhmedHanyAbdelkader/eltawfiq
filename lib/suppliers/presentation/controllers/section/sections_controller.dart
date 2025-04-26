import 'dart:async';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/section_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/section/get_all_section_use_case.dart';
import 'package:flutter/cupertino.dart';

class SectionsController extends ChangeNotifier{
  SectionsUseCase getAllSectionUseCase;
  SectionsController(this.getAllSectionUseCase);

  bool _getSectionsLoading = false;
  String _getSectionsErrorMessage = '';
  List<SectionEntity>? _gettingSections;

  bool get getSectionsIsLoading => _getSectionsLoading;
  String get getSectionsErrorMessage => _getSectionsErrorMessage;
  List<SectionEntity>? get gettingSections => _gettingSections;


  FutureOr<void> getSections(NoParameters parameters) async{
    _getSectionsLoading = true;
    _getSectionsErrorMessage = '';
    notifyListeners();

    try{
      final result = await getAllSectionUseCase(parameters);
      result.fold(
            (l) {
          _getSectionsLoading = false;
          _getSectionsErrorMessage = l.message;
          notifyListeners();
        },
            (r) {
          _getSectionsLoading = false;
          _gettingSections = r;
          notifyListeners();
        },
      );
    }catch(e){
      _getSectionsErrorMessage = 'An unexpected error occurred $e';
    }finally{
      _getSectionsLoading = false;
      notifyListeners();
    }

  }

  List<SectionEntity> getSuggestions(String query) {
    if (_gettingSections == null) return [];
    return _gettingSections!.where((section) {
      return section.sectionName!.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }


}