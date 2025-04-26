
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/item/get_item_history_use_case.dart';

class ApiConstance{

 static const String baseUrl = "http://192.168.1.7";
 static const String baseApiUrl = "http://tawfiq.runasp.net/api";

  static String getImage(String imagePath) => "$baseUrl/storage/$imagePath";

 static String getSuppliersEndPoint(int id) => "$baseUrl/auth/getAllSuppliers?id=$id";
 static String addNewSupplierEndPoint = "$baseUrl/auth/createSupplier";


 static const String usersEndPoint = "$baseApiUrl/Users";
 static const String loginUserEndPoint = "$baseApiUrl/Auth/login";
 static String editUserEndPoint(int id) => "$baseApiUrl/Users/$id";
 static String deleteUserEndPoint(int id) => "$baseApiUrl/Users/$id";

 static const String rolesEndPoint = "$baseApiUrl/roles";
 static String editRoleEndPoint(int id) => "$baseApiUrl/Roles/$id";
 static String deleteRoleEndPoint(int id) => "$baseApiUrl/Roles/$id";

 static String clientsEndPoint = "$baseApiUrl/clients";
 static String clientEndPoint(int clientId) => "$baseApiUrl/clients/$clientId";
 static String suppliersEndPoint = "$baseApiUrl/suppliers";
 static String supplierEndPoint(int supplierId) => "$baseApiUrl/suppliers/$supplierId";
 static String deleteSupplierEndPoint(int id) => "$baseApiUrl/suppliers/$id";
 static String editSupplierEndPoint(int id) => "$baseApiUrl/suppliers/$id";
 static String addSupplierPaymentEndPoint = "$baseApiUrl/supplierpayments";
 static String supplierPayments(int id) => "$baseApiUrl/supplierpayments/suppay/$id";
 static String supplierInvoices(int id) => "$baseApiUrl/Invoices/supinv/$id";
 static String supplierItems(int id) => "$baseApiUrl/items/supitem/$id";

 static String companiesEndPoint = "$baseApiUrl/companies";
 static String companySuppliersEndPoint(int companyId) => "$baseApiUrl/Suppliers/compsups/$companyId";
 static String deleteCompanyEndPoint(int id) => "$baseApiUrl/companies/$id";
 static String editCompanyEndPoint(int id) => "$baseApiUrl/companies/$id";

 static String groupsEndPoint = "$baseApiUrl/groups";
 static String deleteGroupEndPoint(int id) => "$baseApiUrl/groups/$id";
 static String editGroupEndPoint(int id) => "$baseApiUrl/groups/$id";

 static String sectionsEndPoint = "$baseApiUrl/sections";
 static String sectionSuppliersEndPoint(int sectionId) => "$baseApiUrl/Suppliers/secsups/$sectionId";
 static String deleteSectionsEndPoint(int id) => "$baseApiUrl/sections/$id";
 static String editSectionsEndPoint(int id) => "$baseApiUrl/sections/$id";

 static String invoicesEndPoint = "$baseApiUrl/invoices";
 static String invoiceByIdEndPoint(int invId) => "$baseApiUrl/invoices/$invId";
 static String deleteInvoicesEndPoint(int id) => "$baseApiUrl/invoices/$id";
 static String editInvoicesEndPoint(int id) => "$baseApiUrl/invoices/$id";

 static String itemsEndPoint = "$baseApiUrl/items";
 static String hotItemsEndPoint(int supplierId) => "$baseApiUrl/Items/suphotitem/$supplierId";
 static String itemHistoryEndPoint(GetItemHistoryParameters getItemHistoryParameters) => "$baseApiUrl/Items/supitemhistory/${getItemHistoryParameters.itemId}/${getItemHistoryParameters.supplierId}";
 static String itemDetailsEndPoint(int itemId) => "$baseApiUrl/items/$itemId";
 static String deleteItemEndPoint(int id) => "$baseApiUrl/items/$id";
 static String editItemEndPoint(int id) => "$baseApiUrl/items/$id";
 static String itemOperationsEndPoint(int id) => "$baseApiUrl/items/itemoperation/$id";
 static String searchEndPoint(String query) => "$baseApiUrl/Auth/search?query=$query";

}