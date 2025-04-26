import 'package:dartz/dartz.dart';
import 'package:eltawfiq_suppliers/core/error/exceptions.dart';
import 'package:eltawfiq_suppliers/core/error/failure.dart';
import 'package:eltawfiq_suppliers/suppliers_module/data/data_source/suppliers_remote_data_source.dart';
import 'package:eltawfiq_suppliers/suppliers_module/domain/entities/supplier_entity.dart';
import 'package:eltawfiq_suppliers/suppliers_module/domain/repository/suppliers_base_repository.dart';
import 'package:eltawfiq_suppliers/suppliers_module/domain/use_cases/add_new_supplier_use_case.dart';

class SuppliersRepository extends SuppliersBaseRepository {
  final SuppliersRemoteDataSource suppliersRemoteDataSource;

  SuppliersRepository(this.suppliersRemoteDataSource);

  @override
  Future<Either<Failure, List<SupplierEntity>>> getSuppliers(int id) async{
    try {
      final result = await suppliersRemoteDataSource.getYourSuppliers(id);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statueMessage));
    }
  }

  @override
  Future<Either<Failure, int>> addNewSupplier(AddNewSupplierParameters addNewSupplierParameters) async
  {
    try {
      final result = await suppliersRemoteDataSource.addNewSupplier(addNewSupplierParameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statueMessage));
    }
  }

}