import 'package:dartz/dartz.dart';
import 'package:eltawfiq_suppliers/authentication/domain/repository/auth_base_repository.dart';
import 'package:eltawfiq_suppliers/core/error/failure.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:equatable/equatable.dart';

class EditRoleUseCase extends BaseUseCase<int, EditRoleParameters>{
  AuthBaseRepository authBaseRepository;
  EditRoleUseCase(this.authBaseRepository);

  @override
  Future<Either<Failure, int>> call(EditRoleParameters parameter) async
  {
    return await authBaseRepository.editRole(parameter);
  }

}



class EditRoleParameters extends Equatable{
  final int id;
  final String name;

  const EditRoleParameters({
    required this.id,
    required this.name,
});

  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = {};
    data['id'] = id;
    data['roleName'] = name;
    return data;
  }

  @override
  List<Object?> get props => [
    id,
    name,
  ];

}