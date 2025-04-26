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
import 'package:eltawfiq_suppliers/authentication/presentation/screens/signin_screen.dart';
import 'package:eltawfiq_suppliers/authentication/presentation/screens/splash_screen.dart';
import 'package:eltawfiq_suppliers/controller/app_state_provider.dart';
import 'package:eltawfiq_suppliers/controller/search_state_provider.dart';
import 'package:eltawfiq_suppliers/core/resources/string_manager.dart';
import 'package:eltawfiq_suppliers/core/router/app_router.dart';
import 'package:eltawfiq_suppliers/core/services/service_locator.dart';
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
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //ChangeNotifierProvider(create: (context) => sl<AuthController>()),
        ChangeNotifierProvider(create: (context) => sl<UsersController>()),
        ChangeNotifierProvider(create: (context) => sl<AddNewUserController>()),
        ChangeNotifierProvider(create: (context) => sl<EditUserController>()),
        ChangeNotifierProvider(create: (context) => sl<DeleteUserController>()),
        ChangeNotifierProvider(create: (context) => sl<LoginUserController>()),

        ChangeNotifierProvider(create: (context) => sl<RolesController>()),
        ChangeNotifierProvider(create: (context) => sl<AddNewRoleController>()),
        ChangeNotifierProvider(create: (context) => sl<EditRoleController>()),
        ChangeNotifierProvider(create: (context) => sl<DeleteRoleController>()),

        ChangeNotifierProvider(create: (context) => sl<ClientsController>()),
        ChangeNotifierProvider(create: (context) => sl<GetClientController>()),

        ChangeNotifierProvider(create: (context) => sl<SupplierController>()),
        ChangeNotifierProvider(create: (context) => sl<GetSupplierController>()),
        ChangeNotifierProvider(create: (context) => sl<AddNewSupplierController>()),
        ChangeNotifierProvider(create: (context) => sl<EditSupplierController>()),
        ChangeNotifierProvider(create: (context) => sl<DeleteSupplierController>()),
        ChangeNotifierProvider(create: (context) => sl<GetSupplierPaymentsPaymentsController>()),
        ChangeNotifierProvider(create: (context) => sl<GetSupplierInvoicesController>()),
        ChangeNotifierProvider(create: (context) => sl<GetSupplierItemsController>()),
        ChangeNotifierProvider(create: (context) => sl<AddNewSupplierPaymentController>()),

        ChangeNotifierProvider(create: (context) => sl<CompaniesController>()),
        ChangeNotifierProvider(create: (context) => sl<AddNewCompanyController>()),
        ChangeNotifierProvider(create: (context) => sl<EditCompanyController>()),
        ChangeNotifierProvider(create: (context) => sl<DeleteCompanyController>()),
        ChangeNotifierProvider(create: (context) => sl<CompanySupplierController>()),


        ChangeNotifierProvider(create: (context) => sl<GroupsController>()),
        ChangeNotifierProvider(create: (context) => sl<AddNewGroupController>()),
        ChangeNotifierProvider(create: (context) => sl<EditGroupController>()),
        ChangeNotifierProvider(create: (context) => sl<DeleteGroupController>()),

        ChangeNotifierProvider(create: (context) => sl<SectionsController>()),
        ChangeNotifierProvider(create: (context) => sl<AddNewSectionController>()),
        ChangeNotifierProvider(create: (context) => sl<EditSecttionController>()),
        ChangeNotifierProvider(create: (context) => sl<DeleteSectionController>()),
        ChangeNotifierProvider(create: (context) => sl<SectionSupplierController>()),

         ChangeNotifierProvider(create: (context) => sl<AppStateProvider>()..getSections()),
         ChangeNotifierProvider(create: (context) => sl<SupplierSearchProvider>()),
         ChangeNotifierProvider(create: (context) => sl<ItemSearchProvider>()),

         ChangeNotifierProvider(create: (context) => sl<InvoiceController>()),
         ChangeNotifierProvider(create: (context) => sl<InvoiceByIdController>()),
         ChangeNotifierProvider(create: (context) => sl<AddNewSupplierInvoiceController>()),

         ChangeNotifierProvider(create: (context) => sl<ItemsController>()),
         ChangeNotifierProvider(create: (context) => sl<AddNewItemController>()),
         ChangeNotifierProvider(create: (context) => sl<DeleteItemController>()),
         ChangeNotifierProvider(create: (context) => sl<EditItemController>()),
         ChangeNotifierProvider(create: (context) => sl<ItemOperationsController>()),
         ChangeNotifierProvider(create: (context) => sl<ItemDetailsController>()),

         ChangeNotifierProvider(create: (context) => sl<SsearchController>()),
         ChangeNotifierProvider(create: (context) => sl<HotItemsController>()),
         ChangeNotifierProvider(create: (context) => sl<ItemHistoryController>()),
      ],
      child: MaterialApp(
        title: StringManager.appTitle,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splashScreenRoute,
        navigatorKey: RouteGenerator.navigatorKey,
        onGenerateRoute: RouteGenerator.getRoute,
        home: const SplashScreen(),
        // home: const SigninScreen(),
        themeMode: ThemeMode.light,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
          ),
          useMaterial3: true,
        ),
      ),
    );
  }
}