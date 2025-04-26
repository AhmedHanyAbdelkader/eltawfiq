import 'package:dartz/dartz.dart';
import 'package:eltawfiq_suppliers/core/error/failure.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/repository/suppliers_base_repository.dart';
import 'package:equatable/equatable.dart';

class EditGroupUseCase extends BaseUseCase<int, EditGroupParameters>{
  SuppliersBaseRepository suppliersBaseRepository;
  EditGroupUseCase(this.suppliersBaseRepository);
  @override
  Future<Either<Failure, int>> call(EditGroupParameters parameter) async{
    return await suppliersBaseRepository.editGroup(parameter);
  }

}


class EditGroupParameters extends Equatable{
  final int? id;
  final String? groupName;


  const EditGroupParameters({
    this.id,
    this.groupName,
  });

  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = {};
    data['id'] = id;
    data['groupName'] = groupName;
    return data;
  }

  @override
  List<Object?> get props => [
    id,
    groupName,
  ];
}