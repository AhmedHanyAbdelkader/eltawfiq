import 'dart:async';
import 'package:eltawfiq_suppliers/authentication/domain/entities/search_result_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/search/search_use_case.dart';
import 'package:flutter/material.dart';

class SsearchController extends ChangeNotifier {
  final SearchUseCase searchUseCase;

  SsearchController(this.searchUseCase);

  bool _searchIsLoading = false;
  String _searchErrorMessage = '';
  SearchResultsEntity? _gettingSearchResult;

  bool get searchIsLoading => _searchIsLoading;
  String get searchErrorMessage => _searchErrorMessage;
  SearchResultsEntity? get gettingSearchResult => _gettingSearchResult;

  Future<void> search(String query) async {
    _searchIsLoading = true;
    _searchErrorMessage = '';
    _gettingSearchResult = null;
    notifyListeners();
    try {
      final result = await searchUseCase(query);
      result.fold(
            (l) {
          _searchErrorMessage = l.message;
          _gettingSearchResult = null; // Ensure results are cleared on error
        },
            (r) {
          _gettingSearchResult = r;
        },
      );
    } catch (e) {
      _searchErrorMessage = 'An unexpected error occurred: $e';
      _gettingSearchResult = null; // Ensure results are cleared on exception
    } finally {
      _searchIsLoading = false;
      notifyListeners(); // Notify listeners again after updating search status
    }
  }
}


