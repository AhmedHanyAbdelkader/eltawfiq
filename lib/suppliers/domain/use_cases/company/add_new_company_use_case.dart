import 'package:dartz/dartz.dart';
import 'package:eltawfiq_suppliers/core/error/failure.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/repository/suppliers_base_repository.dart';
import 'package:equatable/equatable.dart';

class AddNewCompanyUseCase extends BaseUseCase<int, AddNewCompanyParameters>{
  SuppliersBaseRepository suppliersBaseRepository;
  AddNewCompanyUseCase(this.suppliersBaseRepository);
  @override
  Future<Either<Failure, int>> call(AddNewCompanyParameters parameter) async {
    return await suppliersBaseRepository.addNewCompany(parameter);
  }
  }

  class AddNewCompanyParameters extends Equatable{
    final String? companyName;
    final String? companyDescription;


    const AddNewCompanyParameters({
      this.companyName,
      this.companyDescription
    });


    Map<String, dynamic> toJson(){
      Map<String, dynamic> data = {};
      data['companyName'] = companyName;
      data['companyDescription'] = companyDescription;

      return data;
    }

    @override
    List<Object?> get props => [
      companyName,
      companyDescription,
    ];
  }