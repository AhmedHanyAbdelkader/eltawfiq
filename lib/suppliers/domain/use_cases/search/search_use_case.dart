import 'package:dartz/dartz.dart';
import 'package:eltawfiq_suppliers/authentication/domain/entities/search_result_entity.dart';
import 'package:eltawfiq_suppliers/core/error/failure.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/repository/suppliers_base_repository.dart';

class SearchUseCase extends BaseUseCase<SearchResultsEntity, String>{
  SuppliersBaseRepository suppliersBaseRepository;
  SearchUseCase(this.suppliersBaseRepository);

  @override
  Future<Either<Failure, SearchResultsEntity>> call(String parameter) async{
    return await suppliersBaseRepository.search(parameter);
  }

}