import 'package:eltawfiq_suppliers/authentication/data/data_source/local_data_source/shred_prefs_helper.dart';
import 'package:eltawfiq_suppliers/core/resources/size_manager.dart';
import 'package:eltawfiq_suppliers/core/resources/string_manager.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/item_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/section_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/supplier_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/item/edit_item_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/item/delete_item_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/item/edit_item_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/item/hot_items_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/item/items_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/section/sections_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/supplier/get_supplier_items_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/supplier/suppliers_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/widgets/add_new_item_dialog.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/widgets/items_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SupplierItemsScreen extends StatefulWidget {
  const SupplierItemsScreen({super.key, this.supplier});
  final SupplierEntity? supplier;
  @override
  State<SupplierItemsScreen> createState() => _SupplierItemsScreenState();
}

class _SupplierItemsScreenState extends State<SupplierItemsScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(widget.supplier!.isSup == true)
      Provider.of<GetSupplierItemsController>(context, listen: false).getSupplierItems(widget.supplier!.id!);
      if(widget.supplier!.isSup == false)
        Provider.of<HotItemsController>(context, listen: false).getHotItems(widget.supplier!.id!);

      //Provider.of<SupplierController>(context, listen: false).getSuppliers(const NoParameters());
      //Provider.of<SectionsController>(context, listen: false).getSections(const NoParameters());
    });
  }


  @override
  void initState() {
    super.initState();
    getUserRole();
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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(StringManager.supplierItems),
          automaticallyImplyLeading: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            showDialog(
              context: context,
              builder: (context) => const AddItemDialog(),
            );
          },
          child: const Icon(Icons.add),
        ),
        body:
        widget.supplier?.isSup ==true ?
        Consumer<GetSupplierItemsController>(
          builder: (context, itemsController, _) {
            if (itemsController.getSupplierItemsIsLoading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            else if (itemsController.getSupplierItemsErrorMessage.isNotEmpty) {
              return Center(
                child: Text(itemsController.getSupplierItemsErrorMessage),
              );
            }
            else if (itemsController.gettingSupplierItems == null || itemsController.gettingSupplierItems!.isEmpty) {
              return const Center(
                child: Text('No Items available'),
              );
            }
            else {
              return ListView.separated(
                itemBuilder: (context, index) {
                  final item = itemsController.gettingSupplierItems![index];
                  return ItemsListTile(item: item, role: role!);
                  //   ListTile(
                  //   title: Text(item.name?? ''),
                  //   leading: Text(item.id.toString()),
                  //   onTap: (){
                  //     //RouteGenerator.navigationTo(AppRoutes.storesItemsBalancesScreenRoute, arguments: store);
                  //   },
                  //   onLongPress: () async {
                  //     showDialog(
                  //       context: context,
                  //       builder: (context) {
                  //         return AlertDialog(
                  //           title: const Text('حذف الصنف'),
                  //           content: Text('${item.toString()}هل تريد حذف الصنف : '),
                  //           actions: [
                  //             TextButton(
                  //               onPressed: () => Navigator.of(context).pop(),
                  //               child: const Text('Cancel'),
                  //             ),
                  //             ElevatedButton(
                  //               onPressed: ()async{
                  //                 final deleteItemController = Provider.of<DeleteItemController>(context, listen: false);
                  //                 await deleteItemController.deleteItem(item.id!);
                  //                 Provider.of<GetSupplierItemsController>(context, listen: false).getSupplierItems(widget.supplier!.id!);
                  //                 if (deleteItemController.deleteItemResult != null) {
                  //                   Navigator.of(context).pop();
                  //                   ScaffoldMessenger.of(context).showSnackBar(
                  //                     SnackBar(
                  //                       content: Text(
                  //                         '${deleteItemController.deleteItemErrorMessage}deleted successfully',
                  //                       ),
                  //                     ),
                  //                   );
                  //                 } else {
                  //                   ScaffoldMessenger.of(context).showSnackBar(
                  //                     SnackBar(
                  //                         content: Text(deleteItemController.deleteItemErrorMessage)),
                  //                   );
                  //                 }
                  //               },
                  //               child: Consumer<DeleteItemController>(
                  //                   builder: (context, deleteItemController, _){
                  //                     if(deleteItemController.deleteItemIsLoading){
                  //                       return const CircularProgressIndicator.adaptive();
                  //                     }else{
                  //                       return const Text('حذف');
                  //                     }
                  //                   },
                  //               ),
                  //             ),
                  //           ],
                  //         );
                  //       },
                  //     );
                  //   },
                  //   trailing: IconButton(
                  //     icon: const Icon(Icons.edit),
                  //     onPressed: (){
                  //       showDialog(
                  //         context: context,
                  //         builder: (context) => EditItemDialog(item: item),
                  //       );
                  //     },
                  //   ),
                  // );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: itemsController.gettingSupplierItems!.length,
              );
            }
          },
        )
            : Consumer<HotItemsController>(
          builder: (context, itemsController, _) {
            if (itemsController.getItemsIsLoading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            else if (itemsController.getItemsErrorMessage.isNotEmpty) {
              return Center(
                child: Text(itemsController.getItemsErrorMessage),
              );
            }
            else if (itemsController.gettingItems == null || itemsController.gettingItems!.isEmpty) {
              return const Center(
                child: Text('No Items available'),
              );
            }
            else {
              return ListView.separated(
                itemBuilder: (context, index) {
                  final item = itemsController.gettingItems![index];
                  return ItemsListTile(item: item, role: role!);
                  //   ListTile(
                  //   title: Text(item.name?? ''),
                  //   leading: Text(item.id.toString()),
                  //   onTap: (){
                  //     //RouteGenerator.navigationTo(AppRoutes.storesItemsBalancesScreenRoute, arguments: store);
                  //   },
                  //   onLongPress: () async {
                  //     showDialog(
                  //       context: context,
                  //       builder: (context) {
                  //         return AlertDialog(
                  //           title: const Text('حذف الصنف'),
                  //           content: Text('${item.toString()}هل تريد حذف الصنف : '),
                  //           actions: [
                  //             TextButton(
                  //               onPressed: () => Navigator.of(context).pop(),
                  //               child: const Text('Cancel'),
                  //             ),
                  //             ElevatedButton(
                  //               onPressed: ()async{
                  //                 final deleteItemController = Provider.of<DeleteItemController>(context, listen: false);
                  //                 await deleteItemController.deleteItem(item.id!);
                  //                 Provider.of<GetSupplierItemsController>(context, listen: false).getSupplierItems(widget.supplier!.id!);
                  //                 if (deleteItemController.deleteItemResult != null) {
                  //                   Navigator.of(context).pop();
                  //                   ScaffoldMessenger.of(context).showSnackBar(
                  //                     SnackBar(
                  //                       content: Text(
                  //                         '${deleteItemController.deleteItemErrorMessage}deleted successfully',
                  //                       ),
                  //                     ),
                  //                   );
                  //                 } else {
                  //                   ScaffoldMessenger.of(context).showSnackBar(
                  //                     SnackBar(
                  //                         content: Text(deleteItemController.deleteItemErrorMessage)),
                  //                   );
                  //                 }
                  //               },
                  //               child: Consumer<DeleteItemController>(
                  //                 builder: (context, deleteItemController, _){
                  //                   if(deleteItemController.deleteItemIsLoading){
                  //                     return const CircularProgressIndicator.adaptive();
                  //                   }else{
                  //                     return const Text('حذف');
                  //                   }
                  //                 },
                  //               ),
                  //             ),
                  //           ],
                  //         );
                  //       },
                  //     );
                  //   },
                  //   trailing: IconButton(
                  //     icon: const Icon(Icons.edit),
                  //     onPressed: (){
                  //       showDialog(
                  //         context: context,
                  //         builder: (context) => EditItemDialog(item: item),
                  //       );
                  //     },
                  //   ),
                  // );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: itemsController.gettingItems!.length,
              );
            }
          },
        ) ,
      ),
    );
  }
}

