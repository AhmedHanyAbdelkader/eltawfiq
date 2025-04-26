import 'package:eltawfiq_suppliers/authentication/domain/entities/search_result_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/data/models/item_model.dart';
import 'package:eltawfiq_suppliers/suppliers/data/models/section_model.dart';
import 'package:eltawfiq_suppliers/suppliers/data/models/supplier_invoice_model.dart';
import 'package:eltawfiq_suppliers/suppliers/data/models/supplier_model.dart';



class SearchResultModel extends SearchResultsEntity {
  SearchResultModel({
    super.suppliers,
    super.items,
    super.invoices,
    super.sections,
  });

  factory SearchResultModel.fromJson(Map<String, dynamic> json) {
    // Debug print JSON data to verify its content
    print("JSON Suppliers: ${json['suppliers']}");
    print("JSON Items: ${json['items']}");
    print("JSON Invoices: ${json['invoices']}");
    print("JSON Sections: ${json['sections']}");

    return SearchResultModel(
      suppliers: List.from(json['suppliers'].map((supplier) => SupplierModel.fromJson(supplier))),
      items: List.from(json['items'].map((item) => ItemModel.fromJson(item))),
      invoices: List.from(json['invoices'].map((invoice) => SupplierInvoiceModel.fromJson(invoice))),
      sections: List.from(json['sections'].map((section) => SectionModel.fromJson(section)))
    );
  }
}


