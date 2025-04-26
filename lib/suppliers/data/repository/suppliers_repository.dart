import 'package:dartz/dartz.dart';
import 'package:eltawfiq_suppliers/authentication/data/models/search_result_model.dart';
import 'package:eltawfiq_suppliers/authentication/domain/entities/search_result_entity.dart';
import 'package:eltawfiq_suppliers/core/error/exceptions.dart';
import 'package:eltawfiq_suppliers/core/error/failure.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/data/data_source/remote_data_source/suppliers_remote_data_source.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/company_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/group_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/item_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/item_history_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/item_operation_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/section_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/supplier_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/supplier_invoice_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/supplier_payment_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/repository/suppliers_base_repository.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/company/add_new_company_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/company/edit_company_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/group/add_new_group_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/group/edit_group_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/item/add_new_item_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/item/edit_item_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/item/get_item_history_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/payment/add_new_supplier_payment_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/section/add_new_section_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/section/edit_section_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/supplier/add_new_supplier_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/supplier/edit_supplier_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/invoice/add_new_supplier_invoice_use_case.dart';

class SuppliersRepository extends SuppliersBaseRepository{

  final SuppliersRemoteDataSource suppliersRemoteDataSource;

  SuppliersRepository(this.suppliersRemoteDataSource);

  @override
  Future<Either<Failure, int>> addNewSupplier(AddNewSupplierParameter addNewSupplierParameter) async{
    try {
      final result = await suppliersRemoteDataSource.addNewSupplier(addNewSupplierParameter);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statueMessage));
    }
  }

  @override
  Future<Either<Failure, SupplierEntity>> getSupplier(int supplierId) async{
    try {
      final result = await suppliersRemoteDataSource.getSupplier(supplierId);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statueMessage));
    }
  }

  @override
  Future<Either<Failure, int>> deleteSupplier(int deleteSupplierParameter) async{
    try {
      final result = await suppliersRemoteDataSource.deleteSupplier(deleteSupplierParameter);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statueMessage));
    }
  }

  @override
  Future<Either<Failure, int>> editSupplier(EditSupplierParameters editSupplierParameters) async{
    try {
      final result = await suppliersRemoteDataSource.editSupplier(editSupplierParameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statueMessage));
    }
  }

  @override
  Future<Either<Failure, List<SupplierEntity>>> getSuppliers(NoParameters noParameters) async{
    try {
      final result = await suppliersRemoteDataSource.getYourSuppliers(
          noParameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statueMessage));
    }
  }

  @override
  Future<Either<Failure, List<CompanyEntity>>> getCompanies(NoParameters noParameters) async{
    try {
      final result = await suppliersRemoteDataSource.getCompanies(noParameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statueMessage));
    }
  }

  @override
  Future<Either<Failure, int>> deleteCompany(int deleteCompanyParameter) async{
    try {
      final result = await suppliersRemoteDataSource.deleteCompany(deleteCompanyParameter);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statueMessage));
    }
  }

  @override
  Future<Either<Failure, int>> editCompany(EditCompanyParameters editCompanyParameters) async{
    try {
      final result = await suppliersRemoteDataSource.editCompany(editCompanyParameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statueMessage));
    }
  }

  @override
  Future<Either<Failure, int>> addNewCompany(AddNewCompanyParameters addNewCompanyParameters) async{
    try {
      final result = await suppliersRemoteDataSource.addNewCompany(addNewCompanyParameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statueMessage));
    }
  }

  @override
  Future<Either<Failure, int>> addNewGroup(AddNewGroupParameters addNewGroupParameters) async{
    try {
      final result = await suppliersRemoteDataSource.addNewGroup(addNewGroupParameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statueMessage));
    }
  }

  @override
  Future<Either<Failure, int>> deleteGroup(int deleteGroupParameter) async{
    try {
      final result = await suppliersRemoteDataSource.deleteGroup(deleteGroupParameter);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statueMessage));
    }
  }

  @override
  Future<Either<Failure, int>> editGroup(EditGroupParameters editGroupParameters) async{
    try {
      final result = await suppliersRemoteDataSource.editGroup(editGroupParameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statueMessage));
    }
  }

  @override
  Future<Either<Failure, List<GroupEntity>>> getGroups(NoParameters noParameters) async{
    try {
      final result = await suppliersRemoteDataSource.getGroups(noParameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statueMessage));
    }
  }

  @override
  Future<Either<Failure, int>> addNewSection(AddNewSectionParameters addNewSectionParameters) async{
    try {
      final result = await suppliersRemoteDataSource.addNewSection(addNewSectionParameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statueMessage));
    }
  }

  @override
  Future<Either<Failure, int>> deleteSection(int deleteSectionParameter) async{
    try {
      final result = await suppliersRemoteDataSource.deleteSection(deleteSectionParameter);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statueMessage));
    }
  }

  @override
  Future<Either<Failure, int>> editSection(UpdateSectionParameters updateSectionParameters) async{
    try {
      final result = await suppliersRemoteDataSource.editSection(updateSectionParameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statueMessage));
    }
  }

  @override
  Future<Either<Failure, List<SectionEntity>>> getSections(NoParameters noParameters) async{
    try {
      final result = await suppliersRemoteDataSource.getSections(noParameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statueMessage));
    }
  }

  @override
  Future<Either<Failure, List<SupplierInvoiceEntity>>> getInvoices(NoParameters noParameters) async{
    try {
      final result = await suppliersRemoteDataSource.getInvoices(noParameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statueMessage));
    }
  }

  @override
  Future<Either<Failure, SupplierInvoiceEntity>> getInvoiceById(int id) async{
    try {
      final result = await suppliersRemoteDataSource.getInvoiceById(id);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statueMessage));
    }
  }

  @override
  Future<Either<Failure, int>> addNewInvoice(Map<String,dynamic> addNewSupplierInvoiceParameters)async {
    try {
      final result = await suppliersRemoteDataSource.addNewInvoice(addNewSupplierInvoiceParameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statueMessage));
    }
  }

  @override
  Future<Either<Failure, List<ItemEntity>>> getItems(NoParameters noParameters) async{
    try {
      final result = await suppliersRemoteDataSource.getItems(noParameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statueMessage));
    }
  }


  @override
  Future<Either<Failure, ItemEntity>> getItemDetails(int itemId) async{
    try {
      final result = await suppliersRemoteDataSource.getItemDetails(itemId);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statueMessage));
    }
  }


  @override
  Future<Either<Failure, int>> addNewItem(AddNewItemParameters addNewItemParameters) async{
    try {
      final result = await suppliersRemoteDataSource.addNewItem(addNewItemParameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statueMessage));
    }
  }

  @override
  Future<Either<Failure, int>> deleteItem(int deleteItemParameter) async{
    try {
      final result = await suppliersRemoteDataSource.deleteItem(deleteItemParameter);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statueMessage));
    }
  }

  @override
  Future<Either<Failure, int>> editItem(EditItemParameters editGroupParameters) async{
    try {
      final result = await suppliersRemoteDataSource.editItem(editGroupParameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statueMessage));
    }
  }

  @override
  Future<Either<Failure, List<SupplierEntity>>> getCompanySuppliers(int companyIdParameter) async{
    try {
      final result = await suppliersRemoteDataSource.getCompanySuppliers(companyIdParameter);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statueMessage));
    }
  }

  @override
  Future<Either<Failure, List<SupplierEntity>>> getSectionSuppliers(int sectionIdParameter) async
  {
    try {
      final result = await suppliersRemoteDataSource.getSectionSuppliers(sectionIdParameter);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statueMessage));
    }
  }

  @override
  Future<Either<Failure, List<SupplierPaymentEntity>>> getSupplierPayments(int supplierId) async {
    try {
      final result = await suppliersRemoteDataSource.getSupplierPayments(supplierId);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statueMessage));
    }
  }

  @override
  Future<Either<Failure, List<SupplierInvoiceEntity>>> getSupplierInvoices(int supplierId) async {
    try {
      final result = await suppliersRemoteDataSource.getSupplierInvoices(supplierId);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statueMessage));
    }
  }

  @override
  Future<Either<Failure, List<ItemEntity>>> getSupplierItems(int supplierId) async {
    try {
      final result = await suppliersRemoteDataSource.getSupplierItems(supplierId);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statueMessage));
    }
  }

  @override
  Future<Either<Failure, int>> addNewSupplierPayment(AddNewSupplierPaymentParameters addNewSupplierPaymentParameters)async {
    try {
      final result = await suppliersRemoteDataSource.addNewSupplierPayment(addNewSupplierPaymentParameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statueMessage));
    }
  }

  @override
  Future<Either<Failure, List<ItemOperationEntity>>> getItemOperations(int itemId) async {
    try {
      final result = await suppliersRemoteDataSource.getItemOperations(itemId);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statueMessage));
    }
  }

  @override
  Future<Either<Failure, SearchResultsEntity>> search(String query) async{
    try {
      final result = await suppliersRemoteDataSource.search(query);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statueMessage));
    }
  }

  @override
  Future<Either<Failure, List<SupplierEntity>>> getClients(NoParameters noParameters) async{
    try{
      final result = await suppliersRemoteDataSource.getYourClients(noParameters);
      return Right(result);
    }on ServerException catch (failure){
      return Left(ServerFailure(failure.errorMessageModel.statueMessage));
    }
  }

  @override
  Future<Either<Failure, SupplierEntity>> getClient(int clientId) async{
    try{
      final result = await suppliersRemoteDataSource.getClient(clientId);
      return Right(result);
    }on ServerException catch (failure){
      return Left(ServerFailure(failure.errorMessageModel.statueMessage));
    }
  }

  @override
  Future<Either<Failure, List<ItemEntity>>> getHotItems(int supplierId) async{
    try {
      final result = await suppliersRemoteDataSource.getHotItems(supplierId);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statueMessage));
    }
  }

  @override
  Future<Either<Failure, List<ItemHistoryEntity>>> getItemHistory(GetItemHistoryParameters getItemHistoryParameters) async{
    try {
      final result = await suppliersRemoteDataSource.getItemHistory(getItemHistoryParameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statueMessage));
    }
  }




}