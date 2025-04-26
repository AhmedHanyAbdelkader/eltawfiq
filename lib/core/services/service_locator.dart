import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:eltawfiq_suppliers/authentication/data/data_source/local_data_source/auth_local_data_source.dart';
import 'package:eltawfiq_suppliers/authentication/data/data_source/local_data_source/auth_local_data_source_impl.dart';
import 'package:eltawfiq_suppliers/authentication/data/data_source/local_data_source/shred_prefs_helper.dart';
import 'package:eltawfiq_suppliers/authentication/data/data_source/remote_data_source/auth_remote_data_source.dart';
import 'package:eltawfiq_suppliers/authentication/data/data_source/remote_data_source/auth_remote_data_source_impl.dart';
import 'package:eltawfiq_suppliers/authentication/data/repository/auth_repo.dart';
import 'package:eltawfiq_suppliers/authentication/domain/repository/auth_base_repository.dart';
import 'package:eltawfiq_suppliers/authentication/domain/use_cases/add_new_role_use_case.dart';
import 'package:eltawfiq_suppliers/authentication/domain/use_cases/add_new_user_use_case.dart';
import 'package:eltawfiq_suppliers/authentication/domain/use_cases/clean_token_use_case.dart';
import 'package:eltawfiq_suppliers/authentication/domain/use_cases/delete_role_use_case.dart';
import 'package:eltawfiq_suppliers/authentication/domain/use_cases/delete_user_use_case.dart';
import 'package:eltawfiq_suppliers/authentication/domain/use_cases/edit_role_use_case.dart';
import 'package:eltawfiq_suppliers/authentication/domain/use_cases/edit_user_use_case.dart';
import 'package:eltawfiq_suppliers/authentication/domain/use_cases/get_roles_use_case.dart';
import 'package:eltawfiq_suppliers/authentication/domain/use_cases/get_token_use_case.dart';
import 'package:eltawfiq_suppliers/authentication/domain/use_cases/get_users_use_case.dart';
import 'package:eltawfiq_suppliers/authentication/domain/use_cases/login_user_use_case.dart';
import 'package:eltawfiq_suppliers/authentication/domain/use_cases/save_token_use_case.dart';
import 'package:eltawfiq_suppliers/authentication/presentation/controllers/add_new_role_controller.dart';
import 'package:eltawfiq_suppliers/authentication/presentation/controllers/add_new_user_controller.dart';
import 'package:eltawfiq_suppliers/authentication/presentation/controllers/auth_controller.dart';
import 'package:eltawfiq_suppliers/authentication/presentation/controllers/delete_role_use_case.dart';
import 'package:eltawfiq_suppliers/authentication/presentation/controllers/delete_user_controller.dart';
import 'package:eltawfiq_suppliers/authentication/presentation/controllers/edit_role_controller.dart';
import 'package:eltawfiq_suppliers/authentication/presentation/controllers/edit_user_controller.dart';
import 'package:eltawfiq_suppliers/authentication/presentation/controllers/login_user_controller.dart';
import 'package:eltawfiq_suppliers/authentication/presentation/controllers/roles_controller.dart';
import 'package:eltawfiq_suppliers/authentication/presentation/controllers/users_controller.dart';
import 'package:eltawfiq_suppliers/controller/app_state_provider.dart';
import 'package:eltawfiq_suppliers/controller/search_state_provider.dart';
import 'package:eltawfiq_suppliers/core/network/network_info.dart';
import 'package:eltawfiq_suppliers/data/app_data_source.dart';
import 'package:eltawfiq_suppliers/suppliers/data/data_source/remote_data_source/suppliers_remote_data_source.dart';
import 'package:eltawfiq_suppliers/suppliers/data/data_source/remote_data_source/suppliers_remote_data_source_impl.dart';
import 'package:eltawfiq_suppliers/suppliers/data/repository/suppliers_repository.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/repository/suppliers_base_repository.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/clients/get_all_clients_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/clients/get_client_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/company/get_all_company_suppliers_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/item/add_new_item_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/Section/delete_Section_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/company/add_new_company_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/company/delete_company_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/company/edit_company_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/group/add_new_group_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/group/delete_group_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/group/edit_group_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/group/get_all_groups_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/invoice/add_new_supplier_invoice_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/invoice/get_all_invoices_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/invoice/get_invoice_by_id_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/item/delete_item_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/item/edit_item_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/item/get_all_items_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/item/get_hot_items_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/item/get_item_history_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/item/get_item_operations_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/item/item_details_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/payment/add_new_supplier_payment_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/search/search_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/section/add_new_section_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/section/edit_section_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/section/get_all_section_suppliers_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/section/get_all_section_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/supplier/add_new_supplier_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/supplier/delete_supplier_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/supplier/edit_supplier_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/company/get_all_companies_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/supplier/get_all_suppliers_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/supplier/get_supplier_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/supplier/supplier_invoices_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/supplier/supplier_items_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/payment/supplier_payments_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/clients/clients_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/clients/get_client_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/company/add_new_company_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/company/company_suppliers_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/company/delete_company_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/company/edit_company_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/group/add_new_group_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/group/delete_group_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/group/edit_group_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/group/groups_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/invoice/add_new_supplier_invoice_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/invoice/invoice_by_id_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/invoice/invoice_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/item/add_new_item_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/item/delete_item_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/item/edit_item_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/item/hot_items_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/item/item_details_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/item/item_history_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/item/item_operations_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/item/items_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/payment/add_new_supplier_payment_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/search/search_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/section/add_new_section_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/section/delete_section_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/section/edit_section_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/section/section_suppliers_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/section/sections_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/supplier/add_new_supplier_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/company/companies_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/supplier/delete_supplier_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/supplier/edit_supplier_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/supplier/get_supplier_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/supplier/get_supplier_invoices_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/supplier/get_supplier_items_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/payment/get_supplier_payments_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/supplier/suppliers_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

