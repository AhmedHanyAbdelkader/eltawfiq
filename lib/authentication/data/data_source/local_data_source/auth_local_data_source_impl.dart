// import 'package:eltawfiq_suppliers/authentication/data/data_source/local_data_source/auth_local_data_source.dart';
// import 'package:eltawfiq_suppliers/authentication/data/data_source/local_data_source/shred_prefs_helper.dart';
// import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
//
// class AuthLocalDataSourceImpl implements AuthLocalDataSource {
//   final SharedPreferencesHelper sharedPreferencesHelper;
//
//   AuthLocalDataSourceImpl(this.sharedPreferencesHelper);
//
//   @override
//   Future<void> saveToken(String token) async {
//     return sharedPreferencesHelper.saveToken(token);
//   }
//
//   @override
//   Future<String> getToken(NoParameters noParameters) async {
//     return sharedPreferencesHelper.getToken();
//   }
//
//   @override
//   Future<void> clearToken() async {
//     return sharedPreferencesHelper.clearToken();
//   }
// }