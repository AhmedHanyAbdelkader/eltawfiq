import 'package:dartz/dartz.dart';
import 'package:eltawfiq_suppliers/core/error/failure.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/section_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/repository/suppliers_base_repository.dart';

class SectionsUseCase extends BaseUseCase<List<SectionEntity>, NoParameters>{
  SuppliersBaseRepository suppliersBaseRepository;
  SectionsUseCase(this.suppliersBaseRepository);

  @override
  Future<Either<Failure, List<SectionEntity>>> call(NoParameters parameter) async{
    return await suppliersBaseRepository.getSections(parameter);
  }

}