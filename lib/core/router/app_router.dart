import 'package:eltawfiq_suppliers/authentication/presentation/screens/app_home_screen.dart';
import 'package:eltawfiq_suppliers/authentication/presentation/screens/roles_screen.dart';
import 'package:eltawfiq_suppliers/authentication/presentation/screens/search_screen.dart';
import 'package:eltawfiq_suppliers/authentication/presentation/screens/sign_up_screen.dart';
import 'package:eltawfiq_suppliers/authentication/presentation/screens/signin_screen.dart';
import 'package:eltawfiq_suppliers/authentication/presentation/screens/splash_screen.dart';
import 'package:eltawfiq_suppliers/authentication/presentation/screens/users_screen.dart';
import 'package:eltawfiq_suppliers/model/supplier_model.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/company_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/item_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/section_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/supplier_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/screens/clients/add_client_from_contacts.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/screens/clients/add_new_client_invoice.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/screens/clients/add_new_client_screen.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/screens/clients/add_new_returned_client_invoice.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/screens/clients/client_screen.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/screens/clients/clients_contacts_screen.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/screens/clients/clients_screen.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/screens/company/companies_screen.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/screens/groups_screen.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/screens/supplier/add_new_returned_supplier_invoice.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/screens/supplier/add_new_supplier_invoice.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/screens/item/item_details_screen.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/screens/item/item_operations_screen.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/screens/supplier/add_new_supplier_screen.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/screens/company/company_suppliers_screen.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/screens/item/items_screen.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/screens/section/section_suppliers_screen.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/screens/section/sections_screen.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/screens/supplier/supplier_invoices_screen.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/screens/supplier/supplier_items_screen.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/screens/supplier/supplier_payments_screen.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/screens/supplier/supplier_screen.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/screens/supplier/supplier_invoice_details_screen.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/screens/supplier/suppliers_home_layout.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/screens/supplier/suppliers_invoices_screen.dart';
import 'package:eltawfiq_suppliers/view/add_new_company_screen.dart';
import 'package:eltawfiq_suppliers/view/add_new_invoice_screen.dart';
import 'package:eltawfiq_suppliers/view/add_new_item_screen.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/screens/supplier/add_supplier_from_contacts.dart';
import 'package:eltawfiq_suppliers/view/components/edit_supplier_screnn.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/screens/supplier/contacts_screen.dart';
import 'package:eltawfiq_suppliers/view/item_details_screen.dart';
import 'package:eltawfiq_suppliers/view/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class AppRoutes {
  static const String splashScreenRoute = '/';

  static const String signupScreenRoute = '/signupScreen';
  static const String signinScreenRoute = '/loginScreen';
  static const String usersScreenRoute = '/usersScreen';

  static const String rolesScreenRoute = '/rolesScreen';
  static const String homeScreenRoute = '/homeScreen';
  static const String searchScreenRoute = '/searchScreen';
  static const String addNewItemScreenRoute = '/addNewItemScreen';
  static const String itemDetailsScreenRoute = '/itemDetailsScreen';
  static const String suppliersInvoicesScreenRoute = '/suppliersInvoicesScreen';
  static const String addNewClientInvoiceScreenRoute = '/addNewClientInvoiceScreen';
  static const String addNewReturnedClientInvoiceScreenRoute = '/addNewReturnedClientInvoiceScreen';
  static const String addNewSupplierInvoiceScreenRoute = '/addNewSupplierInvoiceScreen';
  static const String addNewReturnedSupplierInvoiceScreenRoute = '/addNewReturnedSupplierInvoiceScreen';
  static const String clientsScreenRoute = '/clientsScreen';
  static const String clientScreenRoute = '/clientScreen';
  static const String suppliersScreenRoute = '/suppliersScreen';
  static const String itemsScreenRoute = '/itemsScreen';
  static const String supplierScreenRoute = '/supplierScreen';
  static const String contactsScreenRoute = '/contactsScreen';
  static const String clientsContactsScreenRoute = '/clientsContactsScreen';
  static const String addSupplierFromContctsRoute = '/addSupplierFromContctsScreen';
  static const String addClientFromContctsRoute = '/addClientFromContctsScreen';
  static const String supplierItemsScreenRoute = '/supplierItemsScreen';
  static const String supplierInvoicesScreenRoute = '/supplierInvoicesScreen';
  static const String supplierInvoiceDetailsScreenRoute = '/supplierInvoiceDetailsScreen';
  static const String addNewSupplierScreenRoute = '/addNewSupplierScreen';
  static const String addNewClientScreenRoute = '/addNewClientScreen';
  static const String editSupplierScreenRoute = '/editSupplierScreen';
  static const String addNewInvoiceScreenRoute = '/addNewInvoiceScreen';
  static const String sectionItemsScreenRoute = '/sectionItemsScreenRoute';
  static const String addNewCompanyScreenRoute = '/addNewCompanyScreenRoute';
  static const String companySuppliersScreen = '/companySuppliersScreenRoute';
  static const String sectionSuppliersScreen = '/sectionSuppliersScreenRoute';
  static const String supplierScreenScreen = '/supplierScreenRoute';
  static const String supplierPaymentsScreen = '/supplierPaymentsScreenRoute';
  static const String supplierInvoicesScreen = '/supplierInvoicesScreenRoute';
  static const String supplierItemsScreen = '/supplierItemsScreenRoute';
  static const String itemOperationsScreen = '/itemOperationsScreenRoute';
  static const String searchScreen = '/searchScreenRoute';
  static const String companiesScreen = '/companiesScreenRoute';
  static const String groupsScreen = '/groupsScreenRoute';

}


