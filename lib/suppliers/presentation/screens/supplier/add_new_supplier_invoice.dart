import 'dart:convert';
import 'dart:io';
import 'package:cached_memory_image/cached_memory_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eltawfiq_suppliers/authentication/data/data_source/local_data_source/shred_prefs_helper.dart';
import 'package:eltawfiq_suppliers/authentication/presentation/controllers/login_user_controller.dart';
import 'package:eltawfiq_suppliers/core/resources/size_manager.dart';
import 'package:eltawfiq_suppliers/core/resources/string_manager.dart';
import 'package:eltawfiq_suppliers/core/router/app_router.dart';
import 'package:eltawfiq_suppliers/core/shared_widgets/full_network_image.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/invoice_item_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/item_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/supplier_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/invoice/add_new_supplier_invoice_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/item/get_item_history_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/invoice/add_new_supplier_invoice_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/item/hot_items_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/item/item_history_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/item/items_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/supplier/suppliers_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/widgets/add_new_item_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_textfield_autocomplete/flutter_textfield_autocomplete.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' as intl;
import 'package:shared_preferences/shared_preferences.dart';

class AddNewSupplierInvoiceScreen extends StatefulWidget {
  const AddNewSupplierInvoiceScreen({super.key});

  @override
  State<AddNewSupplierInvoiceScreen> createState() => _AddNewSupplierInvoiceScreenState();
}

class _AddNewSupplierInvoiceScreenState extends State<AddNewSupplierInvoiceScreen> {
  final GlobalKey<TextFieldAutoCompleteState<ItemEntity>> _textFieldAutoCompleteKey =  GlobalKey();
  final TextEditingController supplierNameController = TextEditingController();
  final TextEditingController supplierIdController = TextEditingController();
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _itemBarCodeController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _kartonaController = TextEditingController(text: '0');
  final TextEditingController _dastaController = TextEditingController(text: '0');
  final TextEditingController _ketaaController = TextEditingController(text: '0');
  final TextEditingController totalController = TextEditingController(text: '0');
  final TextEditingController paidController = TextEditingController(text: '0');
  final TextEditingController remainedController = TextEditingController(text: '0');

