import 'package:dartz/dartz.dart';
import 'package:eltawfiq_suppliers/core/error/failure.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/repository/suppliers_base_repository.dart';
import 'package:equatable/equatable.dart';

class AddNewGroupUseCase extends BaseUseCase<int, AddNewGroupParameters>{
  SuppliersBaseRepository suppliersBaseRepository;
  AddNewGroupUseCase(this.suppliersBaseRepository);
  @override
  Future<Either<Failure, int>> call(AddNewGroupParameters parameter) async {
    return await suppliersBaseRepository.addNewGroup(parameter);
  }
  }

  class AddNewGroupParameters extends Equatable{
    final String? groupName;

    const AddNewGroupParameters({
      this.groupName,
    });


    Map<String, dynamic> toJson(){
      Map<String, dynamic> data = {};
      data['groupName'] = groupName;
      return data;
    }

    @override
    List<Object?> get props => [
      groupName,
    ];
  }