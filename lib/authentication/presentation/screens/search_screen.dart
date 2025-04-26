import 'package:eltawfiq_suppliers/authentication/data/data_source/local_data_source/shred_prefs_helper.dart';
import 'package:eltawfiq_suppliers/core/shared_methods/scan_barcode.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/item_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/section_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/supplier_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/supplier_invoice_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/search/search_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/screens/section/sections_screen.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/screens/supplier/suppliers_invoices_screen.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/widgets/items_list_view.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/widgets/suppliers_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Auto-focus the search bar
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocusNode.requestFocus();
    });
    getUserRole();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  late String? role;
  getUserRole()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    SharedPreferencesHelper sharedPreferencesHelper = SharedPreferencesHelper(prefs);
    Map? token = await sharedPreferencesHelper.getToken();
    setState(() {
      role = token?['role'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return role == 'admin'
        ? DefaultTabController(
      length: 4, // Adjust based on your tabs
      child: Consumer<SsearchController>(
        builder: (context, _searchControllerProvider, _) {
          return Scaffold(
            appBar: AppBar(
              title: TextField(
                controller: _searchController,
                focusNode: _searchFocusNode,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  icon: IconButton(
                    icon: const Icon(Icons.document_scanner_outlined),
                    onPressed: () async{
                      final String? barcode = await scanBarcode();
                      _searchController.text = barcode.toString();
                      _searchControllerProvider.search(barcode.toString());
                    },
                  ),
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      _searchControllerProvider.search(_searchController.text);
                    },
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear(); // Clear search input
                      _searchControllerProvider.search('');
                    },
                  ),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  _searchControllerProvider.search(value);
                },
              ),
              bottom: TabBar(
                tabs: _searchControllerProvider.gettingSearchResult != null
                    ? [
                  Tab(text: 'الاصناف(${_searchControllerProvider.gettingSearchResult?.items?.length ?? 0})'),
                  Tab(text: 'اشخاص(${_searchControllerProvider.gettingSearchResult?.suppliers?.length ?? 0})'),
                  Tab(text: 'الفواتير(${_searchControllerProvider.gettingSearchResult?.invoices?.length ?? 0})'),
                  Tab(text: 'الاقسام(${_searchControllerProvider.gettingSearchResult?.sections?.length ?? 0})'),
                ]
                    : [
                  Tab(text: 'Items'),
                  Tab(text: 'persons'),
                  Tab(text: 'Invoices'),
                  Tab(text: 'Sections'),
                ],
              ),
            ),
            body: TabBarView(
              physics: const ScrollPhysics(),
              children: [
                ItemsListView(items: _searchControllerProvider.gettingSearchResult?.items ?? [], role: role!),
                _buildSearchResults(
                    _searchControllerProvider.gettingSearchResult?.suppliers ?? [],
                    'No suppliers found'
                ),
                _buildSearchResults(
                    _searchControllerProvider.gettingSearchResult?.invoices ?? [],
                    'No invoices found'
                ),
                _buildSearchResults(
                    _searchControllerProvider.gettingSearchResult?.sections ?? [],
                    'No sections found'
                ),
              ],
            ),
          );
        },
      ),
    )
        : DefaultTabController(
      length: 1, // Adjust based on your tabs
      child: Consumer<SsearchController>(
        builder: (context, _searchControllerProvider, _) {
          return Scaffold(
            appBar: AppBar(
              title: TextField(
                controller: _searchController,
                focusNode: _searchFocusNode,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  icon: IconButton(
                    icon: const Icon(Icons.document_scanner_outlined),
                    onPressed: () async{
                      final String? barcode = await scanBarcode();
                      _searchController.text = barcode.toString();
                      _searchControllerProvider.search(barcode.toString());
                    },
                  ),
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      _searchControllerProvider.search(_searchController.text);
                    },
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear(); // Clear search input
                      _searchControllerProvider.search('');
                    },
                  ),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  _searchControllerProvider.search(value);
                },
              ),
              bottom: TabBar(
                tabs: _searchControllerProvider.gettingSearchResult != null
                    ? [
                  Tab(text: 'الاصناف(${_searchControllerProvider.gettingSearchResult?.items?.length ?? 0})'),
                ]
                    : [
                  Tab(text: 'Items'),
                ],
              ),
            ),
            body: TabBarView(
              physics: const ScrollPhysics(),
              children: [
                ItemsListView(items: _searchControllerProvider.gettingSearchResult?.items ?? [], role: role!),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchResults(List<dynamic> items, String emptyMessage) {
    if (items.isEmpty) {
      return Center(child: Text(emptyMessage));
    }

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final object = items[index];
        if(object is ItemEntity){
          return ItemsListTile(item: object, role: role!);
        }
        if(object is SupplierEntity){
          return SuppliersListTile(supplier: object);
        }
        if(object is SupplierInvoiceEntity){
          return InvoiceListTile(invoice: object);
        }
        if(object is SectionEntity){
          return SectionListTile(section: object);
        }
        return null;
      },
    );
  }
}