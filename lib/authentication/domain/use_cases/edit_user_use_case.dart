import 'package:dartz/dartz.dart';
import 'package:eltawfiq_suppliers/authentication/domain/repository/auth_base_repository.dart';
import 'package:eltawfiq_suppliers/core/error/failure.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:equatable/equatable.dart';

class EditUserUseCase extends BaseUseCase<int, EditUserParameters>{
  AuthBaseRepository authBaseRepository;
  EditUserUseCase(this.authBaseRepository);

  @override
  Future<Either<Failure, int>> call(EditUserParameters parameter) async
  {
    return await authBaseRepository.editUser(parameter);
  }

}


class EditUserParameters extends Equatable{
  final int id;
  final String name;
  final String password;
  final String email;
  final String phone;
  final int roleId;

  const EditUserParameters({
    required this.id,
    required this.name,
    required this.password,
    required this.email,
    required this.phone,
    required this.roleId,
  });

  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['password'] = password;
    data['email'] = email;
    data['phone'] = phone;
    data['roleId'] = roleId;
    return data;
  }

  @override
  List<Object?> get props => [
    id,
    name,
    password,
    email,
    phone,
    roleId,
  ];
}