class RouteGenerator{

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static void navigationTo(String routeName, {dynamic arguments}){
    navigatorKey.currentState?.pushNamed(routeName,arguments: arguments );
  }

  static void navigationReplacementTo(String routeName, {dynamic arguments}){
    navigatorKey.currentState?.pushReplacementNamed(routeName, arguments: arguments);
  }

  static Route<dynamic>? getRoute(RouteSettings settings){
    final args = settings.arguments;
    switch(settings.name){

      case AppRoutes.splashScreenRoute:
        return MaterialPageRoute(
            builder: (_) => const Directionality(
                textDirection: TextDirection.rtl,
                child: SplashScreen(),
            ),
        );

      case AppRoutes.rolesScreenRoute:
        return MaterialPageRoute(builder: (_) => const Directionality(
            textDirection: TextDirection.rtl,
            child: RolesScreen()));

      case AppRoutes.companiesScreen:
        return MaterialPageRoute(builder: (_) =>const Directionality(
          textDirection: TextDirection.rtl,
            child: CompaniesScreen()));

      case AppRoutes.groupsScreen:
        return MaterialPageRoute(builder: (_) => const Directionality(
            textDirection: TextDirection.rtl,
            child: GroupsScreen(),
        ),
        );

      case AppRoutes.signinScreenRoute:
        return MaterialPageRoute(builder: (_) => const SigninScreen());

      case AppRoutes.signupScreenRoute:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());

      case AppRoutes.homeScreenRoute:
        return MaterialPageRoute(builder: (_) => const Directionality(
            textDirection: TextDirection.rtl,
            child: AppHomeScreen(),
        ));


      case AppRoutes.usersScreenRoute:
        return MaterialPageRoute(builder: (_) => const Directionality(
          textDirection: TextDirection.rtl,
          child: UsersScreen(),
        ));


      //
      // case AppRoutes.searchScreenRoute:
      //   return MaterialPageRoute(builder: (_) => const Directionality(
      //     textDirection: TextDirection.rtl,
      //       child: SearchScreen()));




      case AppRoutes.sectionItemsScreenRoute:
        return MaterialPageRoute(builder: (_) => const Directionality(
          textDirection: TextDirection.rtl,
          child: SectionsScreen(),
        ),
        );


      case AppRoutes.addNewItemScreenRoute:
        return MaterialPageRoute(builder: (_) => const Directionality(
            textDirection: TextDirection.rtl,
            child: AddNewItemScreen(),
        ),
        );



      case AppRoutes.itemDetailsScreenRoute:
        if(args is ItemEntity){
          return MaterialPageRoute(builder: (_) => Directionality(
            textDirection: TextDirection.rtl,
            child: ItemDetailsScreen(item: args),
          ),
          );
        }

      case AppRoutes.companySuppliersScreen:
        if(args is CompanyEntity){
          return MaterialPageRoute(builder: (_) => Directionality(
            textDirection: TextDirection.rtl,
              child: CompanySuppliersScreen(company: args,),
          ),
          );
        }

      case AppRoutes.sectionSuppliersScreen:
        if(args is SectionEntity){
          return MaterialPageRoute(builder: (_) => Directionality(
              textDirection: TextDirection.rtl,
              child: SectionSuppliersScreen(section: args),
          ),
          );
        }


      // case AppRoutes.supplierInvoicesScreenRoute:
      //   return MaterialPageRoute(builder: (_) => const Directionality(
      //     textDirection: TextDirection.rtl,
      //     child: SupplierInvoicesScreen(),
      //   ),
      //   );

      case AppRoutes.addNewClientInvoiceScreenRoute:
        return MaterialPageRoute(builder: (_) => Directionality(
          textDirection: TextDirection.rtl,
          child: AddNewClientInvoiceScreen(),
        ),
        );

      case AppRoutes.addNewReturnedClientInvoiceScreenRoute:
        return MaterialPageRoute(builder: (_) => Directionality(
            textDirection: TextDirection.rtl,
            child: AddNewReturndeClientInvoiceScreen(),
        ),
        );

        case AppRoutes.addNewSupplierInvoiceScreenRoute:
        return MaterialPageRoute(builder: (_) => const Directionality(
          textDirection: TextDirection.rtl,
          child: AddNewSupplierInvoiceScreen(),
        ),
        );

      case AppRoutes.addNewReturnedSupplierInvoiceScreenRoute:
        return MaterialPageRoute(builder: (_) => const Directionality(
            textDirection: TextDirection.rtl,
            child: AddNewReturnedSupplierInvoiceScreen(),
        ),
        );

      case AppRoutes.supplierInvoiceDetailsScreenRoute:
        if(args is int){
          return MaterialPageRoute(builder: (_) => Directionality(
            textDirection: TextDirection.rtl,
            child: InvoiceDetailsScreen(invId: args),
          ),
          );
        }

      case AppRoutes.clientsScreenRoute:
        return MaterialPageRoute(builder: (_) => const Directionality(
            textDirection: TextDirection.rtl,
            child: ClientsScreen(),
        ),
        );

      case AppRoutes.clientScreenRoute:
        if(args is SupplierEntity){
          return MaterialPageRoute(builder: (_) => Directionality(
            textDirection: TextDirection.rtl,
            child: ClientScreen(supplier: args,),
          ),
          );
        }

      case AppRoutes.suppliersScreenRoute:
        return MaterialPageRoute(builder: (_)=> const Directionality(
            textDirection: TextDirection.rtl,
            child: SuppliersHomeLayout(),
            //child: SuppliersScreen(),
        ),
        );

      case AppRoutes.supplierPaymentsScreen:
        if(args is SupplierEntity){
          return MaterialPageRoute(builder: (_) => Directionality(
              textDirection: TextDirection.rtl,
              child: SupplierPaymentsScreen(supplier: args),
          ),
          );
        }

        case AppRoutes.supplierInvoicesScreen:
        if(args is SupplierEntity){
          return MaterialPageRoute(builder: (_) => Directionality(
              textDirection: TextDirection.rtl,
              child: SupplierInvoicesScreen(supplier: args),
          ),
          );
        }

      case AppRoutes.supplierItemsScreen:
        if(args is SupplierEntity) {
          return MaterialPageRoute(builder: (_) =>
           Directionality(
              textDirection: TextDirection.rtl,
              child: SupplierItemsScreen(supplier: args,)
          ),
          );
        }

      case AppRoutes.itemOperationsScreen:
        if(args is ItemEntity){
          return MaterialPageRoute(builder: (_) =>
              Directionality(
                textDirection: TextDirection.rtl,
                child: ItemOperationsScreen(itemEntity: args),
              ),
          );
        }

      case AppRoutes.searchScreen:
        return MaterialPageRoute(builder: (_) =>
         Directionality(
            textDirection: TextDirection.rtl,
            child: SearchScreen(),
        ),
        );

      // case AppRoutes.supplierScreenScreen:
      //   if(args is SupplierEntity){
      //     return MaterialPageRoute(
      //         builder: (_) => Directionality(
      //             textDirection: TextDirection.rtl,
      //             child: SupplierScreen(),
      //         ),
      //     );
      //   }

      case AppRoutes.itemsScreenRoute:
        return MaterialPageRoute(builder: (_)=> const Directionality(
            textDirection: TextDirection.rtl,
            child: ItemsScreen(),
        ),
        );

      case AppRoutes.supplierScreenRoute:
        if(args is SupplierEntity){
          return MaterialPageRoute(builder: (_)=> Directionality(
            textDirection: TextDirection.rtl,
            child: SupplierScreen(supplier: args),
          ),
          );
        }

      case AppRoutes.suppliersInvoicesScreenRoute:
        return MaterialPageRoute(builder: (_) => const Directionality(
            textDirection: TextDirection.rtl,
            child: SuppliersInvoices(),
        ),
        );





      case AppRoutes.clientsContactsScreenRoute :
        return MaterialPageRoute(builder: (_) => const Directionality(
            textDirection: TextDirection.rtl,
            child: ClientsContactsScreen(),
          ),
          );


        case AppRoutes.contactsScreenRoute :
        return MaterialPageRoute(builder: (_) => const Directionality(
            textDirection: TextDirection.rtl,
            child: ContactsScreen(),
          ),
          );


      case AppRoutes.addClientFromContctsRoute:
        if(args is Contact){
          return MaterialPageRoute(builder: (_) => Directionality(
              textDirection: TextDirection.rtl,
              child: AddClientFromContcts(contact: args,),
          ),
          );
        }

      case AppRoutes.addSupplierFromContctsRoute :
        if(args is Contact){
          return MaterialPageRoute(builder: (_) => Directionality(
              textDirection: TextDirection.rtl,
              child: AddSupplierFromContcts(contact: args),
          ),
          );
        }


      case AppRoutes.supplierItemsScreenRoute :
        return MaterialPageRoute(builder: (_) => const Directionality(
            textDirection: TextDirection.rtl,
            child: SupplierItemsScreen(),
        ),
        );

      case AppRoutes.addNewClientScreenRoute:
        return MaterialPageRoute(builder: (_) => const Directionality(
            textDirection: TextDirection.rtl,
            child: AddNewClientScreen(),
        ),
        );

      case AppRoutes.addNewSupplierScreenRoute :
        return MaterialPageRoute(builder: (_) => const Directionality(
            textDirection: TextDirection.rtl,
            child: AddNewSupplierScreen(),
        )
        );

      case AppRoutes.addNewInvoiceScreenRoute :
        return MaterialPageRoute(builder: (_) => const Directionality(
            textDirection: TextDirection.rtl,
            child: AddNewInvoiceScreen(),
        ),
        );


      case AppRoutes.addNewCompanyScreenRoute:
        return MaterialPageRoute(
            builder: (_)=> const Directionality(
              textDirection: TextDirection.rtl,
                child: AddNewCompanyScreen(),
            ),
        );



      case AppRoutes.editSupplierScreenRoute:
        if(args is SupplierModel){
          return MaterialPageRoute(builder: (_) => EditSupplierScreen(supplier: args,));
        }


      // case AppRoutes.updateGroupScreenRoute :
      //   if(args is Group){
      //     return MaterialPageRoute(builder: (_) =>  EditGroupScreen(group: args));
      //   }

    ///TODO: 111111111111111
      // default :
      //   return MaterialPageRoute(builder: (_) => DefaultScreen());

    }
    return null;
  }
}