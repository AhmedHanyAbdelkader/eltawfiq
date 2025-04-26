import 'package:dartz/dartz.dart';
import 'package:eltawfiq_suppliers/authentication/domain/entities/user_entity.dart';
import 'package:eltawfiq_suppliers/authentication/domain/repository/auth_base_repository.dart';
import 'package:eltawfiq_suppliers/core/error/failure.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:equatable/equatable.dart';

class LoginUserUseCase extends BaseUseCase<UserEntity,LoginUserParameters>{
  AuthBaseRepository authBaseRepository;
  LoginUserUseCase(this.authBaseRepository);

  @override
  Future<Either<Failure, UserEntity>> call(LoginUserParameters parameter) async{
    return await authBaseRepository.loginUser(parameter);
  }

}


class LoginUserParameters extends Equatable{
  final String email;
  final String password;

  const LoginUserParameters({
    required this.email,
    required this.password,
});

  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = {};
    data['email'] = email;
    data['password'] = password;
    return data;
  }


  @override
  List<Object?> get props => [
    email,
    password,
  ];

}