// import 'package:dartz/dartz.dart';
// import 'package:eltawfiq_suppliers/authentication/domain/repository/auth_base_repository.dart';
// import 'package:eltawfiq_suppliers/core/error/failure.dart';
// import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
//
// class GetTokenUseCase extends BaseUseCase<String, NoParameters>{
//   final AuthBaseRepository authBaseRepository;
//
//   GetTokenUseCase(this.authBaseRepository);
//
//   @override
//   Future<Either<Failure,String>> call(NoParameters noParameters) async {
//     return await authBaseRepository.getToken(noParameters);
//   }
// }