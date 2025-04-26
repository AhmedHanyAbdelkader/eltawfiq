import 'package:eltawfiq_suppliers/suppliers/domain/entities/item_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/section_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/supplier_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/supplier_invoice_entity.dart';
import 'package:equatable/equatable.dart';

class SearchResultsEntity {
  final List<ItemEntity>? items;
  final List<SupplierEntity>? suppliers;
  final List<SectionEntity>? sections;
  final List<SupplierInvoiceEntity>? invoices;

  SearchResultsEntity({
     this.items,
     this.suppliers,
     this.sections,
     this.invoices,
  });
}