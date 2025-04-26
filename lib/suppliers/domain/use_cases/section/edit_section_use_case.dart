import 'package:dartz/dartz.dart';
import 'package:eltawfiq_suppliers/core/error/failure.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/repository/suppliers_base_repository.dart';
import 'package:equatable/equatable.dart';

class EditSecttionUseCase extends BaseUseCase<int, UpdateSectionParameters>{
  SuppliersBaseRepository suppliersBaseRepository;
  EditSecttionUseCase(this.suppliersBaseRepository);

  @override
  Future<Either<Failure, int>> call(UpdateSectionParameters parameter) async{
    return await suppliersBaseRepository.editSection(parameter);
  }


}




class UpdateSectionParameters extends Equatable{
  final int? id;
  final String? sectionName;
  final String? sectionImageUrl;
  final int? order;

  const UpdateSectionParameters({
    this.id,
    this.sectionName,
    this.sectionImageUrl,
    this.order,
  });


  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = {};
    data['id'] = id;
    data['sectionName'] = sectionName;
    data['sectionImageUrl'] = sectionImageUrl;
    data['orderr'] = order;
    return data;
  }

  @override
  List<Object?> get props => [
    id,
    sectionName,
    sectionImageUrl,
    order,
  ];
}