class ServiceLocator {
  void init() async{
    // Register NetworkInfo
    sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

    // Register http client
    sl.registerLazySingleton(() => http.Client());

    // Register DataConnectionChecker
    sl.registerLazySingleton(() => DataConnectionChecker());


    // Controllers
   // sl.registerFactory(() => AuthController(sl(), sl(), sl()));
    sl.registerFactory(() => UsersController(sl()));
    sl.registerFactory(() => AddNewUserController(sl()));
    sl.registerFactory(() => EditUserController(sl()));
    sl.registerFactory(() => DeleteUserController(sl()));
    sl.registerFactory(() => LoginUserController(sl()));
    sl.registerFactory(() => RolesController(sl()));
    sl.registerFactory(() => AddNewRoleController(sl()));
    sl.registerFactory(() => EditRoleController(sl()));
    sl.registerFactory(() => DeleteRoleController(sl()));

    sl.registerFactory(() => ClientsController(sl()));
    sl.registerFactory(() => GetClientController(sl()));

    sl.registerFactory(() => SupplierController(sl()));
    sl.registerFactory(() => GetSupplierController(sl()));
    sl.registerFactory(() => AddNewSupplierController(sl()));
    sl.registerFactory(() => EditSupplierController(sl()));
    sl.registerFactory(() => DeleteSupplierController(sl()));
    sl.registerFactory(() => GetSupplierPaymentsPaymentsController(sl()));
    sl.registerFactory(() => GetSupplierInvoicesController(sl()));
    sl.registerFactory(() => GetSupplierItemsController(sl()));
    sl.registerFactory(() => AddNewSupplierPaymentController(sl()));

    sl.registerFactory(() => CompaniesController(sl()));
    sl.registerFactory(() => AddNewCompanyController(sl()));
    sl.registerFactory(() => EditCompanyController(sl()));
    sl.registerFactory(() => DeleteCompanyController(sl()));
    sl.registerFactory(() => CompanySupplierController(sl()));

    sl.registerFactory(() => GroupsController(sl()));
    sl.registerFactory(() => AddNewGroupController(sl()));
    sl.registerFactory(() => EditGroupController(sl()));
    sl.registerFactory(() => DeleteGroupController(sl()));

    sl.registerFactory(() => SectionsController(sl()));
    sl.registerFactory(() => AddNewSectionController(sl()));
    sl.registerFactory(() => EditSecttionController(sl()));
    sl.registerFactory(() => DeleteSectionController(sl()));
    sl.registerFactory(() => SectionSupplierController(sl()));

    sl.registerFactory(() => InvoiceController(sl()));
    sl.registerFactory(() => InvoiceByIdController(sl()));
    sl.registerFactory(() => AddNewSupplierInvoiceController(sl()));

    sl.registerFactory(() => ItemsController(sl()));
    sl.registerFactory(() => HotItemsController(sl()));
    sl.registerFactory(() => ItemHistoryController(sl()));
    sl.registerFactory(() => AddNewItemController(sl()));
    sl.registerFactory(() => DeleteItemController(sl()));
    sl.registerFactory(() => EditItemController(sl()));
    sl.registerFactory(() => ItemOperationsController(sl()));
    sl.registerFactory(() => ItemDetailsController(sl()));

    sl.registerFactory(() => SsearchController(sl()));


    // Use cases
    sl.registerLazySingleton(() => LoginUserUseCase(sl()));
    sl.registerLazySingleton(() => GetUsersUseCase(sl()));
    sl.registerLazySingleton(() => AddNewUserUseCase(sl()));
    sl.registerLazySingleton(() => EditUserUseCase(sl()));
    sl.registerLazySingleton(() => DeleteUserUseCase(sl()));

    sl.registerLazySingleton(() => GetRolesUseCase(sl()));
    sl.registerLazySingleton(() => AddNewRoleUseCase(sl()));
    sl.registerLazySingleton(() => EditRoleUseCase(sl()));
    sl.registerLazySingleton(() => DeleteRoleUseCase(sl()));

    sl.registerLazySingleton(() => GetAllClientsUseCase(sl()));
    sl.registerLazySingleton(() => GetClientUseCase(sl()));

    sl.registerLazySingleton(() => GetAllSuppliersUseCase(sl()));
    sl.registerLazySingleton(() => GetSupplierUseCase(sl()));
    sl.registerLazySingleton(() => AddNewSupplierUseCase(sl()));
    sl.registerLazySingleton(() => EditSupplierUseCase(sl()));
    sl.registerLazySingleton(() => DeleteSupplierUseCase(sl()));
    sl.registerLazySingleton(() => SupplierPaymentsUseCase(sl()));
    sl.registerLazySingleton(() => SupplierInvoicesUseCase(sl()));
    sl.registerLazySingleton(() => SupplierItemsUseCase(sl()));
    sl.registerLazySingleton(() => AddNewSupplierPaymentUseCase(sl()));

    sl.registerLazySingleton(() => GetAllCompaniesUseCase(sl()));
    sl.registerLazySingleton(() => AddNewCompanyUseCase(sl()));
    sl.registerLazySingleton(() => EditCompanyUseCase(sl()));
    sl.registerLazySingleton(() => DeleteCompanyUseCase(sl()));
    sl.registerLazySingleton(() => GetAllCompanySuppliersUseCase(sl()));

    sl.registerLazySingleton(() => GroupsUseCase(sl()));
    sl.registerLazySingleton(() => AddNewGroupUseCase(sl()));
    sl.registerLazySingleton(() => EditGroupUseCase(sl()));
    sl.registerLazySingleton(() => DeleteGroupUseCase(sl()));

    sl.registerLazySingleton(() => SectionsUseCase(sl()));
    sl.registerLazySingleton(() => AddNewSectionUseCase(sl()));
    sl.registerLazySingleton(() => EditSecttionUseCase(sl()));
    sl.registerLazySingleton(() => DeleteSectionUseCase(sl()));
    sl.registerLazySingleton(() => GetAllSectionSuppliersUseCase(sl()));

    sl.registerLazySingleton(() => GetAllInvoicesUseCase(sl()));
    sl.registerLazySingleton(() => GetInvoiceByIdUseCase(sl()));
    sl.registerLazySingleton(() => AddNewSupplierInvoiceUseCase(sl()));

    sl.registerLazySingleton(() => GetAllItemsUseCase(sl()));
    sl.registerLazySingleton(() => GetHotItemsUseCase(sl()));
    sl.registerLazySingleton(() => GetItemsHistoryUseCase(sl()));
    sl.registerLazySingleton(() => AddNewItemUseCase(sl()));
    sl.registerLazySingleton(() => DeleteItemUseCase(sl()));
    sl.registerLazySingleton(() => EditItemUseCase(sl()));
    sl.registerLazySingleton(() => GetItemOperationsUseCase(sl()));
    sl.registerLazySingleton(() => ItemDetailsUseCase(sl()));


    sl.registerLazySingleton(() => SearchUseCase(sl()));


    //
    // // Data Sources
    //
    // final sharedPreferences = await SharedPreferences.getInstance();
    // sl.registerLazySingleton(() => sharedPreferences);
    // // Helper
    // sl.registerLazySingleton(() => SharedPreferencesHelper(sl()));
    //
    // sl.registerLazySingleton<SuppliersRemoteDataSource>(() => SuppliersRemoteDataSourceImpl(client: sl(), networkInfo: sl()));
    // sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(client: sl(), networkInfo: sl()));
    // sl.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSourceImpl(sl()));
    //
    //
    // // Repositories
    // sl.registerLazySingleton<SuppliersBaseRepository>(() => SuppliersRepository(sl()));
    // sl.registerLazySingleton<AuthBaseRepository>(() => AuthRepo(sl(), sl()));
    //
    // // Other Controllers
    // sl.registerFactory(() => AppStateProvider(sl()));
    // sl.registerFactory(() => ItemSearchProvider(sl()));
    // sl.registerFactory(() => SupplierSearchProvider(sl()));
    //
    // // Register AppDataSource
    // sl.registerLazySingleton(() => AppDataSource());
    //
    //
    // sl.registerLazySingleton(() => SaveTokenUseCase(sl()));
    // sl.registerLazySingleton(() => GetTokenUseCase(sl()));
    // sl.registerLazySingleton(() => ClearTokenUseCase(sl()));

    // Data Sources
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => sharedPreferences);

    // Helper
    sl.registerLazySingleton(() => SharedPreferencesHelper(sl()));

    // Remote Data Sources
    sl.registerLazySingleton<SuppliersRemoteDataSource>(() => SuppliersRemoteDataSourceImpl(client: sl(), networkInfo: sl()));
    sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(client: sl(), networkInfo: sl()));

    // Local Data Source
    //sl.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSourceImpl(sl()));

    // Repositories
    sl.registerLazySingleton<SuppliersBaseRepository>(() => SuppliersRepository(sl()));
    sl.registerLazySingleton<AuthBaseRepository>(() => AuthRepo(sl<AuthRemoteDataSource>()));


    // Controllers
    //sl.registerFactory(() => AuthController(sl(), sl(), sl()));
    sl.registerFactory(() => AppStateProvider(sl()));
    sl.registerFactory(() => ItemSearchProvider(sl()));
    sl.registerFactory(() => SupplierSearchProvider(sl()));

    // Register AppDataSource
    sl.registerLazySingleton(() => AppDataSource());

  }
}