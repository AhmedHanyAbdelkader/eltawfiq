import 'package:dartz/dartz.dart';
import 'package:eltawfiq_suppliers/core/error/failure.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/repository/suppliers_base_repository.dart';
import 'package:equatable/equatable.dart';

class AddNewSectionUseCase extends BaseUseCase<int, AddNewSectionParameters>{
  SuppliersBaseRepository suppliersBaseRepository;
  AddNewSectionUseCase(this.suppliersBaseRepository);
  @override
  Future<Either<Failure, int>> call(AddNewSectionParameters parameter) async {
    return await suppliersBaseRepository.addNewSection(parameter);
  }
  }

  class AddNewSectionParameters extends Equatable{
    final String? sectionName;

    const AddNewSectionParameters({
      this.sectionName,
    });


    Map<String, dynamic> toJson(){
      Map<String, dynamic> data = {};
      data['sectionName'] = sectionName;
      return data;
    }

    @override
    List<Object?> get props => [
      sectionName,
    ];
  }