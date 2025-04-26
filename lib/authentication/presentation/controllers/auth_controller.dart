// import 'package:eltawfiq_suppliers/authentication/domain/use_cases/clean_token_use_case.dart';
// import 'package:eltawfiq_suppliers/authentication/domain/use_cases/get_token_use_case.dart';
// import 'package:eltawfiq_suppliers/authentication/domain/use_cases/save_token_use_case.dart';
// import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
// import 'package:flutter/material.dart';
//
// class AuthController extends ChangeNotifier {
//   final SaveTokenUseCase saveTokenUseCase;
//   final GetTokenUseCase getTokenUseCase;
//   final ClearTokenUseCase clearTokenUseCase;
//
//   AuthController(
//     this.saveTokenUseCase,
//     this.getTokenUseCase,
//     this.clearTokenUseCase,
//   );
//
//   String? getTokenResult;
//
//   Future<String?> checkIfLoggedIn() async {
//     final result = await getTokenUseCase(const NoParameters());
//     return result.fold(
//             (l) => null,
//             (r) {
//               getTokenResult = r;
//             },
//     );
//   }
//
//   Future<void> logout() async {
//     await clearTokenUseCase();
//   }
//
// ///TODO: make splash screen
// ///check id/token from shared prefs
// ///if exists go to home
// ///else go to login
// ///TODO: make a logout button to delete the id/token
//
//
//
// }