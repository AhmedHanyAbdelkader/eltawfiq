import 'package:dartz/dartz.dart';
import 'package:eltawfiq_suppliers/core/error/failure.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/repository/suppliers_base_repository.dart';
import 'package:equatable/equatable.dart';

class EditCompanyUseCase extends BaseUseCase<int, EditCompanyParameters>{
  SuppliersBaseRepository suppliersBaseRepository;
  EditCompanyUseCase(this.suppliersBaseRepository);
  @override
  Future<Either<Failure, int>> call(EditCompanyParameters parameter) async{
    return await suppliersBaseRepository.editCompany(parameter);
  }

}


class EditCompanyParameters extends Equatable{
  final int? id;
  final String? companyName;
  final String? companyDescription;


  const EditCompanyParameters({
    this.id,
    this.companyName,
    this.companyDescription,
  });

  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = {};
    data['id'] = id;
    data['companyName'] = companyName;
    data['companyDescription'] = companyDescription;
    return data;
  }

  @override
  List<Object?> get props => [
    id,
    companyName,
    companyDescription,
  ];
}