  DateTime? currentDate = DateTime.now();
  String formattedDate = intl.DateFormat('yyyy-MM-dd').format(DateTime.now());
  bool status = false;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SupplierController>(context, listen: false).getSuppliers(const NoParameters());
      Provider.of<ItemsController>(context, listen: false).getItems(const NoParameters());
      Provider.of<ItemsController>(context, listen: false).invoiceItems.clear;
    });
  }


  @override
  void dispose() {
    supplierNameController.dispose();
    supplierIdController.dispose();
    _itemNameController.dispose();
    _itemBarCodeController.dispose();
    _priceController.dispose();
    _kartonaController.dispose();
    _dastaController.dispose();
    _ketaaController.dispose();
    totalController.dispose();
    paidController.dispose();
    remainedController.dispose();
    Provider.of<ItemsController>(context, listen: false).clearItemsList();
    Provider.of<ItemsController>(context, listen: false).setCurrentItem(null);
    super.dispose();
  }



  bool itemAlreadyExists(int itemId) {
    for (var item in  Provider.of<ItemsController>(context, listen: false).invoiceItems) {
      if (item.id == itemId) {
        return true;
      }
    }
    return false;
  }

  double calculateitemTotal({
    int? numOfKetaaInDasta,
    int? numOfDastaInKartona,
    int? dastaPrice,

    int? kartonaQnty,
    int? DastaQnty,
    int? KetaQnty,
  }){
    double ketaPrice = (dastaPrice ?? 1) / (numOfKetaaInDasta ?? 1) ;
    print('ketaPrice : ${ketaPrice.toString()}');
    double kartonaPrice = (numOfDastaInKartona ?? 1) * (dastaPrice ?? 1).toDouble() ;
    print('kartonaPrice : ${kartonaPrice.toString()}');
    double itemTotal = ((kartonaQnty ?? 0) * kartonaPrice) + ((DastaQnty ?? 0) * (dastaPrice ?? 1)) + ((KetaQnty ?? 0) * ketaPrice);
    print('itemTotal : ${itemTotal.toString()}');
    return itemTotal;
  }


  List<String> images = [];
  Future<List<String>> pickAndConvertImages(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    List<String> base64Images = [];

    List<XFile>? images = [];
    // Allow multiple image selection if supported by your implementation
    switch(source){
      case ImageSource.camera:
        final image = await ImagePicker().pickImage(source: source);
        images.add(image!);
      case ImageSource.gallery:
        images = await _picker.pickMultiImage();
    }

    if (images != null) {
      for (var image in images) {
        File imageFile = File(image.path);
        // Convert to base64
        String base64Image = base64Encode(await imageFile.readAsBytes());
        base64Images.add(base64Image);
      }
    }

    return base64Images;
  }

  @override
  Widget build(BuildContext context) {
    final itemsController = Provider.of<ItemsController>(context);
    return WillPopScope(
      onWillPop: ()async{
        Provider.of<ItemsController>(context, listen: false).clearItemsList();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('فاتورة مشتريات'),
          // actions: [
          //   Column(
          //     children: [
          //       const Text('كل الاصناف'),
          //       Consumer<ItemsController>(
          //         builder: (context, allItemsController, _){
          //           return Text('${allItemsController.gettingItems?.length ?? 0}');
          //         },
          //       ),
          //     ],
          //   ),
          //   if(Platform.isWindows)
          //     ...[FlutterSwitch(
          //       activeText: 'hot',
          //       inactiveText: 'all',
          //       activeTextFontWeight: FontWeight.w100,
          //       width: 125.0,
          //       height: 55.0,
          //       activeColor: Colors.purple,
          //       valueFontSize: 16.0,
          //       toggleSize: 30.0,
          //       value: status,
          //       borderRadius: 30.0,
          //       padding: 8.0,
          //       showOnOff: true,
          //       onToggle: (val) {
          //         setState(() {
          //           status = val;
          //           print(status);
          //         });
          //       },
          //     )],
          //   if(Platform.isAndroid)
          //     ...[FlutterSwitch(
          //       activeText: 'hot',
          //       inactiveText: 'all',
          //       activeTextFontWeight: FontWeight.w100,
          //       width: 85.0,
          //       height: 34.0,
          //       activeColor: Colors.purple,
          //       valueFontSize: 16.0,
          //       toggleSize: 30.0,
          //       value: status,
          //       borderRadius: 30.0,
          //       padding: 4.0,
          //       showOnOff: true,
          //       onToggle: (val) {
          //         setState(() {
          //           status = val;
          //           print(status);
          //         });
          //       },
          //     )],
          //   Column(
          //     children: [
          //       const Text('اصناف خاصه'),
          //       Consumer<HotItemsController>(
          //         builder: (context, hotItemsController, _){
          //           return Text('${hotItemsController.gettingItems?.length ?? 0}');
          //         },
          //       ),
          //     ],
          //   ),
          // ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  SpeedDial(
                    mini: true,
                    animatedIcon: AnimatedIcons.add_event,
                    tooltip: 'اضافة مورد جديد',
                    direction: SpeedDialDirection.down,
                    children: [
                      SpeedDialChild(
                        child: const Icon(Icons.contact_phone_outlined),
                        label: 'جهات الاتصال',
                        onTap: () {
                          RouteGenerator.navigationTo(AppRoutes.contactsScreenRoute);
                        },
                      ),
                      SpeedDialChild(
                        child: const Icon(Icons.edit_note),
                        label: 'تسجيل مورد',
                        onTap: () =>  RouteGenerator.navigationTo(AppRoutes.addNewSupplierScreenRoute),
                      ),
                    ],
                  ),
                  // IconButton(
                  //     onPressed: (){
                  //       RouteGenerator.navigationTo(AppRoutes.suppliersScreenRoute);
                  //     },
                  //     icon: const Icon(Icons.add),
                  // ),
                  Flexible(
                    flex: 1,
                    child: SizedBox(
                      height: 40,
                      child: TypeAheadField<SupplierEntity>(
                        textFieldConfiguration: TextFieldConfiguration(
                          controller: supplierNameController,
                          //focusNode: _nameFocusNode,
                          decoration: InputDecoration(
                            labelText: 'اسم المورد',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onEditingComplete: () {
                            // Optional: Manually select the first suggestion when Enter is pressed
                            final supplierController = Provider.of<SupplierController>(context, listen: false);
                            final suggestions = supplierController.getSuggestions(supplierNameController.text);
                            if (suggestions.isNotEmpty) {
                              SupplierEntity selectedSupplier = suggestions.first;
                              supplierNameController.text = selectedSupplier.supplierName ?? '';
                              supplierIdController.text = selectedSupplier.id.toString();
                              Provider.of<HotItemsController>(context, listen: false).getHotItems(selectedSupplier?.id ?? 0);
                              Provider.of<SupplierController>(context, listen: false).setCurrentSupplierId(selectedSupplier.id!);
                              //FocusScope.of(context).requestFocus(_codeFocusNode);
                            } else {
                              //_nameFocusNode.unfocus();
                              // FocusScope.of(context).requestFocus(_codeFocusNode);
                            }
                          },
                          // Add this to handle arrow key navigation
                          onSubmitted: (value) {
                            final supplierController = Provider.of<SupplierController>(context, listen: false);
                            final suggestions = supplierController.getSuggestions(value);

                            if (suggestions.isNotEmpty) {
                              SupplierEntity selectedSupplier = suggestions.first;
                              supplierNameController.text = selectedSupplier.supplierName ?? '';
                              supplierIdController.text = selectedSupplier.id.toString();
                              Provider.of<HotItemsController>(context, listen: false).getHotItems(selectedSupplier?.id ?? 0);
                              Provider.of<SupplierController>(context, listen: false).setCurrentSupplierId(selectedSupplier.id!);
                              //FocusScope.of(context).requestFocus(_codeFocusNode);
                            } else {
                              //_nameFocusNode.unfocus();
                              //FocusScope.of(context).requestFocus(_codeFocusNode);
                            }
                          },
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
                          supplierNameController.text = suggestion.supplierName ?? '';
                          supplierIdController.text = suggestion.id.toString();
                          Provider.of<HotItemsController>(context, listen: false).getHotItems(suggestion?.id ?? 0);
                          Provider.of<SupplierController>(context, listen: false).setCurrentSupplierId(suggestion.id!);
                          //_nameFocusNode.unfocus();
                          //FocusScope.of(context).requestFocus(_codeFocusNode);
                        },
                        // Automatically flip suggestion highlight with arrow keys
                        autoFlipDirection: true, // Enables the direction flip when suggestions appear
                        hideOnEmpty: true,       // Hide when there's no suggestion
                      ),
                    ),
                  ),
                  const SizedBox(width: 8,),
                  MaterialButton(
                    height: SizeManager.s_48,
                    minWidth: Platform.isWindows ? 350 : 100,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                        side: const BorderSide(color: Colors.black)
                    ),
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      setState(() {
                        currentDate = pickedDate ?? DateTime.now();
                        formattedDate = intl.DateFormat('yyyy-MM-dd').format(currentDate!);
                      });
                    },
                    child: Text('التاريخ ${formattedDate }'),
                  ),
                ],
              ),
              const SizedBox(height: 8,),
              Container(
                decoration: BoxDecoration(
                    color: Colors.black12,
                    border: Border.all()
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                          children: [
                            InkWell(
                              onTap: (){
                                (Provider.of<ItemsController>(context,listen: false).currentItem?.images != null && Provider.of<ItemsController>(context,listen: false).currentItem!.images!.isNotEmpty)
                                    ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FullNetworkImageScreen(
                                      imageUrl: Provider.of<ItemsController>(context,listen: false).currentItem!.images!.first!,
                                    ),
                                  ),
                                )
                                    : null; // Placeholder URL
                              },
                              onLongPress: () {
                                if(
                                Provider.of<ItemsController>(context, listen: false).currentItem!.id != null &&
                                    Provider.of<SupplierController>(context, listen: false).currentSupplierId != null
                                ){
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      GetItemHistoryParameters getItemHistoryParameters = GetItemHistoryParameters(
                                        itemId:     Provider.of<ItemsController>(context, listen: false).currentItem!.id!,
                                        supplierId: Provider.of<SupplierController>(context, listen: false).currentSupplierId!,
                                      );
                                      Provider.of<ItemHistoryController>(context, listen: false).getItemHistory(getItemHistoryParameters);

                                      return Consumer<ItemHistoryController>(
                                        builder: (context, itemHistoryController, _) {
                                          return Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: AlertDialog(
                                              actionsAlignment: MainAxisAlignment.center,
                                              title: const Text('العمليات  السابقه'),
                                              content: SizedBox(
                                                width: double.maxFinite,
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    if (itemHistoryController.getItemHistoryIsLoading)
                                                      const CircularProgressIndicator.adaptive(),

                                                    if (itemHistoryController.getItemHistoryErrorMessage.isNotEmpty)
                                                      Text(itemHistoryController.getItemHistoryErrorMessage),

                                                    if (itemHistoryController.gettingItemHistory != null &&
                                                        itemHistoryController.gettingItemHistory!.isNotEmpty)
                                                      Expanded(
                                                        child: ListView.separated(
                                                          shrinkWrap: true,
                                                          itemBuilder: (context, index) {
                                                            final itemHistory = itemHistoryController.gettingItemHistory![index];
                                                            return ListTile(
                                                              title: Text('التاريخ ${itemHistory.date}'),
                                                              subtitle: Text('السعر ${itemHistory.itemPrice}'),
                                                              trailing: TextButton(
                                                                onPressed: (){
                                                                  RouteGenerator.navigationTo(AppRoutes.supplierInvoiceDetailsScreenRoute, arguments: itemHistory.invoiceId);
                                                                },
                                                                child: CircleAvatar(
                                                                  child: Text('${itemHistory.invoiceId}'),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          separatorBuilder: (context, index) => const Divider(),
                                                          itemCount: itemHistoryController.gettingItemHistory!.length,
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                              actions: [
                                                IconButton(
                                                    onPressed: (){
                                                      Navigator.pop(context);
                                                    },
                                                    icon: const Icon(Icons.arrow_back)),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  );
                                }
                              },
                              child: CircleAvatar(
                                child: CachedNetworkImage(
                                  width: 50,
                                  height: 50,
                                  imageUrl: (Provider.of<ItemsController>(context,listen: false).currentItem?.images != null && Provider.of<ItemsController>(context,listen: false).currentItem!.images!.isNotEmpty)
                                      ? Provider.of<ItemsController>(context,listen: false).currentItem!.images!.first!
                                      : 'https://placehold.co/400', // Placeholder URL
                                  placeholder: (context, url) {
                                    if (Provider.of<ItemsController>(context,listen: false).currentItem?.images != null && Provider.of<ItemsController>(context,listen: false).currentItem!.images!.isNotEmpty) {
                                      print(Provider.of<ItemsController>(context,listen: false).currentItem?.images != null && Provider.of<ItemsController>(context,listen: false).currentItem!.images!.isNotEmpty);
                                    } else {
                                      print("No image available");
                                    }
                                    return const CircularProgressIndicator();
                                  },
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8,),
                            // Platform.isAndroid
                            //     ? Flexible(
                            //   child: Container(
                            //     height: 58,
                            //     decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(4),
                            //     ),
                            //     child: TextFieldAutoComplete<ItemEntity>(
                            //       decoration: const InputDecoration(
                            //         enabledBorder:  OutlineInputBorder(
                            //           borderSide: BorderSide(color: Colors.black),
                            //         ),
                            //         focusedBorder:  OutlineInputBorder(
                            //           borderSide: BorderSide(color: Colors.purple),
                            //         ),
                            //         labelText: "اسم الصنف",
                            //         hintText:
                            //         "اسم الصنف",
                            //         floatingLabelBehavior: FloatingLabelBehavior.always,
                            //         hintStyle: TextStyle(
                            //           color: Colors.black,
                            //           fontSize: 16,
                            //           fontFamily: 'Roboto',
                            //           fontWeight: FontWeight.w300,
                            //         ),
                            //       ),
                            //       clearOnSubmit: false,
                            //       controller: _itemNameController,
                            //         itemSubmitted: (ItemEntity selectedItem) {
                            //           // Set the controller to the selected item's name (or another field)
                            //           _itemNameController.text = selectedItem.name ?? '';
                            //
                            //           // Update the current item in the ItemsController
                            //           Provider.of<ItemsController>(context, listen: false).setCurrentItem(selectedItem);
                            //
                            //           // Set the price controller's value to the selected item's selling price
                            //           _priceController.text = selectedItem.sellingPrice?.toString() ?? '';
                            //
                            //           // Optionally, update the item
                            //           final updatedItem = Provider.of<ItemsController>(context, listen: false).currentItem!.copyWith(
                            //             sellingPrice: num.tryParse(_priceController.text),
                            //           );
                            //
                            //           // Update the item in the invoice list
                            //           itemsController.updateCurrentItem(updatedItem);
                            //
                            //           // Debug print for the selected item's image(s)
                            //           print(Provider.of<ItemsController>(context, listen: false).currentItem?.images.toString());
                            //         },
                            //       key: _textFieldAutoCompleteKey,
                            //       suggestions: itemsController.getSuggestions(_itemNameController.text),
                            //       itemBuilder: (context, item) {
                            //         return Container(
                            //           padding: const EdgeInsets.all(20),
                            //           child: Row(
                            //             children: [
                            //               Text(
                            //                 item.name??'',
                            //                 style: const TextStyle(color: Colors.black),
                            //               )
                            //             ],
                            //           ),
                            //         );
                            //       },
                            //       itemFilter: (item, query) {
                            //         return item.name!.toLowerCase().contains(query.toLowerCase());
                            //       },
                            //       itemSorter: (ItemEntity a, ItemEntity b) {
                            //         return a.name!.compareTo(b.name??'');
                            //       },
                            //     ),
                            //   ),
                            // )
                            //     :

                            ///TODO: Test For Type Ahead
                            // Flexible(
                            //   child: Autocomplete<ItemEntity>(
                            //     optionsBuilder: (TextEditingValue textEditingValue) {
                            //       if (textEditingValue.text.isEmpty) {
                            //         return const Iterable.empty();
                            //       }
                            //       final items;
                            //       if(status == true){
                            //         items = Provider.of<HotItemsController>(context, listen: false)
                            //             .getSuggestions(textEditingValue.text)
                            //             .where((item) => item.name!.toLowerCase().contains(textEditingValue.text.toLowerCase()));
                            //       }
                            //       else if(status == false){
                            //         items = Provider.of<ItemsController>(context, listen: false)
                            //             .getSuggestions(textEditingValue.text)
                            //             .where((item) => item.name!.toLowerCase().contains(textEditingValue.text.toLowerCase()));
                            //       }else{
                            //         items = Provider.of<ItemsController>(context, listen: false)
                            //             .getSuggestions(textEditingValue.text)
                            //             .where((item) => item.name!.toLowerCase().contains(textEditingValue.text.toLowerCase()));
                            //       }
                            //       return items;
                            //     },
                            //     displayStringForOption: (option) => option.name ?? '',
                            //     onSelected: (ItemEntity selectedItem) {
                            //       print(selectedItem.images.toString());
                            //       Provider.of<ItemsController>(context, listen: false).setCurrentItem(selectedItem);
                            //       _priceController.text = selectedItem.sellingPrice?.toString() ?? '';
                            //       final updatedItem = Provider.of<ItemsController>(context, listen: false).currentItem!.copyWith(
                            //         sellingPrice: num.tryParse(_priceController.text),
                            //
                            //       );
                            //       // Update the item in the invoice list
                            //       itemsController.updateCurrentItem(updatedItem);
                            //       print(Provider.of<ItemsController>(context,listen: false).currentItem?.images.toString());
                            //     },
                            //
                            //   ),
                            // ),

                            Flexible(
                              flex: 1,
                              child: SizedBox(
                                height: 40,
                                child: TypeAheadField<ItemEntity>(
                                  textFieldConfiguration: TextFieldConfiguration(
                                    controller: _itemNameController,
                                    //focusNode: _nameFocusNode,
                                    decoration: InputDecoration(
                                      labelText: 'الصنف',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    onEditingComplete: () {
                                      // Optional: Manually select the first suggestion when Enter is pressed
                                      final itmController = Provider.of<ItemsController>(context, listen: false);
                                      final suggestions = itmController.getSuggestions(_itemNameController.text);
                                      if (suggestions.isNotEmpty) {
                                        ItemEntity selectedItem = suggestions.first;
                                        _itemNameController.text = selectedItem.name ?? '';
                                        //supplierIdController.text = selectedSupplier.id.toString();
                                        //Provider.of<HotItemsController>(context, listen: false).getHotItems(selectedSupplier?.id ?? 0);
                                        //Provider.of<SupplierController>(context, listen: false).setCurrentSupplierId(selectedSupplier.id!);
                                        //FocusScope.of(context).requestFocus(_codeFocusNode);
                                      } else {
                                        //_nameFocusNode.unfocus();
                                        // FocusScope.of(context).requestFocus(_codeFocusNode);
                                      }
                                    },
                                  ),
                                  suggestionsCallback: (pattern) {
                                    final itmController = Provider.of<ItemsController>(context, listen: false);
                                    final hotItmController = Provider.of<HotItemsController>(context, listen: false);
                                    if(status == true){
                                      return hotItmController.getSuggestions(pattern);
                                    }
                                    return itmController.getSuggestions(pattern);

                                    // final items;
                                    // //       if(status == true){
                                    // //         items = Provider.of<HotItemsController>(context, listen: false)
                                    // //             .getSuggestions(textEditingValue.text)
                                    // //             .where((item) => item.name!.toLowerCase().contains(textEditingValue.text.toLowerCase()));
                                    // //       }
                                    // //       else if(status == false){
                                    // //         items = Provider.of<ItemsController>(context, listen: false)
                                    // //             .getSuggestions(textEditingValue.text)
                                    // //             .where((item) => item.name!.toLowerCase().contains(textEditingValue.text.toLowerCase()));
                                    // //       }else{
                                    // //         items = Provider.of<ItemsController>(context, listen: false)
                                    // //             .getSuggestions(textEditingValue.text)
                                    // //             .where((item) => item.name!.toLowerCase().contains(textEditingValue.text.toLowerCase()));
                                    // //       }
                                    // //       return items;

                                  },
                                  itemBuilder: (context, ItemEntity suggestion) {
                                    return Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          child: CachedNetworkImage(
                                            width: 50,
                                            height: 50,
                                            imageUrl: (suggestion?.images != null && suggestion!.images!.isNotEmpty)
                                                ? suggestion!.images!.first!
                                                : 'https://placehold.co/400', // Placeholder URL
                                            placeholder: (context, url) {
                                              if (suggestion?.images != null && suggestion!.images!.isNotEmpty) {
                                                print(suggestion?.images != null && suggestion!.images!.isNotEmpty);
                                              } else {
                                                print("No image available");
                                              }
                                              return const CircularProgressIndicator();
                                            },
                                            errorWidget: (context, url, error) => const Icon(Icons.error),
                                          ),
                                        ),
                                        title: Text(suggestion.name ?? ''),
                                        subtitle: Text('سعر البيع ${suggestion.sellingPrice.toString() ?? ''}'),
                                      ),
                                    );
                                  },
                                  onSuggestionSelected: (ItemEntity selectedItem) {
                                    _itemNameController.text = selectedItem.name?? '';
                                    print(selectedItem.images.toString());
                                    Provider.of<ItemsController>(context, listen: false).setCurrentItem(selectedItem);
                                    _priceController.text = selectedItem.sellingPrice?.toString() ?? '';
                                    final updatedItem = Provider.of<ItemsController>(context, listen: false).currentItem!.copyWith(
                                      sellingPrice: num.tryParse(_priceController.text),

                                    );
                                    // Update the item in the invoice list
                                    itemsController.updateCurrentItem(updatedItem);
                                    print(Provider.of<ItemsController>(context,listen: false).currentItem?.images.toString());
                                  },
                                  // Automatically flip suggestion highlight with arrow keys
                                  autoFlipDirection: true, // Enables the direction flip when suggestions appear
                                  hideOnEmpty: true,       // Hide when there's no suggestion
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: (){
                                  showDialog(
                                      context: context,
                                      builder: (context){
                                        return const AddItemDialog();
                                      },
                                  );
                                },
                                icon: const Icon(Icons.add),
                            ),

                            IconButton(
                              icon: const Icon(Icons.clear), // Icon for clearing the selection
                              onPressed: () {
                                // Clear the selected option and reset the fields
                                _itemNameController.clear();
                                _itemBarCodeController.clear();
                                _priceController.text = '0';
                                _kartonaController.text = '0';
                                _dastaController.text = '0';
                                _ketaaController.text = '0';
                                // setState(() {
                                //   _selectedItem = null; // Reset the selected item
                                // });
                              },
                            ),
                          ]
                      ),
                      const SizedBox(height: 5,),
                      if(Platform.isWindows)
                        ...[Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _kartonaController,
                                keyboardType: TextInputType.number,
                                decoration:  InputDecoration(
                                  enabledBorder:  const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  focusedBorder:  const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.purple),
                                  ),
                                  labelText: 'كرتونه = ${itemsController.currentItem?.kartona.toString()} دسته',
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                  hintStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                onChanged: (newValue){
                                  if(newValue.isEmpty){
                                    _kartonaController.text = '0';
                                    final updatedItem = Provider.of<ItemsController>(context, listen: false).currentItem!.copyWith(
                                      kartonaQuntity: num.tryParse(_kartonaController.text),
                                    );
                                    itemsController.updateCurrentItem(updatedItem);
                                    ///TODO : calc item total price
                                    double dastaPrice;
                                    double kartonaPrice;
                                    double ketaPrice;

                                    int dastaQuntity;
                                    int kartonaQuntity;
                                    int ketaQuntity;

                                    int numOfDastaInKartona;
                                    int numOfKetaaInDasta;

                                    dastaPrice = Provider.of<ItemsController>(context, listen: false).currentItem?.sellingPrice?.toDouble() ?? 0.0;
                                    ketaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.ketaaQuntity?.toInt() ?? 0;

                                    ketaPrice = dastaPrice / (Provider.of<ItemsController>(context, listen: false).currentItem?.dasta ?? 1);
                                    ketaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.ketaaQuntity?.toInt() ?? 0;

                                    numOfKetaaInDasta = Provider.of<ItemsController>(context, listen: false).currentItem?.dasta?.toInt() ?? 12;
                                    numOfDastaInKartona = Provider.of<ItemsController>(context, listen: false).currentItem?.kartona?.toInt() ?? 12;

                                    kartonaPrice = numOfDastaInKartona * dastaPrice;
                                    ketaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.ketaaQuntity?.toInt() ?? 0;
                                    dastaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.dastaQuntity?.toInt() ?? 0;

                                    double itemTotal = ((ketaQuntity * ketaPrice) + ((dastaQuntity)* dastaPrice) + ((int.tryParse(_kartonaController.text) ?? 1) * kartonaPrice));

                                    itemsController.updateCurrentItem(Provider.of<ItemsController>(context, listen: false).currentItem!.copyWith(itemTotalPrice: itemTotal));
                                  }
                                  else{
                                    final updatedItem = Provider.of<ItemsController>(context, listen: false).currentItem!.copyWith(
                                      kartonaQuntity: num.tryParse(_kartonaController.text),
                                    );
                                    itemsController.updateCurrentItem(updatedItem);
                                    ///TODO : calc item total price
                                    double dastaPrice;
                                    double kartonaPrice;
                                    double ketaPrice;

                                    int dastaQuntity;
                                    int kartonaQuntity;
                                    int ketaQuntity;

                                    int numOfDastaInKartona;
                                    int numOfKetaaInDasta;

                                    dastaPrice = Provider.of<ItemsController>(context, listen: false).currentItem?.sellingPrice?.toDouble() ?? 0.0;
                                    ketaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.ketaaQuntity?.toInt() ?? 0;

                                    ketaPrice = dastaPrice / (Provider.of<ItemsController>(context, listen: false).currentItem?.dasta ?? 1);
                                    ketaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.ketaaQuntity?.toInt() ?? 0;

                                    numOfKetaaInDasta = Provider.of<ItemsController>(context, listen: false).currentItem?.dasta?.toInt() ?? 12;
                                    numOfDastaInKartona = Provider.of<ItemsController>(context, listen: false).currentItem?.kartona?.toInt() ?? 12;

                                    kartonaPrice = numOfDastaInKartona * dastaPrice;
                                    ketaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.ketaaQuntity?.toInt() ?? 0;
                                    dastaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.dastaQuntity?.toInt() ?? 0;

                                    double itemTotal = ((ketaQuntity * ketaPrice) + ((dastaQuntity)* dastaPrice) + ((int.tryParse(_kartonaController.text) ?? 1) * kartonaPrice));

                                    itemsController.updateCurrentItem(Provider.of<ItemsController>(context, listen: false).currentItem!.copyWith(itemTotalPrice: itemTotal));
                                  }
                                },
                              ),
                            ),
                            const SizedBox(width: 8), // Spacing between fields
                            Expanded(
                              child: TextField(
                                controller: _dastaController,
                                keyboardType: TextInputType.number,
                                decoration:  InputDecoration(
                                  enabledBorder:  const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  focusedBorder:  const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.purple),
                                  ),
                                  labelText: 'دسته = ${itemsController.currentItem?.dasta.toString()} قطعه',
                                  //hintText: 'كرتونه = ${_selectedItem?.kartona.toString()} دسته',
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                  hintStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    //fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                onChanged: (newValue){
                                  if(newValue.isEmpty){
                                    _dastaController.text = '0';
                                    final updatedItem = Provider.of<ItemsController>(context, listen: false).currentItem!.copyWith(
                                      dastaQuntity: num.tryParse(_dastaController.text),
                                    );
                                    // Update the item in the invoice list
                                    itemsController.updateCurrentItem(updatedItem);

                                    ///TODO : calc item total price
                                    double dastaPrice;
                                    double kartonaPrice;
                                    double ketaPrice;

                                    int dastaQuntity;
                                    int kartonaQuntity;
                                    int ketaQuntity;

                                    int numOfDastaInKartona;
                                    int numOfKetaaInDasta;

                                    dastaPrice = Provider.of<ItemsController>(context, listen: false).currentItem?.sellingPrice?.toDouble() ?? 0.0;
                                    ketaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.ketaaQuntity?.toInt() ?? 0;

                                    ketaPrice = dastaPrice / (Provider.of<ItemsController>(context, listen: false).currentItem?.dasta ?? 1);
                                    ketaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.ketaaQuntity?.toInt() ?? 0;

                                    numOfKetaaInDasta = Provider.of<ItemsController>(context, listen: false).currentItem?.dasta?.toInt() ?? 12;

                                    kartonaPrice = numOfKetaaInDasta * dastaPrice;
                                    ketaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.ketaaQuntity?.toInt() ?? 0;
                                    dastaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.dastaQuntity?.toInt() ?? 0;
                                    kartonaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.kartonaQuntity?.toInt() ?? 0;

                                    double itemTotal = ((ketaQuntity * ketaPrice) + (((int.tryParse(_dastaController.text) ?? 1))* dastaPrice) + (kartonaQuntity * kartonaPrice));

                                    itemsController.updateCurrentItem(Provider.of<ItemsController>(context, listen: false).currentItem!.copyWith(itemTotalPrice: itemTotal));
                                  }
                                  else{
                                    final updatedItem = Provider.of<ItemsController>(context, listen: false).currentItem!.copyWith(
                                      dastaQuntity: num.tryParse(_dastaController.text),
                                    );
                                    // Update the item in the invoice list
                                    itemsController.updateCurrentItem(updatedItem);

                                    ///TODO : calc item total price
                                    double dastaPrice;
                                    double kartonaPrice;
                                    double ketaPrice;

                                    int dastaQuntity;
                                    int kartonaQuntity;
                                    int ketaQuntity;

                                    int numOfDastaInKartona;
                                    int numOfKetaaInDasta;

                                    dastaPrice = Provider.of<ItemsController>(context, listen: false).currentItem?.sellingPrice?.toDouble() ?? 0.0;
                                    ketaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.ketaaQuntity?.toInt() ?? 0;

                                    ketaPrice = dastaPrice / (Provider.of<ItemsController>(context, listen: false).currentItem?.dasta ?? 1);
                                    ketaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.ketaaQuntity?.toInt() ?? 0;

                                    numOfKetaaInDasta = Provider.of<ItemsController>(context, listen: false).currentItem?.dasta?.toInt() ?? 12;

                                    kartonaPrice = numOfKetaaInDasta * dastaPrice;
                                    ketaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.ketaaQuntity?.toInt() ?? 0;
                                    dastaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.dastaQuntity?.toInt() ?? 0;
                                    kartonaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.kartonaQuntity?.toInt() ?? 0;

                                    double itemTotal = ((ketaQuntity * ketaPrice) + (((int.tryParse(_dastaController.text) ?? 1))* dastaPrice) + (kartonaQuntity * kartonaPrice));

                                    itemsController.updateCurrentItem(Provider.of<ItemsController>(context, listen: false).currentItem!.copyWith(itemTotalPrice: itemTotal));

                                  }
                                },
                              ),
                            ),
                            const SizedBox(width: 8), // Spacing between fields
                            Expanded(
                              child: TextField(
                                controller: _ketaaController,
                                keyboardType: TextInputType.number,
                                decoration:  const InputDecoration(
                                  enabledBorder:  OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  focusedBorder:  OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.purple),
                                  ),
                                  labelText: 'قطعه',
                                  //hintText: 'كرتونه = ${_selectedItem?.kartona.toString()} دسته',
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    //fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                onChanged: (newValue){
                                  if(newValue.isEmpty){
                                    _ketaaController.text = '0';
                                    final updatedItem = Provider.of<ItemsController>(context, listen: false).currentItem!.copyWith(
                                      ketaaQuntity: num.tryParse(_ketaaController.text),
                                    );
                                    // Update the item in the invoice list
                                    itemsController.updateCurrentItem(updatedItem);

                                    ///TODO : calc item total price
                                    double dastaPrice;
                                    double kartonaPrice;
                                    double ketaPrice;

                                    int dastaQuntity;
                                    int kartonaQuntity;
                                    int ketaQuntity;

                                    int numOfDastaInKartona;
                                    int numOfKetaaInDasta;

                                    dastaPrice = Provider.of<ItemsController>(context, listen: false).currentItem?.sellingPrice?.toDouble() ?? 0.0;
                                    ketaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.ketaaQuntity?.toInt() ?? 0;

                                    ketaPrice = dastaPrice / (Provider.of<ItemsController>(context, listen: false).currentItem?.dasta ?? 1);
                                    ketaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.ketaaQuntity?.toInt() ?? 0;

                                    numOfKetaaInDasta = Provider.of<ItemsController>(context, listen: false).currentItem?.dasta?.toInt() ?? 12;

                                    kartonaPrice = numOfKetaaInDasta * dastaPrice;
                                    ketaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.ketaaQuntity?.toInt() ?? 0;
                                    dastaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.dastaQuntity?.toInt() ?? 0;
                                    kartonaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.kartonaQuntity?.toInt() ?? 0;

                                    double itemTotal = ((((int.tryParse(_ketaaController.text) ?? 1)) * ketaPrice) + (dastaQuntity* dastaPrice) + (kartonaQuntity * kartonaPrice));

                                    itemsController.updateCurrentItem(Provider.of<ItemsController>(context, listen: false).currentItem!.copyWith(itemTotalPrice: itemTotal));
                                  }
                                  else{
                                    final updatedItem = Provider.of<ItemsController>(context, listen: false).currentItem!.copyWith(
                                      ketaaQuntity: num.tryParse(_ketaaController.text),
                                    );
                                    // Update the item in the invoice list
                                    itemsController.updateCurrentItem(updatedItem);

                                    ///TODO : calc item total price
                                    double dastaPrice;
                                    double kartonaPrice;
                                    double ketaPrice;

                                    int dastaQuntity;
                                    int kartonaQuntity;
                                    int ketaQuntity;

                                    int numOfDastaInKartona;
                                    int numOfKetaaInDasta;

                                    dastaPrice = Provider.of<ItemsController>(context, listen: false).currentItem?.sellingPrice?.toDouble() ?? 0.0;
                                    ketaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.ketaaQuntity?.toInt() ?? 0;

                                    ketaPrice = dastaPrice / (Provider.of<ItemsController>(context, listen: false).currentItem?.dasta ?? 1);
                                    ketaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.ketaaQuntity?.toInt() ?? 0;

                                    numOfKetaaInDasta = Provider.of<ItemsController>(context, listen: false).currentItem?.dasta?.toInt() ?? 12;

                                    kartonaPrice = numOfKetaaInDasta * dastaPrice;
                                    ketaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.ketaaQuntity?.toInt() ?? 0;
                                    dastaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.dastaQuntity?.toInt() ?? 0;
                                    kartonaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.kartonaQuntity?.toInt() ?? 0;

                                    double itemTotal = ((((int.tryParse(_ketaaController.text) ?? 1)) * ketaPrice) + (dastaQuntity* dastaPrice) + (kartonaQuntity * kartonaPrice));

                                    itemsController.updateCurrentItem(Provider.of<ItemsController>(context, listen: false).currentItem!.copyWith(itemTotalPrice: itemTotal));
                                  }
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Container(
                                height: 58,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Tooltip(
                                  message: '${Provider.of<ItemsController>(context, listen: false).currentItem?.purchasingPrice.toString()}',
                                  child: TextField(
                                    controller: _priceController,
                                    keyboardType: TextInputType.number,
                                    decoration:  const InputDecoration(
                                      enabledBorder:   OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black),
                                      ),
                                      focusedBorder:   OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.purple),
                                      ),
                                      labelText:  'سعر الدسته',
                                      floatingLabelBehavior: FloatingLabelBehavior.always,
                                      hintStyle:  TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        //fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    onChanged: (newValue){
                                      if(newValue.isEmpty){
                                        _priceController.text = '0';
                                        final updatedItem = Provider.of<ItemsController>(context, listen: false).currentItem!.copyWith(
                                          sellingPrice: num.tryParse(_priceController.text),
                                        );
                                        // Update the item in the invoice list
                                        itemsController.updateCurrentItem(updatedItem);
                                        ///TODO : calc item total price
                                        double dastaPrice;
                                        double kartonaPrice;
                                        double ketaPrice;

                                        int dastaQuntity;
                                        int kartonaQuntity;
                                        int ketaQuntity;

                                        int numOfDastaInKartona;
                                        int numOfKetaaInDasta;

                                        dastaPrice = Provider.of<ItemsController>(context, listen: false).currentItem?.sellingPrice?.toDouble() ?? 0.0;
                                        ketaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.ketaaQuntity?.toInt() ?? 0;

                                        ketaPrice = dastaPrice / (Provider.of<ItemsController>(context, listen: false).currentItem?.dasta ?? 1);
                                        ketaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.ketaaQuntity?.toInt() ?? 0;

                                        numOfKetaaInDasta = Provider.of<ItemsController>(context, listen: false).currentItem?.dasta?.toInt() ?? 12;

                                        kartonaPrice = numOfKetaaInDasta * dastaPrice;
                                        ketaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.ketaaQuntity?.toInt() ?? 0;
                                        dastaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.dastaQuntity?.toInt() ?? 0;
                                        kartonaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.kartonaQuntity?.toInt() ?? 0;

                                        double itemTotal = ((ketaQuntity * ketaPrice) + (dastaQuntity* dastaPrice) + (kartonaQuntity * kartonaPrice));

                                        itemsController.updateCurrentItem(Provider.of<ItemsController>(context, listen: false).currentItem!.copyWith(itemTotalPrice: itemTotal));

                                      }else{
                                        final updatedItem = Provider.of<ItemsController>(context, listen: false).currentItem!.copyWith(
                                          sellingPrice: num.tryParse(_priceController.text),
                                        );
                                        // Update the item in the invoice list
                                        itemsController.updateCurrentItem(updatedItem);
                                        ///TODO : calc item total price
                                        double dastaPrice;
                                        double kartonaPrice;
                                        double ketaPrice;

                                        int dastaQuntity;
                                        int kartonaQuntity;
                                        int ketaQuntity;

                                        int numOfDastaInKartona;
                                        int numOfKetaaInDasta;

                                        dastaPrice = Provider.of<ItemsController>(context, listen: false).currentItem?.sellingPrice?.toDouble() ?? 0.0;
                                        ketaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.ketaaQuntity?.toInt() ?? 0;

                                        ketaPrice = dastaPrice / (Provider.of<ItemsController>(context, listen: false).currentItem?.dasta ?? 1);
                                        ketaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.ketaaQuntity?.toInt() ?? 0;

                                        numOfKetaaInDasta = Provider.of<ItemsController>(context, listen: false).currentItem?.dasta?.toInt() ?? 12;

                                        kartonaPrice = numOfKetaaInDasta * dastaPrice;
                                        ketaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.ketaaQuntity?.toInt() ?? 0;
                                        dastaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.dastaQuntity?.toInt() ?? 0;
                                        kartonaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.kartonaQuntity?.toInt() ?? 0;

                                        double itemTotal = ((ketaQuntity * ketaPrice) + (dastaQuntity* dastaPrice) + (kartonaQuntity * kartonaPrice));

                                        itemsController.updateCurrentItem(Provider.of<ItemsController>(context, listen: false).currentItem!.copyWith(itemTotalPrice: itemTotal));

                                      }

                                    },
                                  ),
                                ),
                              ),

                            ),
                            const SizedBox(width: 10,),
                            Column(
                              children: [
                                Consumer<ItemsController>(
                                  builder: (context, itmController, _){
                                    if(itmController.currentItem != null){
                                      return Text(
                                        itmController.currentItem!.itemTotalPrice?.toStringAsFixed(2).toString() ?? '0.0',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18
                                        ),
                                      );
                                    }else{
                                      return const Text(
                                        '0.0',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18
                                        ),
                                      );
                                    }
                                  },
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    if (Provider.of<ItemsController>(context, listen: false).currentItem != null) {
                                      //if(itemAlreadyExists(Provider.of<ItemsController>(context, listen: false).currentItem!.id!) == false){
                                      // // Parse the values from the quantity fields
                                      // final kartona = num.tryParse(_kartonaController.text) ?? 0;
                                      // final dasta = num.tryParse(_dastaController.text) ?? 0;
                                      // final ketaa = num.tryParse(_ketaaController.text) ?? 0;
                                      // final price = num.tryParse(_priceController.text) ?? 0;
                                      //
                                      // // Create item with all quantities and price
                                      // final itemWithDetails = _selectedItem!.copyWith(
                                      //   sellingPrice: price,
                                      //   kartonaQuntity: kartona, // Storing Kartona quantity
                                      //   dastaQuntity: dasta,     // Storing Dasta quantity
                                      //   ketaaQuntity: ketaa,     // Storing Ketaa quantity
                                      // );

                                      // Add to invoice items
                                      itemsController.addItemToInvoice(Provider.of<ItemsController>(context, listen: false).currentItem!);

                                      _kartonaController.text = '0';
                                      _dastaController  .text = '0';
                                      _ketaaController  .text = '0';
                                      _priceController  .text = '0.0';
                                      _itemNameController.text = '';
                                      itemsController.setCurrentItem(null);
                                    }
                                    // else{
                                    //   // showDialog(
                                    //   //   context: context,
                                    //   //   builder: (context){
                                    //   //     return AlertDialog(
                                    //   //       title: const Text('هل تريد تكرار الصنف ف الفاتوره؟'),
                                    //   //       actions: [
                                    //   //         ElevatedButton(
                                    //   //           onPressed: (){
                                    //   //             // Parse the values from the quantity fields
                                    //   //             final kartona = num.tryParse(_kartonaController.text) ?? 0;
                                    //   //             final dasta = num.tryParse(_dastaController.text) ?? 0;
                                    //   //             final ketaa = num.tryParse(_ketaaController.text) ?? 0;
                                    //   //             final price = num.tryParse(_priceController.text) ?? 0;
                                    //   //
                                    //   //             // Create item with all quantities and price
                                    //   //             final itemWithDetails = _selectedItem!.copyWith(
                                    //   //               sellingPrice: price,
                                    //   //               kartonaQuntity: kartona, // Storing Kartona quantity
                                    //   //               dastaQuntity: dasta,     // Storing Dasta quantity
                                    //   //               ketaaQuntity: ketaa,     // Storing Ketaa quantity
                                    //   //               // itemTotalPrice: _calculateInvoiceTotal()
                                    //   //             );
                                    //   //
                                    //   //             // Add to invoice items
                                    //   //             itemsController.addItemToInvoice(itemWithDetails);
                                    //   //
                                    //   //             _kartonaController.clear();
                                    //   //             _dastaController.clear();
                                    //   //             _ketaaController.clear();
                                    //   //           },
                                    //   //           child: const Text('نعم'),
                                    //   //         ),
                                    //   //         TextButton(
                                    //   //             onPressed: (){
                                    //   //               Navigator.pop(context);
                                    //   //             },
                                    //   //             child: const Text('لا')),
                                    //   //       ],
                                    //   //     );
                                    //   //   },
                                    //   // );
                                    // }
                                    //}
                                  },
                                  child: const Text('اضافه'),
                                ),
                              ],
                            ),
                          ],
                        )],
                      if(Platform.isAndroid)
                        ...[
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _kartonaController,
                                  keyboardType: TextInputType.number,
                                  decoration:  InputDecoration(
                                    enabledBorder:  const OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                    ),
                                    focusedBorder:  const OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.purple),
                                    ),
                                    labelText: 'كرتونه = ${itemsController.currentItem?.kartona.toString()} دسته',
                                    floatingLabelBehavior: FloatingLabelBehavior.always,
                                    hintStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  onChanged: (newValue){
                                    if(newValue.isEmpty){
                                      _kartonaController.text = '0';
                                      final updatedItem = Provider.of<ItemsController>(context, listen: false).currentItem!.copyWith(
                                        kartonaQuntity: num.tryParse(_kartonaController.text),
                                      );
                                      itemsController.updateCurrentItem(updatedItem);
                                      ///TODO : calc item total price
                                      double dastaPrice;
                                      double kartonaPrice;
                                      double ketaPrice;

                                      int dastaQuntity;
                                      int kartonaQuntity;
                                      int ketaQuntity;

                                      int numOfDastaInKartona;
                                      int numOfKetaaInDasta;

                                      dastaPrice = Provider.of<ItemsController>(context, listen: false).currentItem?.sellingPrice?.toDouble() ?? 0.0;
                                      ketaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.ketaaQuntity?.toInt() ?? 0;

                                      ketaPrice = dastaPrice / (Provider.of<ItemsController>(context, listen: false).currentItem?.dasta ?? 1);
                                      ketaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.ketaaQuntity?.toInt() ?? 0;

                                      numOfKetaaInDasta = Provider.of<ItemsController>(context, listen: false).currentItem?.dasta?.toInt() ?? 12;
                                      numOfDastaInKartona = Provider.of<ItemsController>(context, listen: false).currentItem?.kartona?.toInt() ?? 12;

                                      kartonaPrice = numOfDastaInKartona * dastaPrice;
                                      ketaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.ketaaQuntity?.toInt() ?? 0;
                                      dastaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.dastaQuntity?.toInt() ?? 0;

                                      double itemTotal = ((ketaQuntity * ketaPrice) + ((dastaQuntity)* dastaPrice) + ((int.tryParse(_kartonaController.text) ?? 1) * kartonaPrice));

                                      itemsController.updateCurrentItem(Provider.of<ItemsController>(context, listen: false).currentItem!.copyWith(itemTotalPrice: itemTotal));
                                    }
                                    else{
                                      final updatedItem = Provider.of<ItemsController>(context, listen: false).currentItem!.copyWith(
                                        kartonaQuntity: num.tryParse(_kartonaController.text),
                                      );
                                      itemsController.updateCurrentItem(updatedItem);
                                      ///TODO : calc item total price
                                      double dastaPrice;
                                      double kartonaPrice;
                                      double ketaPrice;

                                      int dastaQuntity;
                                      int kartonaQuntity;
                                      int ketaQuntity;

                                      int numOfDastaInKartona;
                                      int numOfKetaaInDasta;

                                      dastaPrice = Provider.of<ItemsController>(context, listen: false).currentItem?.sellingPrice?.toDouble() ?? 0.0;
                                      ketaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.ketaaQuntity?.toInt() ?? 0;

                                      ketaPrice = dastaPrice / (Provider.of<ItemsController>(context, listen: false).currentItem?.dasta ?? 1);
                                      ketaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.ketaaQuntity?.toInt() ?? 0;

                                      numOfKetaaInDasta = Provider.of<ItemsController>(context, listen: false).currentItem?.dasta?.toInt() ?? 12;
                                      numOfDastaInKartona = Provider.of<ItemsController>(context, listen: false).currentItem?.kartona?.toInt() ?? 12;

                                      kartonaPrice = numOfDastaInKartona * dastaPrice;
                                      ketaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.ketaaQuntity?.toInt() ?? 0;
                                      dastaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.dastaQuntity?.toInt() ?? 0;

                                      double itemTotal = ((ketaQuntity * ketaPrice) + ((dastaQuntity)* dastaPrice) + ((int.tryParse(_kartonaController.text) ?? 1) * kartonaPrice));

                                      itemsController.updateCurrentItem(Provider.of<ItemsController>(context, listen: false).currentItem!.copyWith(itemTotalPrice: itemTotal));
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(width: 8), // Spacing between fields
                              Expanded(
                                child: TextField(
                                  controller: _dastaController,
                                  keyboardType: TextInputType.number,
                                  decoration:  InputDecoration(
                                    enabledBorder:  const OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                    ),
                                    focusedBorder:  const OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.purple),
                                    ),
                                    labelText: 'دسته = ${itemsController.currentItem?.dasta.toString()} قطعه',
                                    //hintText: 'كرتونه = ${_selectedItem?.kartona.toString()} دسته',
                                    floatingLabelBehavior: FloatingLabelBehavior.always,
                                    hintStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      //fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  onChanged: (newValue){
                                    if(newValue.isEmpty){
                                      _dastaController.text = '0';
                                      final updatedItem = Provider.of<ItemsController>(context, listen: false).currentItem!.copyWith(
                                        dastaQuntity: num.tryParse(_dastaController.text),
                                      );
                                      // Update the item in the invoice list
                                      itemsController.updateCurrentItem(updatedItem);

                                      ///TODO : calc item total price
                                      double dastaPrice;
                                      double kartonaPrice;
                                      double ketaPrice;

                                      int dastaQuntity;
                                      int kartonaQuntity;
                                      int ketaQuntity;

                                      int numOfDastaInKartona;
                                      int numOfKetaaInDasta;

                                      dastaPrice = Provider.of<ItemsController>(context, listen: false).currentItem?.sellingPrice?.toDouble() ?? 0.0;
                                      ketaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.ketaaQuntity?.toInt() ?? 0;

                                      ketaPrice = dastaPrice / (Provider.of<ItemsController>(context, listen: false).currentItem?.dasta ?? 1);
                                      ketaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.ketaaQuntity?.toInt() ?? 0;

                                      numOfKetaaInDasta = Provider.of<ItemsController>(context, listen: false).currentItem?.dasta?.toInt() ?? 12;

                                      kartonaPrice = numOfKetaaInDasta * dastaPrice;
                                      ketaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.ketaaQuntity?.toInt() ?? 0;
                                      dastaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.dastaQuntity?.toInt() ?? 0;
                                      kartonaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.kartonaQuntity?.toInt() ?? 0;

                                      double itemTotal = ((ketaQuntity * ketaPrice) + (((int.tryParse(_dastaController.text) ?? 1))* dastaPrice) + (kartonaQuntity * kartonaPrice));

                                      itemsController.updateCurrentItem(Provider.of<ItemsController>(context, listen: false).currentItem!.copyWith(itemTotalPrice: itemTotal));
                                    }
                                    else{
                                      final updatedItem = Provider.of<ItemsController>(context, listen: false).currentItem!.copyWith(
                                        dastaQuntity: num.tryParse(_dastaController.text),
                                      );
                                      // Update the item in the invoice list
                                      itemsController.updateCurrentItem(updatedItem);

                                      ///TODO : calc item total price
                                      double dastaPrice;
                                      double kartonaPrice;
                                      double ketaPrice;

                                      int dastaQuntity;
                                      int kartonaQuntity;
                                      int ketaQuntity;

                                      int numOfDastaInKartona;
                                      int numOfKetaaInDasta;

                                      dastaPrice = Provider.of<ItemsController>(context, listen: false).currentItem?.sellingPrice?.toDouble() ?? 0.0;
                                      ketaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.ketaaQuntity?.toInt() ?? 0;

                                      ketaPrice = dastaPrice / (Provider.of<ItemsController>(context, listen: false).currentItem?.dasta ?? 1);
                                      ketaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.ketaaQuntity?.toInt() ?? 0;

                                      numOfKetaaInDasta = Provider.of<ItemsController>(context, listen: false).currentItem?.dasta?.toInt() ?? 12;

                                      kartonaPrice = numOfKetaaInDasta * dastaPrice;
                                      ketaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.ketaaQuntity?.toInt() ?? 0;
                                      dastaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.dastaQuntity?.toInt() ?? 0;
                                      kartonaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.kartonaQuntity?.toInt() ?? 0;

                                      double itemTotal = ((ketaQuntity * ketaPrice) + (((int.tryParse(_dastaController.text) ?? 1))* dastaPrice) + (kartonaQuntity * kartonaPrice));

                                      itemsController.updateCurrentItem(Provider.of<ItemsController>(context, listen: false).currentItem!.copyWith(itemTotalPrice: itemTotal));

                                    }
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                              Consumer<ItemsController>(
                                builder: (context, itmController, _){
                                  if(itmController.currentItem != null){
                                    return Text(
                                      itmController.currentItem!.itemTotalPrice?.toStringAsFixed(2).toString() ?? '0.0',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18
                                      ),
                                    );
                                  }else{
                                    return const Text(
                                      '0.0',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18
                                      ),
                                    );
                                  }
                                },
                              ),// Spacing between fields
                            ],
                          ),
                          const SizedBox(height: 4,),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _ketaaController,
                                  keyboardType: TextInputType.number,
                                  decoration:  const InputDecoration(
                                    enabledBorder:  OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                    ),
                                    focusedBorder:  OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.purple),
                                    ),
                                    labelText: 'قطعه',
                                    //hintText: 'كرتونه = ${_selectedItem?.kartona.toString()} دسته',
                                    floatingLabelBehavior: FloatingLabelBehavior.always,
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      //fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  onChanged: (newValue){
                                    if(newValue.isEmpty){
                                      _ketaaController.text = '0';
                                      final updatedItem = Provider.of<ItemsController>(context, listen: false).currentItem!.copyWith(
                                        ketaaQuntity: num.tryParse(_ketaaController.text),
                                      );
                                      // Update the item in the invoice list
                                      itemsController.updateCurrentItem(updatedItem);

                                      ///TODO : calc item total price
                                      double dastaPrice;
                                      double kartonaPrice;
                                      double ketaPrice;

                                      int dastaQuntity;
                                      int kartonaQuntity;
                                      int ketaQuntity;

                                      int numOfDastaInKartona;
                                      int numOfKetaaInDasta;

                                      dastaPrice = Provider.of<ItemsController>(context, listen: false).currentItem?.sellingPrice?.toDouble() ?? 0.0;
                                      ketaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.ketaaQuntity?.toInt() ?? 0;

                                      ketaPrice = dastaPrice / (Provider.of<ItemsController>(context, listen: false).currentItem?.dasta ?? 1);
                                      ketaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.ketaaQuntity?.toInt() ?? 0;

                                      numOfKetaaInDasta = Provider.of<ItemsController>(context, listen: false).currentItem?.dasta?.toInt() ?? 12;

                                      kartonaPrice = numOfKetaaInDasta * dastaPrice;
                                      ketaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.ketaaQuntity?.toInt() ?? 0;
                                      dastaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.dastaQuntity?.toInt() ?? 0;
                                      kartonaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.kartonaQuntity?.toInt() ?? 0;

                                      double itemTotal = ((((int.tryParse(_ketaaController.text) ?? 1)) * ketaPrice) + (dastaQuntity* dastaPrice) + (kartonaQuntity * kartonaPrice));

                                      itemsController.updateCurrentItem(Provider.of<ItemsController>(context, listen: false).currentItem!.copyWith(itemTotalPrice: itemTotal));
                                    }
                                    else{
                                      final updatedItem = Provider.of<ItemsController>(context, listen: false).currentItem!.copyWith(
                                        ketaaQuntity: num.tryParse(_ketaaController.text),
                                      );
                                      // Update the item in the invoice list
                                      itemsController.updateCurrentItem(updatedItem);

                                      ///TODO : calc item total price
                                      double dastaPrice;
                                      double kartonaPrice;
                                      double ketaPrice;

                                      int dastaQuntity;
                                      int kartonaQuntity;
                                      int ketaQuntity;

                                      int numOfDastaInKartona;
                                      int numOfKetaaInDasta;

                                      dastaPrice = Provider.of<ItemsController>(context, listen: false).currentItem?.sellingPrice?.toDouble() ?? 0.0;
                                      ketaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.ketaaQuntity?.toInt() ?? 0;

                                      ketaPrice = dastaPrice / (Provider.of<ItemsController>(context, listen: false).currentItem?.dasta ?? 1);
                                      ketaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.ketaaQuntity?.toInt() ?? 0;

                                      numOfKetaaInDasta = Provider.of<ItemsController>(context, listen: false).currentItem?.dasta?.toInt() ?? 12;

                                      kartonaPrice = numOfKetaaInDasta * dastaPrice;
                                      ketaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.ketaaQuntity?.toInt() ?? 0;
                                      dastaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.dastaQuntity?.toInt() ?? 0;
                                      kartonaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.kartonaQuntity?.toInt() ?? 0;

                                      double itemTotal = ((((int.tryParse(_ketaaController.text) ?? 1)) * ketaPrice) + (dastaQuntity* dastaPrice) + (kartonaQuntity * kartonaPrice));

                                      itemsController.updateCurrentItem(Provider.of<ItemsController>(context, listen: false).currentItem!.copyWith(itemTotalPrice: itemTotal));
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Container(
                                  height: 58,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Tooltip(
                                    message: '${Provider.of<ItemsController>(context, listen: false).currentItem?.purchasingPrice.toString()}',
                                    child: TextField(
                                      controller: _priceController,
                                      keyboardType: TextInputType.number,
                                      decoration:  const InputDecoration(
                                        enabledBorder:   OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.black),
                                        ),
                                        focusedBorder:   OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.purple),
                                        ),
                                        labelText:  'سعر الدسته',
                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                        hintStyle:  TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          //fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      onChanged: (newValue){
                                        if(newValue.isEmpty){
                                          _priceController.text = '0';
                                          final updatedItem = Provider.of<ItemsController>(context, listen: false).currentItem!.copyWith(
                                            sellingPrice: num.tryParse(_priceController.text),
                                          );
                                          // Update the item in the invoice list
                                          itemsController.updateCurrentItem(updatedItem);
                                          ///TODO : calc item total price
                                          double dastaPrice;
                                          double kartonaPrice;
                                          double ketaPrice;

                                          int dastaQuntity;
                                          int kartonaQuntity;
                                          int ketaQuntity;

                                          int numOfDastaInKartona;
                                          int numOfKetaaInDasta;

                                          dastaPrice = Provider.of<ItemsController>(context, listen: false).currentItem?.sellingPrice?.toDouble() ?? 0.0;
                                          ketaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.ketaaQuntity?.toInt() ?? 0;

                                          ketaPrice = dastaPrice / (Provider.of<ItemsController>(context, listen: false).currentItem?.dasta ?? 1);
                                          ketaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.ketaaQuntity?.toInt() ?? 0;

                                          numOfKetaaInDasta = Provider.of<ItemsController>(context, listen: false).currentItem?.dasta?.toInt() ?? 12;

                                          kartonaPrice = numOfKetaaInDasta * dastaPrice;
                                          ketaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.ketaaQuntity?.toInt() ?? 0;
                                          dastaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.dastaQuntity?.toInt() ?? 0;
                                          kartonaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.kartonaQuntity?.toInt() ?? 0;

                                          double itemTotal = ((ketaQuntity * ketaPrice) + (dastaQuntity* dastaPrice) + (kartonaQuntity * kartonaPrice));

                                          itemsController.updateCurrentItem(Provider.of<ItemsController>(context, listen: false).currentItem!.copyWith(itemTotalPrice: itemTotal));

                                        }else{
                                          final updatedItem = Provider.of<ItemsController>(context, listen: false).currentItem!.copyWith(
                                            sellingPrice: num.tryParse(_priceController.text),
                                          );
                                          // Update the item in the invoice list
                                          itemsController.updateCurrentItem(updatedItem);
                                          ///TODO : calc item total price
                                          double dastaPrice;
                                          double kartonaPrice;
                                          double ketaPrice;

                                          int dastaQuntity;
                                          int kartonaQuntity;
                                          int ketaQuntity;

                                          int numOfDastaInKartona;
                                          int numOfKetaaInDasta;

                                          dastaPrice = Provider.of<ItemsController>(context, listen: false).currentItem?.sellingPrice?.toDouble() ?? 0.0;
                                          ketaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.ketaaQuntity?.toInt() ?? 0;

                                          ketaPrice = dastaPrice / (Provider.of<ItemsController>(context, listen: false).currentItem?.dasta ?? 1);
                                          ketaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.ketaaQuntity?.toInt() ?? 0;

                                          numOfKetaaInDasta = Provider.of<ItemsController>(context, listen: false).currentItem?.dasta?.toInt() ?? 12;

                                          kartonaPrice = numOfKetaaInDasta * dastaPrice;
                                          ketaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.ketaaQuntity?.toInt() ?? 0;
                                          dastaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.dastaQuntity?.toInt() ?? 0;
                                          kartonaQuntity = Provider.of<ItemsController>(context, listen: false).currentItem?.kartonaQuntity?.toInt() ?? 0;

                                          double itemTotal = ((ketaQuntity * ketaPrice) + (dastaQuntity* dastaPrice) + (kartonaQuntity * kartonaPrice));

                                          itemsController.updateCurrentItem(Provider.of<ItemsController>(context, listen: false).currentItem!.copyWith(itemTotalPrice: itemTotal));

                                        }

                                      },
                                    ),
                                  ),
                                ),

                              ),
                              const SizedBox(width: 10,),
                              IconButton(
                                onPressed: () {
                                  if (Provider.of<ItemsController>(context, listen: false).currentItem != null) {
                                    //if(itemAlreadyExists(Provider.of<ItemsController>(context, listen: false).currentItem!.id!) == false){
                                    // // Parse the values from the quantity fields
                                    // final kartona = num.tryParse(_kartonaController.text) ?? 0;
                                    // final dasta = num.tryParse(_dastaController.text) ?? 0;
                                    // final ketaa = num.tryParse(_ketaaController.text) ?? 0;
                                    // final price = num.tryParse(_priceController.text) ?? 0;
                                    //
                                    // // Create item with all quantities and price
                                    // final itemWithDetails = _selectedItem!.copyWith(
                                    //   sellingPrice: price,
                                    //   kartonaQuntity: kartona, // Storing Kartona quantity
                                    //   dastaQuntity: dasta,     // Storing Dasta quantity
                                    //   ketaaQuntity: ketaa,     // Storing Ketaa quantity
                                    // );

                                    // Add to invoice items
                                    itemsController.addItemToInvoice(Provider.of<ItemsController>(context, listen: false).currentItem!);

                                    _kartonaController.text = '0';
                                    _dastaController  .text = '0';
                                    _ketaaController  .text = '0';
                                    _priceController  .text = '0.0';
                                    _itemNameController.text = '';
                                    itemsController.setCurrentItem(null);
                                  }
                                  // else{
                                  //   // showDialog(
                                  //   //   context: context,
                                  //   //   builder: (context){
                                  //   //     return AlertDialog(
                                  //   //       title: const Text('هل تريد تكرار الصنف ف الفاتوره؟'),
                                  //   //       actions: [
                                  //   //         ElevatedButton(
                                  //   //           onPressed: (){
                                  //   //             // Parse the values from the quantity fields
                                  //   //             final kartona = num.tryParse(_kartonaController.text) ?? 0;
                                  //   //             final dasta = num.tryParse(_dastaController.text) ?? 0;
                                  //   //             final ketaa = num.tryParse(_ketaaController.text) ?? 0;
                                  //   //             final price = num.tryParse(_priceController.text) ?? 0;
                                  //   //
                                  //   //             // Create item with all quantities and price
                                  //   //             final itemWithDetails = _selectedItem!.copyWith(
                                  //   //               sellingPrice: price,
                                  //   //               kartonaQuntity: kartona, // Storing Kartona quantity
                                  //   //               dastaQuntity: dasta,     // Storing Dasta quantity
                                  //   //               ketaaQuntity: ketaa,     // Storing Ketaa quantity
                                  //   //               // itemTotalPrice: _calculateInvoiceTotal()
                                  //   //             );
                                  //   //
                                  //   //             // Add to invoice items
                                  //   //             itemsController.addItemToInvoice(itemWithDetails);
                                  //   //
                                  //   //             _kartonaController.clear();
                                  //   //             _dastaController.clear();
                                  //   //             _ketaaController.clear();
                                  //   //           },
                                  //   //           child: const Text('نعم'),
                                  //   //         ),
                                  //   //         TextButton(
                                  //   //             onPressed: (){
                                  //   //               Navigator.pop(context);
                                  //   //             },
                                  //   //             child: const Text('لا')),
                                  //   //       ],
                                  //   //     );
                                  //   //   },
                                  //   // );
                                  // }
                                  //}
                                },
                                icon: const Icon(Icons.add_box),
                              ),
                            ],
                          ),
                        ],
                      Text('الرصيد ${itemsController.currentItem?.balanceKartona.toString()} كرتونه ${itemsController.currentItem?.balanceDasta.toString()} دسته${itemsController.currentItem?.balanceKetaa.toString()} قطعه'),
                    ],
                  ),
                ),
              ),
              const Divider(),
              Flexible(
                child: Consumer<ItemsController>(
                  builder: (context, controller, child) {
                    final invoiceItems = controller.invoiceItems;
                    return ListView.separated(
                      itemCount: invoiceItems.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (context, index) {
                        final item = invoiceItems[index];
                        return InvoiceItemTile(item: item,);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: (Platform.isAndroid || Platform.isIOS) ? BottomAppBar(
          child: Row(
            children: [
              CircleAvatar(
                  child: Text(Provider.of<ItemsController>(context, listen: false).invoiceItems.length.toString())),
              Consumer<ItemsController>(
                builder: (context, itemsController, child) {
                  return Text(
                    itemsController.invoiceTotal.toStringAsFixed(2),
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  );
                },
              ),
              Flexible(
                child: TextFormField(
                  controller: paidController,
                  keyboardType: TextInputType.number,
                  decoration:  const InputDecoration(
                    enabledBorder:   OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder:   OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple),
                    ),
                    labelText:  'المدفوع',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintStyle:  TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  onChanged: (newValue){
                    remainedController.text = (Provider.of<ItemsController>(context, listen: false).invoiceTotal - (double.tryParse(paidController.text) ?? 0.0)).toString();
                  },
                ),
              ),
              Flexible(
                child: TextFormField(
                  controller: remainedController,
                  keyboardType: TextInputType.number,
                  decoration:  const InputDecoration(
                    enabledBorder:   OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder:   OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple),
                    ),
                    labelText:  'المتبقي',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintStyle:  TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.image,size: 18,),
                onPressed: () {
                  setState(() async{
                    images = await pickAndConvertImages(ImageSource.gallery);
                  });
                  Navigator.of(context).pop();
                },
              ),
              if (Platform.isAndroid || Platform.isIOS)
                IconButton(
                  icon: const Icon(Icons.camera_alt, size: 18,),
                  onPressed: () {
                    setState(() async{
                      images = await pickAndConvertImages(ImageSource.camera);
                    });
                    Navigator.of(context).pop();
                  },
                )
              else const SizedBox(),
              Consumer<AddNewSupplierInvoiceController>(
                builder: (context, addNewSupplierInvoiceController,_){
                  final loginController = Provider.of<LoginUserController>(context, listen: false);
                  return IconButton(
                    onPressed: addNewSupplierInvoiceController.addNewSupplierInvoiceIsLoading ? null : ()async{
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      SharedPreferencesHelper sharedPreferencesHelper = SharedPreferencesHelper(prefs);
                      Map? token = await sharedPreferencesHelper.getToken();
                      final userId = loginController.loginUserResult?.id ?? int.tryParse(token?['token'] ?? '0');
                      // AddNewSupplierInvoiceParameters invData = AddNewSupplierInvoiceParameters(
                      // invDate: currentDate.toString(),
                      // invSupplierId: int.tryParse(supplierIdController.text),
                      // userId: userId,
                      // type: 'to client',
                      // total: double.tryParse(totalController.text),
                      // payedAmount: double.tryParse(paidController.text),
                      // remainedAmount: double.tryParse(remainedController.text),
                      // invoiceImageUrl: '',
                      // invoiceItems: Provider.of<ItemsController>(context, listen: false).invoiceItems.map((e) => InvoiceItemEntity(
                      // itemId: int.tryParse(e.id.toString()),
                      // itemPrice: double.tryParse(e.itemTotalPrice.toString()),
                      // kartona: int.tryParse(e.kartonaQuntity.toString()),
                      // dasta:   int.tryParse(e.dastaQuntity.toString()),
                      // ketaa:   int.tryParse(e.ketaaQuntity.toString()),
                      // type: 'to client',
                      // ),
                      // ).toList(),
                      //
                      // );
                      // print(invData);
                      Map<String, dynamic> invData = {
                        "invDate": formattedDate,
                        "invSupplierId": int.tryParse(supplierIdController.text),
                        "total": double.tryParse(itemsController.invoiceTotal.toStringAsFixed(2)),
                        "userId": userId ?? 0,
                        "invoiceImageUrl": "",
                        "type": "from supplier",
                        "payedAmount": double.tryParse(paidController.text),
                        "remainedAmount": double.tryParse(remainedController.text),
                        "invoiceItems": Provider.of<ItemsController>(context, listen: false).invoiceItems.map((e){
                          return {
                            "itemId": e.id,
                            "itemQuantity": 0,
                            "type": "from supplier",
                            "itemPrice": e.sellingPrice,
                            "itemTotal": e.itemTotalPrice,
                            "invSupplierId": int.tryParse(supplierIdController.text),
                            "dasta": e.dastaQuntity,
                            "kartona": e.ketaaQuntity,
                            "ketaa": e.ketaaQuntity,
                          };
                        }).toList(),
                        "images": images
                      };

                      print(invData);
                      await addNewSupplierInvoiceController.addNewSupplierInvoice(invData);
                      if (addNewSupplierInvoiceController.addNewSupplierInvoiceResult != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${addNewSupplierInvoiceController.addNewSupplierInvoiceErrorMessage}created successfully',),
                          ),
                        );
                        print(addNewSupplierInvoiceController.addNewSupplierInvoiceResult);
                        RouteGenerator.navigationReplacementTo(
                          AppRoutes.supplierInvoiceDetailsScreenRoute,
                          arguments: addNewSupplierInvoiceController.addNewSupplierInvoiceResult,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Message : ${addNewSupplierInvoiceController.addNewSupplierInvoiceErrorMessage}')),
                        );
                      }

                    },
                    icon: Consumer<AddNewSupplierInvoiceController>(
                      builder: (context, addNewInvoiceController, _){
                        return addNewInvoiceController.addNewSupplierInvoiceIsLoading
                            ? const CircularProgressIndicator.adaptive()
                            :  const Icon(Icons.send);
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ) : null,
        persistentFooterButtons: Platform.isWindows ? [
          CircleAvatar(
            child: Text(Provider.of<ItemsController>(context, listen: false).invoiceItems.length.toString()),
          ),
          Consumer<ItemsController>(
            builder: (context, itemsController, child) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'الاجمالي: ${itemsController.invoiceTotal.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              );
            },
          ),
          SizedBox(
            width: 120,
            height: 50,
            child: TextFormField(
              controller: paidController,
              keyboardType: TextInputType.number,
              decoration:  const InputDecoration(
                enabledBorder:   OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder:   OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple),
                ),
                labelText:  'المدفوع',
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintStyle:  TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
              onChanged: (newValue){
                remainedController.text = (Provider.of<ItemsController>(context, listen: false).invoiceTotal - (double.tryParse(paidController.text) ?? 0.0)).toString();
              },
            ),
          ),
          SizedBox(
            width: 120,
            height: 50,
            child: TextFormField(
              controller: remainedController,
              keyboardType: TextInputType.number,
              decoration:  const InputDecoration(
                enabledBorder:   OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder:   OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple),
                ),
                labelText:  'المتبقي',
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintStyle:  TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
          ElevatedButton(
            child: const Text('معرض الصور'),
            onPressed: () {
              setState(() async{
                images = await pickAndConvertImages(ImageSource.gallery);
              });
              Navigator.of(context).pop();
            },
          ),
          if (Platform.isAndroid || Platform.isIOS)
            ElevatedButton(
              child: const Text('الكاميرا'),
              onPressed: () {
                setState(() async{
                  images = await pickAndConvertImages(ImageSource.camera);
                });
                Navigator.of(context).pop();
              },
            )
          else const SizedBox(),
          Consumer<AddNewSupplierInvoiceController>(
            builder: (context, addNewSupplierInvoiceController,_){
              final loginController = Provider.of<LoginUserController>(context, listen: false);
              return ElevatedButton(
                onPressed: addNewSupplierInvoiceController.addNewSupplierInvoiceIsLoading ? null : ()async{
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  SharedPreferencesHelper sharedPreferencesHelper = SharedPreferencesHelper(prefs);
                  Map? token = await sharedPreferencesHelper.getToken();
                  final userId = loginController.loginUserResult?.id ?? int.tryParse(token?['token'] ?? '0');
                  // AddNewSupplierInvoiceParameters invData = AddNewSupplierInvoiceParameters(
                  // invDate: currentDate.toString(),
                  // invSupplierId: int.tryParse(supplierIdController.text),
                  // userId: userId,
                  // type: 'to client',
                  // total: double.tryParse(totalController.text),
                  // payedAmount: double.tryParse(paidController.text),
                  // remainedAmount: double.tryParse(remainedController.text),
                  // invoiceImageUrl: '',
                  // invoiceItems: Provider.of<ItemsController>(context, listen: false).invoiceItems.map((e) => InvoiceItemEntity(
                  // itemId: int.tryParse(e.id.toString()),
                  // itemPrice: double.tryParse(e.itemTotalPrice.toString()),
                  // kartona: int.tryParse(e.kartonaQuntity.toString()),
                  // dasta:   int.tryParse(e.dastaQuntity.toString()),
                  // ketaa:   int.tryParse(e.ketaaQuntity.toString()),
                  // type: 'to client',
                  // ),
                  // ).toList(),
                  //
                  // );
                  // print(invData);

                  Map<String, dynamic> invData = {
                    "invDate": formattedDate,
                    "invSupplierId": int.tryParse(supplierIdController.text),
                    "total": double.tryParse(itemsController.invoiceTotal.toStringAsFixed(2)),
                    "userId": userId ?? 0,
                    "invoiceImageUrl": "",
                    "type": "from supplier",
                    "payedAmount": double.tryParse(paidController.text),
                    "remainedAmount": double.tryParse(remainedController.text),
                    "invoiceItems": Provider.of<ItemsController>(context, listen: false).invoiceItems.map((e){
                      return {
                        "itemId": e.id,
                        "itemQuantity": 0,
                        "type": "from supplier",
                        "itemPrice": e.sellingPrice,
                        "itemTotal": e.itemTotalPrice,
                        "invSupplierId": int.tryParse(supplierIdController.text),
                        "dasta": e.dastaQuntity,
                        "kartona": e.ketaaQuntity,
                        "ketaa": e.ketaaQuntity,
                      };
                    }).toList(),
                    "images": images
                  };

                  print(invData);
                  addNewSupplierInvoiceController.addNewSupplierInvoice(invData);
                  if (addNewSupplierInvoiceController.addNewSupplierInvoiceResult != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${addNewSupplierInvoiceController.addNewSupplierInvoiceErrorMessage}created successfully',),
                      ),
                    );
                    RouteGenerator.navigationReplacementTo(
                      AppRoutes.supplierInvoiceDetailsScreenRoute,
                      arguments: addNewSupplierInvoiceController.addNewSupplierInvoiceResult,
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Message : ${addNewSupplierInvoiceController.addNewSupplierInvoiceErrorMessage}')),
                    );
                  }

                },
                child: Consumer<AddNewSupplierInvoiceController>(
                  builder: (context, addNewInvoiceController, _){
                    return addNewInvoiceController.addNewSupplierInvoiceIsLoading
                        ? const CircularProgressIndicator.adaptive() :  const Text(StringManager.add);
                  },
                ),
              );
            },
          ),
        ] : null,
      ),
    );
  }

}




class InvoiceItemTile extends StatefulWidget {
  final ItemEntity item;
  const InvoiceItemTile({Key? key, required this.item}) : super(key: key);

  @override
  State<InvoiceItemTile> createState() => _InvoiceItemTileState();
}

class _InvoiceItemTileState extends State<InvoiceItemTile> {
  @override
  Widget build(BuildContext context) {
    final itemsController = Provider.of<ItemsController>(context, listen: false);
    final qntBuffer = StringBuffer();
    (widget.item.kartonaQuntity != null && widget.item.kartonaQuntity != 0) ? qntBuffer.write(' ${widget.item.kartonaQuntity}ك ') : null;
    (widget.item.dastaQuntity != null && widget.item.dastaQuntity != 0) ? qntBuffer.write(' ${widget.item.dastaQuntity}د ') : null;
    (widget.item.ketaaQuntity != null && widget.item.ketaaQuntity != 0) ? qntBuffer.write(' ${widget.item.ketaaQuntity}ق ') : null;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      minVerticalPadding: 0.0,
      leading: CachedNetworkImage(
        width: 50,
        height: 50,
        imageUrl: (widget.item.images != null && widget.item.images!.isNotEmpty)
            ? widget.item.images!.first!
            : 'https://placehold.co/400', // Placeholder URL
        placeholder: (context, url) {
          if (widget.item.images != null && widget.item.images!.isNotEmpty) {
            print(widget.item.images!.first.toString());
          } else {
            print("No image available");
          }
          return const CircularProgressIndicator();
        },
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
      title: Text(widget.item.name ?? 'Unknown Item'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('سعر البيع: ${widget.item.sellingPrice ?? 'Not available'} للدسته التي تحتوي علي ${widget.item.dasta }قطعه'),
          Text('الكميه ${qntBuffer.toString()}'),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.item.itemTotalPrice?.toStringAsFixed(2).toString() ?? '0.0',
            style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              _showEditItemDialog(context, widget.item, itemsController);
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              itemsController.removeItemFromInvoice(widget.item);
            },
          ),
        ],
      ),
    );
  }

  // Dialog to edit an invoice item
  void _showEditItemDialog(BuildContext context, ItemEntity item, ItemsController itemsController) {
    // Initialize the controllers with the existing item values
    final TextEditingController _kartonaController = TextEditingController(text: item.kartonaQuntity?.toString() ?? '');
    final TextEditingController _dastaController = TextEditingController(text: item.dastaQuntity?.toString() ?? '');
    final TextEditingController _ketaaController = TextEditingController(text: item.ketaaQuntity?.toString() ?? '');
    final TextEditingController _priceController = TextEditingController(text: item.sellingPrice?.toString() ?? '');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('تعديل'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Kartona Field
            TextField(
              controller: _kartonaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'كرتونه'),
            ),
            // Dasta Field
            TextField(
              controller: _dastaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'دسته'),
            ),
            // Ketaa Field
            TextField(
              controller: _ketaaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'قطعه'),
            ),
            // Price Field
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'السعر'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Parse the updated values for kartona, dasta, and ketaa
              final updatedItem = item.copyWith(
                sellingPrice: num.tryParse(_priceController.text),
                kartonaQuntity: num.tryParse(_kartonaController.text),
                dastaQuntity: num.tryParse(_dastaController.text),
                ketaaQuntity: num.tryParse(_ketaaController.text),
              );
              // Update the item in the invoice list
              itemsController.updateInvoiceItem(updatedItem);
              Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }


}