class EditItemDialog extends StatelessWidget{
  const EditItemDialog({super.key, required this.item});
  final ItemEntity item;
  @override
  Widget build(BuildContext context) {
    final TextEditingController itemNameController = TextEditingController(text:  item.name);
    final TextEditingController itemImageUrlController = TextEditingController(text:  item.itemImageUrl);
    final TextEditingController itemSupplierIdController = TextEditingController(text:  item.itemSupplierId.toString());
    final TextEditingController itemSupplierNameController = TextEditingController();
    final TextEditingController itemSectionIdController = TextEditingController(text:  item.sectionId.toString());
    final TextEditingController itemSectionNameController = TextEditingController(text: item.section?.sectionName.toString());
    final TextEditingController itemSellingPriceController = TextEditingController(text:  item.sellingPrice.toString());
    final TextEditingController itemPurchasingPriceController = TextEditingController(text:  item.purchasingPrice.toString());
    final TextEditingController itemBarCodeController = TextEditingController(text:  item.barcode.toString());
    final TextEditingController itemCodeController = TextEditingController(text: item.itemCode);
    final formKey = GlobalKey<FormState>();
    return AlertDialog(
      title: const Text('Edit Item'),
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: itemNameController,
                decoration: const InputDecoration(labelText: 'Item Name'),
                validator: (value) => value!.isEmpty ? 'Please enter item name' : null,
              ),
              TextFormField(
                controller: itemCodeController,
                decoration: const InputDecoration(labelText: 'Item code'),
                //validator: (value) => value!.isEmpty ? 'Please enter item code' : null,
              ),
              TextFormField(
                controller: itemPurchasingPriceController,
                decoration: const InputDecoration(labelText: 'Item purchasing price'),
                //validator: (value) => value!.isEmpty ? 'Please enter Item purchasing price' : null,
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: itemSellingPriceController,
                decoration: const InputDecoration(labelText: 'Item selling price'),
                //validator: (value) => value!.isEmpty ? 'Please enter Item selling price' : null,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: SizeManager.s_8,),
              SizedBox(
                height: 40,
                child: TypeAheadField<SupplierEntity>(
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: itemSupplierNameController,
                    decoration: InputDecoration(
                        labelText: 'اسم المورد',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)
                        )
                    ),
                    onEditingComplete: () {},
                  ),

                  suggestionsCallback: (pattern) {
                    final supplierController = Provider.of<SupplierController>(context, listen: false);
                    return supplierController.getSuggestions(pattern);
                  },
                  itemBuilder: (context, SupplierEntity suggestion) {
                    return ListTile(
                      title: Text(suggestion.supplierName ?? ''),
                    );
                  },
                  onSuggestionSelected: (SupplierEntity suggestion) {
                    itemSupplierNameController.text = suggestion.supplierName ?? '';
                    itemSupplierIdController.text = suggestion.id.toString();
                  },


                ),
              ),
              const SizedBox(height: SizeManager.s_8,),
              SizedBox(
                height: 40,
                child: TypeAheadField<SectionEntity>(
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: itemSectionNameController,
                    decoration: InputDecoration(
                        labelText: 'التصنيف',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)
                        )
                    ),
                    onEditingComplete: () {},
                  ),

                  suggestionsCallback: (pattern) {
                    final sectionController = Provider.of<SectionsController>(context, listen: false);
                    return sectionController.getSuggestions(pattern);
                  },
                  itemBuilder: (context, SectionEntity suggestion) {
                    return ListTile(
                      title: Text(suggestion.sectionName ?? ''),
                    );
                  },
                  onSuggestionSelected: (SectionEntity suggestion) {
                    itemSectionNameController.text = suggestion.sectionName ?? '';
                    itemSectionIdController.text = suggestion.id.toString();
                  },


                ),
              ),

            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              final editItemController = Provider.of<EditItemController>(context, listen: false);
              await editItemController.editItems(
                EditItemParameters(
                  id: item.id,
                  itemName: itemNameController.text,
                  itemImageUrl: itemImageUrlController.text,
                  itemSupplierId: int.tryParse(itemSupplierIdController.text),
                  purchasingPrice: double.tryParse(itemPurchasingPriceController.text),
                  sellingPrice: double.tryParse(itemSellingPriceController.text),
                  sectionId: int.tryParse(itemSectionIdController.text),
                  barcode: itemBarCodeController.text,
                  itemCode: itemCodeController.text,
                ),
              );
              Provider.of<ItemsController>(context, listen: false).getItems(const NoParameters());
              if (editItemController.editItemResult != null) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${editItemController.editItemErrorMessage}edited successfully',
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(editItemController.editItemErrorMessage)),
                );
              }
            }
          },
          child: const Text('Edit'),
        ),
      ],
    );
  }
}



