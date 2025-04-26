
import 'package:dartz/dartz.dart';
import 'package:eltawfiq_suppliers/authentication/domain/repository/auth_base_repository.dart';
import 'package:eltawfiq_suppliers/core/error/failure.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:equatable/equatable.dart';

class AddNewRoleUseCase extends BaseUseCase<int, AddNewRoleParameters>{
  AuthBaseRepository authBaseRepository;
  AddNewRoleUseCase(this.authBaseRepository);
  @override
  Future<Either<Failure, int>> call(AddNewRoleParameters parameter) async{
    return await authBaseRepository.addNewRole(parameter);
  }

}



class AddNewRoleParameters extends Equatable{
  final String name;
  const AddNewRoleParameters({
    required this.name
  });

  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = {};
    data['roleName'] = name;
    return data;
  }

  @override
  List<Object?> get props => [
    name,
  ];
}