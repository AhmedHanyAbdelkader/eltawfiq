import 'dart:async';

import 'package:eltawfiq_suppliers/authentication/domain/entities/role_entity.dart';
import 'package:eltawfiq_suppliers/authentication/domain/use_cases/get_roles_use_case.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:flutter/cupertino.dart';

class RolesController extends ChangeNotifier {
  final GetRolesUseCase getRolesUseCase;
  RolesController(this.getRolesUseCase);

  bool _getRolesIsLoading = false;
  String _getRolesErrorMessage = '';
  List<RoleEntity>? _gettingRoles;

  bool get getRolesIsLoading => _getRolesIsLoading;
  String get getRolesErrorMessage => _getRolesErrorMessage;
  List<RoleEntity>? get gettingRoles => _gettingRoles;

  FutureOr<void> getRoles(NoParameters noParameters) async {
    _getRolesIsLoading = true;
    _getRolesErrorMessage = '';
    notifyListeners();
    try {
      final result = await getRolesUseCase(noParameters);
      result.fold(
            (failure) {
          _getRolesErrorMessage = failure.message;
        },
            (roles) {
          _gettingRoles = roles;
        },
      );
    } catch (e) {
      _getRolesErrorMessage = 'An unexpected error occurred $e';
    } finally {
      _getRolesIsLoading = false;
      notifyListeners();
    }
  }
}
