// import 'dart:io';
// import 'package:cached_memory_image/cached_memory_image.dart';
// import 'package:eltawfiq_suppliers/authentication/presentation/controllers/login_user_controller.dart';
// import 'package:eltawfiq_suppliers/core/resources/size_manager.dart';
// import 'package:eltawfiq_suppliers/core/resources/string_manager.dart';
// import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
// import 'package:eltawfiq_suppliers/suppliers/domain/entities/invoice_item_entity.dart';
// import 'package:eltawfiq_suppliers/suppliers/domain/entities/item_entity.dart';
// import 'package:eltawfiq_suppliers/suppliers/domain/entities/supplier_entity.dart';
// import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/invoice/add_new_supplier_invoice_use_case.dart';
// import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/clients/clients_controller.dart';
// import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/invoice/add_new_supplier_invoice_controller.dart';
// import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/item/items_controller.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import 'package:intl/intl.dart' as intl;
//
// class AddNewClientInvoiceScreen extends StatefulWidget {
//   const AddNewClientInvoiceScreen({super.key});
//
//   @override
//   State<AddNewClientInvoiceScreen> createState() => _AddNewClientInvoiceScreenState();
// }
//
// class _AddNewClientInvoiceScreenState extends State<AddNewClientInvoiceScreen> {
//   final TextEditingController storeNameController = TextEditingController();
//   final TextEditingController storeIdController = TextEditingController();
//
//   final TextEditingController supplierNameController = TextEditingController();
//   final TextEditingController supplierIdController = TextEditingController();
//
//   final TextEditingController factoryCodeController = TextEditingController();
//   final TextEditingController supplierCodeController = TextEditingController();
//
//   final TextEditingController totalController = TextEditingController();
//   final TextEditingController paidController = TextEditingController(text: '0');
//   final TextEditingController remainController = TextEditingController();
//   final TextEditingController remarkController = TextEditingController();
//
//
//   final FocusNode _codeFocusNode = FocusNode();
//   final FocusNode _nameFocusNode = FocusNode();
//   final FocusNode _paidFocusNode = FocusNode();
//   final FocusNode _remainFocusNode = FocusNode();
//   final FocusNode _addPerButtonFocusNode = FocusNode();
//
//
//   List<InvoiceItem> invoiceItems = [];
//   final List<FocusNode> _itemNameFocusNodes = [];
//   final List<FocusNode> _itemCodeFocusNodes = [];
//   final List<FocusNode> _kartonaQuantityFocusNodes = [];
//   final List<FocusNode> _DastaQuantityFocusNodes = [];
//   final List<FocusNode> _KetaaQuantityFocusNodes = [];
//   final List<FocusNode> _priceFocusNodes = [];
//
//   DateTime? currentDate = DateTime.now();
//   String formattedDate = '';
//   @override
//   void initState() {
//     super.initState();
//     formattedDate = intl.DateFormat('yyyy-MM-dd').format(currentDate!);
//     supplierIdController.addListener(_onSupplierCodeChanged);
//     supplierNameController.addListener(_onSupplierNameChanged);
//     paidController.addListener(_updateRemainingAmount);
//     totalController.addListener(_updateRemainingAmount);
//   }
//
//   // void _onItemCodeChanged(int index) {
//   //   final itemsController = Provider.of<ItemsController>(context, listen: false);
//   //   final itemId = invoiceItems[index].itemCodeController.text;
//   //   if (itemId.isNotEmpty) {
//   //     final item = itemsController.gettingItems?.firstWhere(
//   //           (item) => item.id.toString() == itemId,
//   //     );
//   //     if (item != null && item.id != 0) {
//   //       invoiceItems[index].itemNameController.text = item.name?? StringManager.emptyString;
//   //     } else {
//   //       invoiceItems[index].itemNameController.clear(); // Clear name if no store found
//   //     }
//   //   }
//   // }
//   //
//   // void _onItemNameChanged(int index) {
//   //   final itemsController = Provider.of<ItemsController>(context, listen: false);
//   //   final name = invoiceItems[index].itemNameController.text;
//   //   if (name.isNotEmpty) {
//   //     final item = itemsController.gettingItems?.firstWhere(
//   //           (item) => item.name == name,
//   //     );
//   //     if (item != null && item.id != 0) {
//   //       invoiceItems[index].itemCodeController.text = item.id.toString();
//   //     } else {
//   //       invoiceItems[index].itemCodeController.clear(); // Clear code if no store found
//   //     }
//   //   }
//   // }
//
//   void _onItemCodeChanged(int index) {
//     final itemsController = Provider.of<ItemsController>(context, listen: false);
//     final itemId = invoiceItems[index].itemCodeController.text;
//     if (itemId.isNotEmpty) {
//       final item = itemsController.gettingItems?.firstWhere(
//             (item) => item.id.toString() == itemId,
//       );
//       if (item != null && item.id != 0) {
//         setState(() {
//           invoiceItems[index].itemNameController.text = item.name ?? StringManager.emptyString;
//           invoiceItems[index].itemCodeController.text = item.id.toString();
//           invoiceItems[index].itemImage = item.images!.first; // Set item image
//           invoiceItems[index].kartona = item.kartona;
//           invoiceItems[index].dasta = item.dasta;
//           invoiceItems[index].balanceKartona = item.balanceKartona;
//           invoiceItems[index].balanceDasta = item.balanceDasta;
//           invoiceItems[index].balanceKetaa = item.balanceKetaa;
//           invoiceItems[index].itemPriceController.text = item.sellingPrice.toString();
//         });
//       } else {
//         setState(() {
//           invoiceItems[index].itemNameController.clear();
//           invoiceItems[index].itemImage = null; // Clear image if no item found
//           invoiceItems[index].kartona = null;
//           invoiceItems[index].dasta = null;
//           invoiceItems[index].balanceKartona = null;
//           invoiceItems[index].balanceDasta = null;
//           invoiceItems[index].balanceKetaa = null;
//           invoiceItems[index].itemPriceController.text = '';
//         });
//       }
//     }
//   }
//
//   void _onItemNameChanged(int index) {
//     final itemsController = Provider.of<ItemsController>(context, listen: false);
//     final name = invoiceItems[index].itemNameController.text;
//     if (name.isNotEmpty) {
//       final item = itemsController.gettingItems?.firstWhere(
//             (item) => item.name == name,
//       );
//       if (item != null && item.id != 0) {
//         setState(() {
//           invoiceItems[index].itemCodeController.text = item.id.toString();
//           invoiceItems[index].itemNameController.text = item.name.toString();
//           invoiceItems[index].itemImage = item.images!.first; // Set item image
//           invoiceItems[index].balanceKartona = item.kartona;
//           invoiceItems[index].balanceKartona = item.dasta;
//           invoiceItems[index].balanceKartona = item.balanceKartona;
//           invoiceItems[index].balanceDasta = item.balanceDasta;
//           invoiceItems[index].balanceKetaa = item.balanceKetaa;
//           invoiceItems[index].itemPriceController.text = item.sellingPrice.toString();
//         });
//       } else {
//         setState(() {
//           invoiceItems[index].itemCodeController.clear();
//           invoiceItems[index].itemImage = null; // Clear image if no item found
//           invoiceItems[index].kartona = null;
//           invoiceItems[index].dasta = null;
//           invoiceItems[index].balanceKartona = null;
//           invoiceItems[index].balanceDasta = null;
//           invoiceItems[index].balanceKetaa = null;
//           invoiceItems[index].itemPriceController.text = '';
//         });
//       }
//     }
//   }
//
//
//   void _onSupplierCodeChanged() {
//     final supplierController = Provider.of<ClientsController>(context, listen: false);
//     final code = supplierIdController.text;
//     if (code.isNotEmpty) {
//       final supplier = supplierController.gettingClients?.firstWhere(
//             (supplier) => supplier.id.toString() == code,
//       );
//       if (supplier != null) {
//         supplierNameController.text = supplier.supplierName ?? StringManager.emptyString;
//       } else {
//         supplierNameController.clear(); // Clear name if no supplier found
//       }
//     }
//   }
//
//   void _onSupplierNameChanged() {
//     final supplierController = Provider.of<ClientsController>(context, listen: false);
//     final name = supplierNameController.text;
//     if (name.isNotEmpty) {
//       final  supplier = supplierController.gettingClients?.firstWhere(
//             (supplier) => supplier.supplierName == name,
//       );
//       if (supplier != null) {
//         supplierIdController.text = supplier.id.toString();
//       } else {
//         supplierIdController.clear(); // Clear code if no supplier found
//       }
//     }
//   }
//
//
//   double _calculateInvoiceTotal() {
//     double total = 0.0;
//     for (var item in invoiceItems) {
//       double price = double.tryParse(item.itemPriceController.text) ?? 0.0;
//       double quantity = double.tryParse(item.itemKartonaQuantityController.text) ?? 0.0;
//       total += price * quantity;
//     }
//     totalController.text = total.toStringAsFixed(2);
//     _updateRemainingAmount();
//     return total;
//   }

//   void _updateRemainingAmount() {
//     double total = double.tryParse(totalController.text) ?? 0.0;
//     double paid = double.tryParse(paidController.text) ?? 0.0;
//     double remain = total - paid;
//     remainController.text = remain.toInt().toString();
//   }
//
//
//   String _calculateTotal(String price, String quantity) {
//     try {
//       final double itemPrice = double.parse(price);
//       final double itemQuantity = double.parse(quantity);
//       final double total = itemPrice * itemQuantity;
//       return total.toStringAsFixed(2);
//     } catch (e) {
//       return '0.00';
//     }
//   }
//
//
//   File? image;
//
//   Future pickImage() async {
//     try {
//       final image = await ImagePicker().pickImage(source: ImageSource.gallery);
//       if (image == null) return;
//       final imageTemp = File(image.path);
//       setState(() => this.image = imageTemp);
//     } on PlatformException catch (e) {
//       if (kDebugMode) {
//         print('Failed to pick image: $e');
//       }
//     }
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       ///TODO :
//       ///get Supplier / client hot items
//       Provider.of<ClientsController>(context, listen: false).getClients(const NoParameters());
//       Provider.of<ItemsController>(context, listen: false).getItems(const NoParameters());
//     });
//   }
//
//   void _addNewItem() {
//     setState(() {
//       final itemCodeFocusNode = FocusNode();
//       final itemNameFocusNode = FocusNode();
//       final quantityFocusNode = FocusNode();
//       final dastaQuantityFocusNode = FocusNode();
//       final ketaaQuantityFocusNode = FocusNode();
//       final priceFocusNode = FocusNode();
//
//       _itemCodeFocusNodes.add(itemNameFocusNode);
//       _itemNameFocusNodes.add(itemCodeFocusNode);
//       _itemNameFocusNodes.add(itemNameFocusNode);
//       _kartonaQuantityFocusNodes.add(quantityFocusNode);
//       _DastaQuantityFocusNodes.add(dastaQuantityFocusNode);
//       _KetaaQuantityFocusNodes.add(ketaaQuantityFocusNode);
//       _priceFocusNodes.add(priceFocusNode);
//
//       invoiceItems.add(
//           InvoiceItem(
//             itemCodeController: TextEditingController(),
//             itemNameController: TextEditingController(),
//             itemPriceController: TextEditingController(),
//             itemKartonaQuantityController: TextEditingController(),
//             itemDastaQuantityController: TextEditingController(),
//             itemKetaaQuantityController: TextEditingController(),
//           )
//       );
//
//       invoiceItems.last.itemNameController.addListener(() => _onItemNameChanged(invoiceItems.length - 1));
//       invoiceItems.last.itemCodeController.addListener(() => _onItemCodeChanged(invoiceItems.length - 1));
//
//     });
//
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       FocusScope.of(context).requestFocus(_itemNameFocusNodes.first);
//     });
//   }
//
//   void _removeItem(int index) {
//     setState(() {
//       invoiceItems.removeAt(index);
//       _itemCodeFocusNodes.removeAt(index);
//       _itemNameFocusNodes.removeAt(index);
//       _kartonaQuantityFocusNodes.removeAt(index);
//       _DastaQuantityFocusNodes.removeAt(index);
//       _KetaaQuantityFocusNodes.removeAt(index);
//       _priceFocusNodes.removeAt(index);
//     });
//   }
//
//
//
//   void _updateRemainingAmount() {
//     double total = double.tryParse(totalController.text) ?? 0.0;
//     double paid = double.tryParse(paidController.text) ?? 0.0;
//     double remain = total - paid;
//     remainController.text = remain.toInt().toString();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     final addNewSupplierInvoiceController = Provider.of<AddNewSupplierInvoiceController>(context, listen: false);
//     final loginController = Provider.of<LoginUserController>(context, listen: false);
//     return Scaffold(
//       persistentFooterAlignment: AlignmentDirectional.center,
//       appBar: AppBar(
//         title: const Text('تسجيل فاتوره مبيعات'),
//         actions: [
//           CircleAvatar(
//             foregroundColor: Colors.red,
//               child: Text(invoiceItems.length.toString())),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             MaterialButton(
//               height: SizeManager.s_48,
//               minWidth: 350,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(25),
//                   side: const BorderSide(color: Colors.black)
//               ),
//               onPressed: () async {
//                 DateTime? pickedDate = await showDatePicker(
//                   context: context,
//                   initialDate: DateTime.now(),
//                   firstDate: DateTime(2000),
//                   lastDate: DateTime(2100),
//                 );
//                 setState(() {
//                   currentDate = pickedDate;
//                   formattedDate = intl.DateFormat('yyyy-MM-dd').format(currentDate!);
//                 });
//               },
//               child: Text('التاريخ $formattedDate'),
//             ),
//             const SizedBox(height: 10,),
//             Row(
//               children: [
//                 Flexible(
//                   flex: 1,
//                   child: SizedBox(
//                     height: 40,
//                     child: TypeAheadField<SupplierEntity>(
//                       textFieldConfiguration: TextFieldConfiguration(
//                         controller: supplierNameController,
//                         focusNode: _nameFocusNode,
//                         decoration: InputDecoration(
//                           labelText: 'اسم العميل',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                         ),
//                         onEditingComplete: () {
//                           // Optional: Manually select the first suggestion when Enter is pressed
//                           final supplierController = Provider.of<ClientsController>(context, listen: false);
//                           final suggestions = supplierController.getSuggestions(supplierNameController.text);
//                           if (suggestions.isNotEmpty) {
//                             SupplierEntity selectedSupplier = suggestions.first;
//                             supplierNameController.text = selectedSupplier.supplierName ?? '';
//                             FocusScope.of(context).requestFocus(_codeFocusNode);
//                           } else {
//                             _nameFocusNode.unfocus();
//                             FocusScope.of(context).requestFocus(_codeFocusNode);
//                           }
//                         },
//                         // Add this to handle arrow key navigation
//                         onSubmitted: (value) {
//                           final supplierController = Provider.of<ClientsController>(context, listen: false);
//                           final suggestions = supplierController.getSuggestions(value);
//
//                           if (suggestions.isNotEmpty) {
//                             SupplierEntity selectedSupplier = suggestions.first;
//                             supplierNameController.text = selectedSupplier.supplierName ?? '';
//                             FocusScope.of(context).requestFocus(_codeFocusNode);
//                           } else {
//                             _nameFocusNode.unfocus();
//                             FocusScope.of(context).requestFocus(_codeFocusNode);
//                           }
//                         },
//                       ),
//                       suggestionsCallback: (pattern) {
//                         final supplierController = Provider.of<ClientsController>(context, listen: false);
//                         return supplierController.getSuggestions(pattern);
//                       },
//                       itemBuilder: (context, SupplierEntity suggestion) {
//                         return ListTile(
//                           title: Text(suggestion.supplierName ?? ''),
//                         );
//                       },
//                       onSuggestionSelected: (SupplierEntity suggestion) {
//                         supplierNameController.text = suggestion.supplierName ?? '';
//                         _nameFocusNode.unfocus();
//                         FocusScope.of(context).requestFocus(_codeFocusNode);
//                       },
//                       // Automatically flip suggestion highlight with arrow keys
//                       autoFlipDirection: true, // Enables the direction flip when suggestions appear
//                       hideOnEmpty: true,       // Hide when there's no suggestion
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 16.0),
//                 Flexible(
//                   flex: 1,
//                   child: SizedBox(
//                     height: 40,
//                     child: TextField(
//                       controller: supplierIdController,
//                       focusNode: _codeFocusNode,
//                       decoration: InputDecoration(
//                         labelText: 'كود العميل',
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15)
//                         ),
//                       ),
//                       keyboardType: TextInputType.number,
//                       enableSuggestions: true,
//                       enableInteractiveSelection: true,
//                       textInputAction: TextInputAction.next,
//                       onEditingComplete: () {
//                         //_codeFocusNode.unfocus();
//                         _addNewItem();
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             Row(
//               children: [
//                 const Text('الاصناف',
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 20
//                   ),),
//                 IconButton(
//                   onPressed: (){
//                     _addNewItem();
//                   },
//                   icon: const Icon(Icons.add_box),
//                 ),
//                 const Spacer(),
//
//                 ElevatedButton(
//                   child: const Row(
//                     children: [
//                       Text('كل الاصناف'),
//                       Icon(Icons.production_quantity_limits)
//                     ],
//                   ),
//                   onPressed: (){
//                   },
//                 ),
//               ],
//             ),
//             Expanded(
//               child: ListView.separated(
//                 itemCount: invoiceItems.length,
//                 separatorBuilder: (context, index) => const Divider(),
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 4.0),
//                     child: Card(
//                       margin: const EdgeInsets.all(SizeManager.s_8),
//                       child:
//                       // Row(
//                       //   children: [
//                       //     CircleAvatar(
//                       //       foregroundColor: Colors.purpleAccent,
//                       //       child: Text('${index + 1}'),
//                       //     ),
//                       //     const SizedBox(width: 5,),
//                       //     invoiceItems[index].itemImage != null
//                       //         ? CachedMemoryImage(
//                       //       uniqueKey: invoiceItems[index].itemImage!,
//                       //       base64: invoiceItems[index].itemImage,
//                       //       width: 80,
//                       //       height: 100,
//                       //       fit: BoxFit.cover,
//                       //       placeholder: const Center(
//                       //         child: Icon(
//                       //           Icons.image,
//                       //           size: 40,
//                       //           color: Colors.grey,
//                       //         ),
//                       //       ),
//                       //       errorWidget: const Text('Error'),
//                       //     )
//                       //         : const Icon(
//                       //       Icons.image,
//                       //       size: 40,
//                       //       color: Colors.grey,
//                       //     ),
//                       //     const SizedBox(width: 5,),
//                       //     Column(
//                       //       crossAxisAlignment: CrossAxisAlignment.start,
//                       //       children: [
//                       //         Row(
//                       //           mainAxisAlignment: MainAxisAlignment.start,
//                       //           crossAxisAlignment: CrossAxisAlignment.start,
//                       //           children: [
//                       //             // Item Code and Name fields
//                       //             SizedBox(
//                       //               height: 40,
//                       //               width: MediaQuery.of(context).size.width * 0.1,
//                       //               child: TextField(
//                       //                 controller: invoiceItems[index].itemCodeController,
//                       //                 focusNode: _itemCodeFocusNodes[index],
//                       //                 enableInteractiveSelection: true,
//                       //                 enableSuggestions: true,
//                       //                 autocorrect: true,
//                       //                 decoration: InputDecoration(
//                       //                   labelText: 'كود المنتج ${index + 1}',
//                       //                   border: OutlineInputBorder(
//                       //                     borderRadius: BorderRadius.circular(15),
//                       //                   ),
//                       //                 ),
//                       //                 onEditingComplete: () {
//                       //                   _itemCodeFocusNodes[index].unfocus();
//                       //                   FocusScope.of(context).requestFocus(_itemNameFocusNodes[index]);
//                       //                 },
//                       //               ),
//                       //             ),
//                       //             const SizedBox(width: 8.0),
//                       //             SizedBox(
//                       //               height: 40,
//                       //               width: MediaQuery.of(context).size.width * 0.4,
//                       //               child: Directionality(
//                       //                 textDirection: TextDirection.rtl,
//                       //                 child: TypeAheadField<ItemEntity>(
//                       //                   textFieldConfiguration: TextFieldConfiguration(
//                       //                     controller: invoiceItems[index].itemNameController,
//                       //                     focusNode: _itemNameFocusNodes[index],
//                       //                     decoration: InputDecoration(
//                       //                       labelText: 'اسم المنتج ${index + 1}',
//                       //                       border: OutlineInputBorder(
//                       //                         borderRadius: BorderRadius.circular(15),
//                       //                       ),
//                       //                     ),
//                       //                     onEditingComplete: () {
//                       //                       _itemNameFocusNodes[index].unfocus();
//                       //                       FocusScope.of(context).requestFocus(_kartonaQuantityFocusNodes[index]);
//                       //                     },
//                       //                   ),
//                       //                   suggestionsCallback: (pattern) {
//                       //                     final itemsController = Provider.of<ItemsController>(context, listen: false);
//                       //                     return itemsController.getSuggestions(pattern);
//                       //                   },
//                       //                   itemBuilder: (context, ItemEntity suggestion) {
//                       //                     return Directionality(
//                       //                       textDirection: TextDirection.rtl,
//                       //                       child: ListTile(
//                       //                         title: Text(suggestion.name ?? ''),
//                       //                         subtitle: Text('سعر البيع : ${suggestion.sellingPrice.toString()}'),
//                       //                         trailing: Text('كود : ${suggestion.id}'),
//                       //                         leading: suggestion.images!.isNotEmpty
//                       //                             ? Container(
//                       //                           width: 80,
//                       //                           height: 100,
//                       //                           margin: const EdgeInsets.symmetric(horizontal: 5.0),
//                       //                           child: CachedMemoryImage(
//                       //                             uniqueKey: suggestion.images?.first ?? '',
//                       //                             errorWidget: const Text('Error'),
//                       //                             base64: suggestion.images?.first,
//                       //                             fit: BoxFit.cover,
//                       //                             placeholder: const Center(
//                       //                               child: Icon(
//                       //                                 Icons.image,
//                       //                                 size: 40,
//                       //                                 color: Colors.grey,
//                       //                               ),
//                       //                             ),
//                       //                           ),
//                       //                         )
//                       //                             : const SizedBox(
//                       //                             width: 80,
//                       //                             height: 100,
//                       //                             child: Icon(
//                       //                               Icons.image,
//                       //                               size: 40,
//                       //                               color: Colors.grey,
//                       //                             )),
//                       //                       ),
//                       //                     );
//                       //                   },
//                       //                   onSuggestionSelected: (ItemEntity suggestion) {
//                       //                     invoiceItems[index].itemNameController.text = suggestion.name ?? '';
//                       //                     invoiceItems[index].itemImage = suggestion.images?.first; // Update image on selection
//                       //                     _itemNameFocusNodes[index].unfocus();
//                       //                     FocusScope.of(context).requestFocus(_kartonaQuantityFocusNodes[index]);
//                       //                   },
//                       //                 ),
//                       //               ),
//                       //             ),
//                       //             const SizedBox(width: 8.0),
//                       //           ],
//                       //         ),
//                       //         const SizedBox(height: SizeManager.s_8),
//                       //         Row(
//                       //           children: [
//                       //             SizedBox(
//                       //               height: 40,
//                       //               width: MediaQuery.of(context).size.width * 0.3,
//                       //               child: TextField(
//                       //                 controller: invoiceItems[index].itemKartonaQuantityController,
//                       //                 focusNode: _kartonaQuantityFocusNodes[index],
//                       //                 decoration: InputDecoration(
//                       //                   labelText: 'الكمية',
//                       //                   border: OutlineInputBorder(
//                       //                     borderRadius: BorderRadius.circular(15),
//                       //                   ),
//                       //                 ),
//                       //                 keyboardType: TextInputType.number,
//                       //                 onChanged: (newValue) {
//                       //                   setState(() {});
//                       //                 },
//                       //                 onEditingComplete: () {
//                       //                   _kartonaQuantityFocusNodes[index].unfocus();
//                       //                   FocusScope.of(context).requestFocus(_priceFocusNodes[index]);
//                       //                 },
//                       //               ),
//                       //             ),
//                       //             const SizedBox(width: 8.0),
//                       //             SizedBox(
//                       //               height: 40,
//                       //               width: MediaQuery.of(context).size.width * 0.3,
//                       //               child: TextField(
//                       //                 controller: invoiceItems[index].itemPriceController,
//                       //                 focusNode: _priceFocusNodes[index],
//                       //                 decoration: InputDecoration(
//                       //                   hintText: 'السعر',
//                       //                   //labelText: 'السعر',
//                       //                   border: OutlineInputBorder(
//                       //                     borderRadius: BorderRadius.circular(15),
//                       //                   ),
//                       //                 ),
//                       //                 keyboardType: TextInputType.number,
//                       //                 onChanged: (newValue) {
//                       //                   setState(() {});
//                       //                 },
//                       //                 onEditingComplete: () {
//                       //                   _priceFocusNodes[index].unfocus();
//                       //                   if (index == invoiceItems.length - 1) {
//                       //                     _addNewItem();
//                       //                   } else {
//                       //                     FocusScope.of(context).requestFocus(_itemNameFocusNodes[index + 1]);
//                       //                   }
//                       //                 },
//                       //               ),
//                       //             ),
//                       //           ],
//                       //         ),
//                       //         Text('الرصيد المتاح ${invoiceItems[index].balanceKartona} كرتونه ${invoiceItems[index].balanceDasta} دسته ${invoiceItems[index].balanceKetaa} قطعه')
//                       //       ],
//                       //     ),
//                       //     Column(
//                       //       children: [
//                       //         IconButton(
//                       //           icon: const Icon(Icons.delete),
//                       //           onPressed: () => _removeItem(index),
//                       //         ),
//                       //         const SizedBox(height: 8.0),
//                       //         Text(
//                       //           _calculateTotal(
//                       //             invoiceItems[index].itemPriceController.text,
//                       //             invoiceItems[index].itemKartonaQuantityController.text,
//                       //           ),
//                       //         ),
//                       //       ],
//                       //     ),
//                       //   ],
//                       // ),
//                       Row(
//                         children: [
//                         CircleAvatar(
//                               foregroundColor: Colors.purpleAccent,
//                               child: Text('${index + 1}'),
//                             ),
//                             const SizedBox(width: 5,),
//
//                             // invoiceItems[index].itemImage != null
//                             //     ? CachedMemoryImage(
//                             //   uniqueKey: invoiceItems[index].itemImage!,
//                             //   base64: invoiceItems[index].itemImage,
//                             //   width: 80,
//                             //   height: 100,
//                             //   fit: BoxFit.cover,
//                             //   placeholder: const Center(
//                             //     child: Icon(
//                             //       Icons.image,
//                             //       size: 40,
//                             //       color: Colors.grey,
//                             //     ),
//                             //   ),
//                             //   errorWidget: const Text('Error'),
//                             // )
//                             //     : const Icon(
//                             //   Icons.image,
//                             //   size: 40,
//                             //   color: Colors.grey,
//                             // ),
//                             // const SizedBox(width: 5,),
//
//                           Container(
//                             width: 100,
//                             height: 100,
//                             margin: const EdgeInsets.symmetric(horizontal: 5.0),
//                             child: CachedMemoryImage(
//                               uniqueKey: (invoiceItems[index].itemImage != null &&invoiceItems[index].itemImage!.isNotEmpty) ? invoiceItems[index].itemImage.toString() : '', // Check if the list is not empty
//                               errorWidget: const Text('Error'),
//                               base64: (invoiceItems[index].itemImage != null && invoiceItems[index].itemImage!.isNotEmpty) ? invoiceItems[index].itemImage.toString() : null, // Provide null as fallback if the list is empty
//                               fit: BoxFit.cover,
//                               placeholder: const Center(
//                                 child: Icon(
//                                   Icons.image,  // Replace with your desired placeholder icon or widget
//                                   size: 40,
//                                   color: Colors.grey, // Customize the color
//                                 ),
//                               ),
//                             ),
//                           ),
//
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               // SizedBox(
//                               //   height: 40,
//                               //   width: MediaQuery.of(context).size.width * 0.5,
//                               //   child: Directionality(
//                               //     textDirection: TextDirection.rtl,
//                               //     child: TypeAheadField<ItemEntity>(
//                               //       textFieldConfiguration: TextFieldConfiguration(
//                               //         controller: invoiceItems[index].itemNameController,
//                               //         focusNode: _itemNameFocusNodes[index],
//                               //         decoration: InputDecoration(
//                               //           labelText: 'اسم المنتج ${index + 1}',
//                               //           border: OutlineInputBorder(
//                               //             borderRadius: BorderRadius.circular(15),
//                               //           ),
//                               //         ),
//                               //         onEditingComplete: () {
//                               //           // Handle Enter key press to select the first suggestion
//                               //           final itemsController = Provider.of<ItemsController>(context, listen: false);
//                               //           final suggestions = itemsController.getSuggestions(invoiceItems[index].itemNameController.text);
//                               //           if (suggestions.isNotEmpty) {
//                               //             ItemEntity selectedItem = suggestions.first;
//                               //             invoiceItems[index].itemCodeController.text = selectedItem.id.toString();
//                               //             invoiceItems[index].itemNameController.text = selectedItem.name ?? '';
//                               //             invoiceItems[index].itemImage = selectedItem.images?.first; // Update image on selection
//                               //             invoiceItems[index].itemPriceController.text = selectedItem.sellingPrice.toString(); // Update image on selection
//                               //             invoiceItems[index].dasta = selectedItem.dasta; // Update image on selection
//                               //             invoiceItems[index].kartona = selectedItem.kartona; // Update image on selection
//                               //             invoiceItems[index].balanceKartona = selectedItem.balanceKartona;
//                               //             invoiceItems[index].balanceDasta = selectedItem.balanceDasta;
//                               //             invoiceItems[index].balanceKetaa = selectedItem.balanceKetaa;
//                               //           }
//                               //           _itemNameFocusNodes[index].unfocus();
//                               //           FocusScope.of(context).requestFocus(_itemCodeFocusNodes[index]);
//                               //         },
//                               //         // Optional: Handle submission via Enter key if needed
//                               //         onSubmitted: (value) {
//                               //           final itemsController = Provider.of<ItemsController>(context, listen: false);
//                               //           final suggestions = itemsController.getSuggestions(value);
//                               //           if (suggestions.isNotEmpty) {
//                               //             ItemEntity selectedItem = suggestions.first;
//                               //             invoiceItems[index].itemNameController.text = selectedItem.name ?? '';
//                               //             invoiceItems[index].itemImage = selectedItem.images?.first; // Update image on selection
//                               //             invoiceItems[index].itemPriceController.text = selectedItem.sellingPrice.toString(); // Update image on selection
//                               //           }
//                               //           _itemNameFocusNodes[index].unfocus();
//                               //           FocusScope.of(context).requestFocus(_itemCodeFocusNodes[index]);
//                               //         },
//                               //       ),
//                               //       suggestionsCallback: (pattern) {
//                               //         final itemsController = Provider.of<ItemsController>(context, listen: false);
//                               //         return itemsController.getSuggestions(pattern);
//                               //       },
//                               //       itemBuilder: (context, ItemEntity suggestion) {
//                               //         return Directionality(
//                               //           textDirection: TextDirection.rtl,
//                               //           child: ListTile(
//                               //             title: Text(suggestion.name ?? ''),
//                               //             subtitle: Text('سعر البيع : ${suggestion.sellingPrice.toString()}'),
//                               //             trailing: Text('كود : ${suggestion.id}'),
//                               //             leading: suggestion.images!.isNotEmpty
//                               //                 ? Container(
//                               //               width: 80,
//                               //               height: 100,
//                               //               margin: const EdgeInsets.symmetric(horizontal: 5.0),
//                               //               child: CachedMemoryImage(
//                               //                 uniqueKey: suggestion.images?.first ?? '',
//                               //                 errorWidget: const Text('Error'),
//                               //                 base64: suggestion.images?.first,
//                               //                 fit: BoxFit.cover,
//                               //                 placeholder: const Center(
//                               //                   child: Icon(
//                               //                     Icons.image,
//                               //                     size: 40,
//                               //                     color: Colors.grey,
//                               //                   ),
//                               //                 ),
//                               //               ),
//                               //             )
//                               //                 : const SizedBox(
//                               //               width: 80,
//                               //               height: 100,
//                               //               child: Icon(
//                               //                 Icons.image,
//                               //                 size: 40,
//                               //                 color: Colors.grey,
//                               //               ),
//                               //             ),
//                               //           ),
//                               //         );
//                               //       },
//                               //       onSuggestionSelected: (ItemEntity suggestion) {
//                               //         invoiceItems[index].itemNameController.text = suggestion.name ?? '';
//                               //         invoiceItems[index].itemImage = suggestion.images?.first; // Update image on selection
//                               //         invoiceItems[index].itemPriceController.text = suggestion.sellingPrice.toString(); // Update image on selection
//                               //         _itemNameFocusNodes[index].unfocus();
//                               //         FocusScope.of(context).requestFocus(_itemCodeFocusNodes[index]);
//                               //       },
//                               //       //autoFlipDirection: true, // Enables arrow key navigation
//                               //       //hideOnEmpty: true,       // Hide suggestions when no input
//                               //     ),
//                               //   ),
//                               // ),
//
//
//                               SizedBox(
//                                 height: 40,
//                                 width: MediaQuery.of(context).size.width * 0.6,
//                                 child: Autocomplete<ItemEntity>(
//
//                                   optionsBuilder: (TextEditingValue textEditingValue) {
//                                     if (textEditingValue.text.isEmpty) {
//                                       return const Iterable.empty();
//                                     }
//                                     final _options = Provider.of<ItemsController>(context, listen: false).getSuggestions('');
//                                     return _options.where((option) {
//                                       return option.name!.toLowerCase().contains(textEditingValue.text.toLowerCase());
//                                     });
//                                   },
//                                   displayStringForOption: (option){
//                                     return option.name ?? '';
//                                   },
//                                   onSelected: (selectedOption) {
//                                     print('Selected: $selectedOption');
//                                     invoiceItems[index].itemNameController.text = selectedOption.name.toString();
//                                     invoiceItems[index].itemPriceController.text = selectedOption.sellingPrice.toString();
//                                     invoiceItems[index].kartona = selectedOption.kartona;
//                                     invoiceItems[index].dasta = selectedOption.dasta;
//                                     invoiceItems[index].balanceKartona = selectedOption.balanceKartona;
//                                     invoiceItems[index].balanceDasta = selectedOption.balanceDasta;
//                                     invoiceItems[index].balanceKetaa = selectedOption.balanceDasta;
//                                     invoiceItems[index].itemImage = selectedOption.images!.first;
//                                   },
//                                 ),
//                               ),
//
//                               // SizedBox(
//                               //   height: 40,
//                               //   width: MediaQuery.of(context).size.width * 0.3,
//                               //   child: TextField(
//                               //     controller: invoiceItems[index].itemNameController,
//                               //     focusNode: _itemNameFocusNodes[index],
//                               //     enableInteractiveSelection: true,
//                               //     enableSuggestions: true,
//                               //     autocorrect: true,
//                               //     decoration: InputDecoration(
//                               //       labelText: 'اسم المنتج ${index + 1}',
//                               //       border: OutlineInputBorder(
//                               //         borderRadius: BorderRadius.circular(15),
//                               //       ),
//                               //     ),
//                               //     onEditingComplete: () {
//                               //       _itemNameFocusNodes[index].unfocus();
//                               //       FocusScope.of(context).requestFocus(_itemCodeFocusNodes[index]);
//                               //     },
//                               //   ),
//                               // ),
//                               // const SizedBox(width: 5,),
//                               // SizedBox(
//                               //                 height: 40,
//                               //                 width: MediaQuery.of(context).size.width * 0.3,
//                               //                 child: TextField(
//                               //                   controller: invoiceItems[index].itemCodeController,
//                               //                   focusNode: _itemCodeFocusNodes[index],
//                               //                   enableInteractiveSelection: true,
//                               //                   enableSuggestions: true,
//                               //                   autocorrect: true,
//                               //                   decoration: InputDecoration(
//                               //                     labelText: 'كود المنتج ${index + 1}',
//                               //                     border: OutlineInputBorder(
//                               //                       borderRadius: BorderRadius.circular(15),
//                               //                     ),
//                               //                   ),
//                               //                   onEditingComplete: () {
//                               //                     _itemCodeFocusNodes[index].unfocus();
//                               //                     FocusScope.of(context).requestFocus(_kartonaQuantityFocusNodes[index]);
//                               //                   },
//                               //                 ),
//                               //               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               SizedBox(
//                                             height: 40,
//                                             width: MediaQuery.of(context).size.width * 0.2,
//                                             child: TextField(
//                                               controller: invoiceItems[index].itemKartonaQuantityController,
//                                               focusNode: _kartonaQuantityFocusNodes[index],
//                                               decoration: InputDecoration(
//                                                 labelText: 'الكمية بالكرتونه',
//                                                 border: OutlineInputBorder(
//                                                   borderRadius: BorderRadius.circular(15),
//                                                 ),
//                                               ),
//                                               keyboardType: TextInputType.number,
//                                               onChanged: (newValue) {
//                                                 setState(() {});
//                                               },
//                                               onEditingComplete: () {
//                                                 _kartonaQuantityFocusNodes[index].unfocus();
//                                                 FocusScope.of(context).requestFocus(_DastaQuantityFocusNodes[index]);
//                                               },
//                                             ),
//                                           ),
//                               SizedBox(
//                                 height: 40,
//                                 width: MediaQuery.of(context).size.width * 0.2,
//                                 child: TextField(
//                                   controller: invoiceItems[index].itemDastaQuantityController,
//                                   focusNode: _DastaQuantityFocusNodes[index],
//                                   decoration: InputDecoration(
//                                     labelText: 'الكمية بالدسته',
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(15),
//                                     ),
//                                   ),
//                                   keyboardType: TextInputType.number,
//                                   onChanged: (newValue) {
//                                     setState(() {});
//                                   },
//                                   onEditingComplete: () {
//                                     _DastaQuantityFocusNodes[index].unfocus();
//                                     FocusScope.of(context).requestFocus(_KetaaQuantityFocusNodes[index]);
//                                   },
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 40,
//                                 width: MediaQuery.of(context).size.width * 0.2,
//                                 child: TextField(
//                                   controller: invoiceItems[index].itemKetaaQuantityController,
//                                   focusNode: _KetaaQuantityFocusNodes[index],
//                                   decoration: InputDecoration(
//                                     labelText: 'الكمية بالقطعه',
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(15),
//                                     ),
//                                   ),
//                                   keyboardType: TextInputType.number,
//                                   onChanged: (newValue) {
//                                     setState(() {});
//                                   },
//                                   onEditingComplete: () {
//                                     _KetaaQuantityFocusNodes[index].unfocus();
//                                     FocusScope.of(context).requestFocus(_priceFocusNodes[index]);
//                                   },
//                                 ),
//                               ),
//                               SizedBox(
//                                               height: 40,
//                                               width: MediaQuery.of(context).size.width * 0.2,
//                                               child: TextField(
//                                                 controller: invoiceItems[index].itemPriceController,
//                                                 focusNode: _priceFocusNodes[index],
//                                                 decoration: InputDecoration(
//                                                   hintText: 'السعر',
//                                                   //labelText: 'السعر',
//                                                   border: OutlineInputBorder(
//                                                     borderRadius: BorderRadius.circular(15),
//                                                   ),
//                                                 ),
//                                                 keyboardType: TextInputType.number,
//                                                 onChanged: (newValue) {
//                                                   setState(() {});
//                                                 },
//                                                 onEditingComplete: () {
//                                                   _priceFocusNodes[index].unfocus();
//                                                   if (index == invoiceItems.length - 1) {
//                                                     _addNewItem();
//                                                   } else {
//                                                     FocusScope.of(context).requestFocus(_itemNameFocusNodes[index + 1]);
//                                                   }
//                                                 },
//                                               ),
//                                             ),
//
//                             ],
//                           ),
//
//                               Text('الرصيد المتاح ${invoiceItems[index].balanceKartona} كرتونه ${invoiceItems[index].balanceDasta} دسته ${invoiceItems[index].balanceKetaa} قطعه'),
//                               Text('كرتونه =  ${invoiceItems[index].kartona} دسته =  ${invoiceItems[index].dasta} قطعه '),
//
//
//                         ],
//                       ),
//
//                       Column(
//                                         children: [
//                                           IconButton(
//                                             icon: const Icon(Icons.delete),
//                                             onPressed: () => _removeItem(index),
//                                           ),
//                                           const SizedBox(height: 8.0),
//                                           Text(
//                                             _calculateTotal(
//                                               invoiceItems[index].itemPriceController.text,
//                                               invoiceItems[index].itemKartonaQuantityController.text,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//
//           ],
//         ),
//       ),
//       persistentFooterButtons: [
//         Platform.isWindows ?  const Text(
//           'الاجمالي',
//           style: TextStyle(
//             fontSize: 22,
//             fontWeight: FontWeight.bold,
//           ),
//         ) : const SizedBox(),
//         Platform.isWindows ? Text(
//           _calculateInvoiceTotal().toStringAsFixed(2),
//           style: const TextStyle(
//             fontSize: 22,
//             fontWeight: FontWeight.bold,
//           ),
//         ) : const SizedBox(),
//         SizedBox(
//           height: 50,
//           width: Platform.isWindows ? 150 : null,
//           child: TextField(
//             controller: paidController,
//             focusNode: _paidFocusNode,
//             decoration: InputDecoration(
//               labelText: 'المدفوع',
//               border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(15)),
//             ),
//             keyboardType: TextInputType.number,
//             onChanged: (newValue) {
//               setState(() {});
//             },
//             onEditingComplete: () {
//               _paidFocusNode.unfocus();
//               FocusScope.of(context).requestFocus(_remainFocusNode);
//             },
//           ),
//         ),
//         const SizedBox(height: SizeManager.s_5,),
//         SizedBox(
//           height: 50,
//           width: Platform.isWindows ? 150 : null,
//           child: TextField(
//             controller: remainController,
//             focusNode: _remainFocusNode,
//             decoration: InputDecoration(
//               labelText: 'المتبقي',
//               border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(15)),
//             ),
//             keyboardType: TextInputType.number,
//             onChanged: (newValue) {
//               setState(() {});
//             },
//             onEditingComplete: () {
//               _remainFocusNode.unfocus();
//               FocusScope.of(context).requestFocus(_addPerButtonFocusNode);
//             },
//           ),
//         ),
//         const SizedBox(height: SizeManager.s_5,),
//         Platform.isAndroid ? Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               'الاجمالي',
//               style: TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text(
//               _calculateInvoiceTotal().toStringAsFixed(2),
//               style: const TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//               ),
//             )
//           ],
//         ) : const SizedBox(),
//         const SizedBox(height: SizeManager.s_5,),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               focusNode: _addPerButtonFocusNode,
//               onPressed: addNewSupplierInvoiceController.addNewSupplierInvoiceIsLoading ? null : ()async{
//                 final userId = loginController.loginUserResult?.id;
//                 AddNewSupplierInvoiceParameters invData = AddNewSupplierInvoiceParameters(
//                   invDate: currentDate.toString(),
//                   invSupplierId: int.tryParse(supplierIdController.text),
//                   userId: userId,
//                   type: 'to client',
//                   total: double.tryParse(totalController.text),
//                   payedAmount: double.tryParse(paidController.text),
//                   remainedAmount: double.tryParse(remainController.text),
//                   invoiceImageUrl: 'https://th.bing.com/th/id/R.5ede93c0d3081eb17ac748caa5cf5dd0?rik=%2fHfWJOcdh12zFg&pid=ImgRaw&r=0',
//                   invoiceItems: invoiceItems.map((e) => InvoiceItemEntity(
//                     itemId: int.tryParse(e.itemCodeController.text),
//                     itemQuantity: int.tryParse(e.itemKartonaQuantityController.text),
//                     itemPrice: double.tryParse(e.itemPriceController.text),
//                   ),).toList(),
//
//                 );
//                 addNewSupplierInvoiceController.addNewSupplierInvoice(invData);
//                 if (addNewSupplierInvoiceController.addNewSupplierInvoiceResult != null) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text('${addNewSupplierInvoiceController.addNewSupplierInvoiceErrorMessage}created successfully',),
//                     ),
//                   );
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('Message : ${addNewSupplierInvoiceController.addNewSupplierInvoiceErrorMessage}')),
//                   );
//                 }
//
//               },
//               child: Consumer<AddNewSupplierInvoiceController>(
//                 builder: (context, addNewInvoiceController, _){
//                   return addNewInvoiceController.addNewSupplierInvoiceIsLoading
//                       ? const CircularProgressIndicator.adaptive() :  const Text(StringManager.add);
//                 },
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(width: 20,),
//       ],
//     );
//   }
// }
//
//
// class InvoiceItem {
//   TextEditingController itemCodeController;
//   TextEditingController itemNameController;
//   TextEditingController itemPriceController;
//   TextEditingController itemKartonaQuantityController;
//   TextEditingController itemDastaQuantityController;
//   TextEditingController itemKetaaQuantityController;
//   String? itemImage;
//
//    num? dasta;
//    num? kartona;
//    num? balanceKetaa;
//    num? balanceKartona;
//    num? balanceDasta;
//
//   InvoiceItem({
//     required this.itemCodeController,
//     required this.itemNameController,
//     required this.itemPriceController,
//     required this.itemKartonaQuantityController,
//     required this.itemDastaQuantityController,
//     required this.itemKetaaQuantityController,
//
//     this.itemImage,
//     this.dasta,
//     this.kartona,
//     this.balanceKetaa,
//     this.balanceKartona,
//     this.balanceDasta,
//   });
// }
//
//




///TODO : test


// import 'dart:io';
// import 'package:cached_memory_image/cached_memory_image.dart';
// import 'package:eltawfiq_suppliers/authentication/presentation/controllers/login_user_controller.dart';
// import 'package:eltawfiq_suppliers/core/resources/size_manager.dart';
// import 'package:eltawfiq_suppliers/core/resources/string_manager.dart';
// import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
// import 'package:eltawfiq_suppliers/suppliers/domain/entities/invoice_item_entity.dart';
// import 'package:eltawfiq_suppliers/suppliers/domain/entities/item_entity.dart';
// import 'package:eltawfiq_suppliers/suppliers/domain/entities/section_entity.dart';
// import 'package:eltawfiq_suppliers/suppliers/domain/entities/supplier_entity.dart';
// import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/invoice/add_new_supplier_invoice_use_case.dart';
// import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/clients/clients_controller.dart';
// import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/invoice/add_new_supplier_invoice_controller.dart';
// import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/item/items_controller.dart';
// import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/supplier/suppliers_controller.dart';
// import 'package:eltawfiq_suppliers/suppliers/presentation/screens/supplier/add_new_supplier_invoice.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import 'package:intl/intl.dart' as intl;
//
// class AddNewClientInvoiceScreen extends StatefulWidget {
//   const AddNewClientInvoiceScreen({super.key});
//
//   @override
//   State<AddNewClientInvoiceScreen> createState() => _AddNewClientInvoiceScreenState();
// }
//
// class _AddNewClientInvoiceScreenState extends State<AddNewClientInvoiceScreen> {
//
//   final TextEditingController supplierNameController = TextEditingController();
//   final TextEditingController supplierIdController = TextEditingController();
//
//   final TextEditingController itemKartonaQuantityController = TextEditingController();
//   final TextEditingController itemDastaQuantityController = TextEditingController();
//   final TextEditingController itemKetaaQuantityController = TextEditingController();
//   final TextEditingController itemPriceController = TextEditingController();
//
//
//   final FocusNode _codeFocusNode = FocusNode();
//   final FocusNode _nameFocusNode = FocusNode();
//
//   DateTime? currentDate = DateTime.now();
//   String formattedDate = '';
//   @override
//   void initState() {
//     super.initState();
//     formattedDate = intl.DateFormat('yyyy-MM-dd').format(currentDate!);
//     supplierIdController.addListener(_onSupplierCodeChanged);
//     supplierNameController.addListener(_onSupplierNameChanged);
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<ClientsController>(context, listen: false).getClients(const NoParameters());
//       Provider.of<ItemsController>(context, listen: false).getItems(const NoParameters());
//     });
//   }
//
//   List<InvoiceItem> invoiceItems = [];
//
//   void _onItemCodeChanged(int index) {
//     final itemsController = Provider.of<ItemsController>(context, listen: false);
//     final itemId = invoiceItems[index].itemCodeController.text;
//     if (itemId.isNotEmpty) {
//       final item = itemsController.gettingItems?.firstWhere(
//             (item) => item.id.toString() == itemId,
//       );
//       if (item != null && item.id != 0) {
//         invoiceItems[index].itemNameController.text = item.name?? StringManager.emptyString;
//       } else {
//         invoiceItems[index].itemNameController.clear(); // Clear name if no store found
//       }
//     }
//   }
//
//   void _onItemNameChanged(int index) {
//     final itemsController = Provider.of<ItemsController>(context, listen: false);
//     final name = invoiceItems[index].itemNameController.text;
//     if (name.isNotEmpty) {
//       final item = itemsController.gettingItems?.firstWhere(
//             (item) => item.name == name,
//       );
//       if (item != null && item.id != 0) {
//         invoiceItems[index].itemCodeController.text = item.id.toString();
//       } else {
//         invoiceItems[index].itemCodeController.clear(); // Clear code if no store found
//       }
//     }
//   }
//
//
//   void _onSupplierCodeChanged() {
//     final supplierController = Provider.of<SupplierController>(context, listen: false);
//     final code = supplierIdController.text;
//     if (code.isNotEmpty) {
//       final supplier = supplierController.gettingSuppliers?.firstWhere(
//             (supplier) => supplier.id.toString() == code,
//       );
//       if (supplier != null) {
//         supplierNameController.text = supplier.supplierName ?? StringManager.emptyString;
//       } else {
//         supplierNameController.clear(); // Clear name if no supplier found
//       }
//     }
//   }
//
//   void _onSupplierNameChanged() {
//     final supplierController = Provider.of<SupplierController>(context, listen: false);
//     final name = supplierNameController.text;
//     if (name.isNotEmpty) {
//       final supplier = supplierController.gettingSuppliers?.firstWhere(
//             (supplier) => supplier.supplierName == name,
//       );
//       if (supplier != null) {
//         supplierIdController.text = supplier.id.toString();
//       } else {
//         supplierIdController.clear(); // Clear code if no supplier found
//       }
//     }
//   }
//
//  String? img;
//   String? kartona;
//   String? dasta;
//
//   String? balanceKartona;
//   String? balanceDasta;
//   String? balanceKetaa;
//
//   late ItemEntity selectedOption;
//
//   @override
//   Widget build(BuildContext context) {
//     final addNewSupplierInvoiceController = Provider.of<AddNewSupplierInvoiceController>(context, listen: false);
//     final loginController = Provider.of<LoginUserController>(context, listen: false);
//     return Scaffold(
//       persistentFooterAlignment: AlignmentDirectional.center,
//       appBar: buildAppBar(),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             buildClientAndDateRow(),
//             const Divider(),
//             const SizedBox(height: 16,),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 4.0),
//               child: Card(
//                 borderOnForeground: true,
//                 child: Row(
//                   children: [
//                     CircleAvatar(
//                       foregroundColor: Colors.purpleAccent,
//                       child: Text(''
//                           '${invoiceItems.length + 1}'
//                       ),
//                     ),
//                     const SizedBox(width: 5,),
//                     Container(
//                       width: 80,
//                       height: 80,
//                       margin: const EdgeInsets.symmetric(horizontal: 5.0),
//                       child: CachedMemoryImage(
//                         uniqueKey: img != null ? img! : '',
//                         errorWidget: const Center(child:  Text('Error')),
//                         base64: img != null ? img! : '',
//                         fit: BoxFit.cover,
//                         placeholder: const Center(
//                           child: Icon(
//                             Icons.image,  // Replace with your desired placeholder icon or widget
//                             size: 40,
//                             color: Colors.grey, // Customize the color
//                           ),
//                         ),
//                       ),
//                     ),
//
//                     Column(
//                       children: [
//                         SizedBox(
//                           height: 60, // Adjust height to fit the label and input
//                           width: MediaQuery.of(context).size.width * 0.8,
//                           child: Container(
//                         height: 40,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8.0), // Rounded corners
//                           border: Border.all(color: Colors.grey), // Border color
//                         ),
//                         child: Autocomplete<ItemEntity>(
//                           optionsBuilder: (TextEditingValue textEditingValue) {
//                             if (textEditingValue.text.isEmpty) {
//                               return const Iterable.empty();
//                             }
//                             final _options = Provider.of<ItemsController>(context, listen: false).getSuggestions('');
//                             return _options.where((option) {
//                               return option.name!.toLowerCase().contains(textEditingValue.text.toLowerCase());
//                             });
//                           },
//                           displayStringForOption: (option) {
//                             return option.name ?? '';
//                           },
//                           onSelected: (newSelectedOption) {
//                             setState(() {
//                               selectedOption = newSelectedOption;
//                             });
//                           },
//                         ),
//                                         ),
//                                       ),
//                         Row(
//                           children: [
//                             SizedBox(
//                               height: 40,
//                               width: MediaQuery.of(context).size.width * 0.25,
//                               child: TextField(
//                                 controller: itemKartonaQuantityController,
//                                 decoration: InputDecoration(
//                                   labelText: 'الكمية بالكرتونه',
//                                   border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(15)),
//                                 ),
//                                 keyboardType: TextInputType.number,
//                                 onChanged: (newValue) {
//                                   setState(() {});
//                                 },
//                                 onEditingComplete: () {
//                                   //FocusScope.of(context).requestFocus(_priceFocusNodes[index]);
//                                 },
//                               ),
//                             ),
//                             SizedBox(
//                               height: 40,
//                               width: MediaQuery.of(context).size.width * 0.25,
//                               child: TextField(
//                                 controller: itemDastaQuantityController,
//                                 decoration: InputDecoration(
//                                   labelText: 'الكمية بالدسته',
//                                   border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(15)),
//                                 ),
//                                 keyboardType: TextInputType.number,
//                                 onChanged: (newValue) {
//                                   setState(() {});
//                                 },
//                                 onEditingComplete: () {
//                                   //FocusScope.of(context).requestFocus(_priceFocusNodes[index]);
//                                 },
//                               ),
//                             ),
//                             SizedBox(
//                               height: 40,
//                               width: MediaQuery.of(context).size.width * 0.25,
//                               child: TextField(
//                                 controller: itemKetaaQuantityController,
//                                 decoration: InputDecoration(
//                                   labelText: 'الكمية بالقطعه',
//                                   border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(15)),
//                                 ),
//                                 keyboardType: TextInputType.number,
//                                 onChanged: (newValue) {
//                                   setState(() {});
//                                 },
//                                 onEditingComplete: () {
//                                   //FocusScope.of(context).requestFocus(_priceFocusNodes[index]);
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Text('متاح رصيد ${balanceKartona} كرتونه ${balanceDasta} دسته ${balanceKetaa} قطعه'),
//                             SizedBox(
//                               height: 40,
//                               width: MediaQuery.of(context).size.width * 0.25,
//                               child: TextField(
//                                 controller: itemPriceController,
//                                 decoration: InputDecoration(
//                                   labelText: 'السعر',
//                                   border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(15)),
//                                 ),
//                                 keyboardType: TextInputType.number,
//                                 onChanged: (newValue) {
//                                   setState(() {});
//                                 },
//                                 onEditingComplete: () {
//                                   //FocusScope.of(context).requestFocus(_priceFocusNodes[index]);
//                                 },
//                               ),
//                             ),
//                             Text('الكرتونه بها ${kartona} والدسته بها ${dasta}'),
//                           ],
//                         ),
//                       ],
//                     ),
//                     IconButton(
//                         onPressed: (){
//                           img = (selectedOption.images != null && selectedOption.images!.isNotEmpty)
//                               ? selectedOption.images?.first.toString() : '';
//                           kartona = selectedOption.kartona.toString();
//                           dasta = selectedOption.dasta.toString();
//                           itemPriceController.text = selectedOption.sellingPrice.toString();
//                           balanceKartona = selectedOption.balanceKartona.toString();
//                           balanceDasta = selectedOption.balanceDasta.toString();
//                           balanceKetaa = selectedOption.balanceKetaa.toString();
//                           InvoiceItem invoiceItem = InvoiceItem(
//                             itemCodeController: TextEditingController(text: selectedOption.id.toString()),
//                             itemNameController: TextEditingController(text: selectedOption.name.toString()),
//                             itemPriceController: itemPriceController,
//                             itemQuantityController: itemPriceController,
//                             imgController: img.toString(),
//                             itemKartonaQuantityController: int.parse(itemKartonaQuantityController.text),
//                             itemDastaQuantityController:  int.parse(itemDastaQuantityController.text),
//                             itemKetaaQuantityController:  int.parse(itemKetaaQuantityController.text),
//                             kartona: selectedOption.kartona ?? 0.0,
//                             dasta: selectedOption.dasta ?? 0.0,
//                           );
//                           invoiceItems.add(invoiceItem);
//                           setState(() {});
//                         },
//                         icon: const Icon(Icons.add),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             Expanded(
//                 child: ListView.separated(
//                     itemBuilder: (context, index){
//                       return Row(
//                         children: [
//                           CircleAvatar(
//                             foregroundColor: Colors.purpleAccent,
//                             child: Text(''
//                                 '${index+1}'
//                             ),
//                           ),
//                           const SizedBox(width: 3,),
//                           Container(
//                             width: 60,
//                             height: 60,
//                             margin: const EdgeInsets.symmetric(horizontal: 5.0),
//                             child: CachedMemoryImage(
//                               uniqueKey: invoiceItems[index].imgController,
//                               errorWidget: const Center(child:  Text('Error')),
//                               base64: invoiceItems[index].imgController,
//                               fit: BoxFit.cover,
//                               placeholder: const Center(
//                                 child: Icon(
//                                   Icons.image,  // Replace with your desired placeholder icon or widget
//                                   size: 40,
//                                   color: Colors.grey, // Customize the color
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Column(
//                             children: [
//                               Text(invoiceItems[index].itemNameController.text),
//                               Text('${invoiceItems[index].itemKartonaQuantityController} كرتونه'
//                                   '${invoiceItems[index].itemDastaQuantityController} دسته'
//                                   '${invoiceItems[index].itemKetaaQuantityController}قطعه'),
//                               Text('السعر ${invoiceItems[index].itemPriceController.text}'),
//                             ],
//                           ),
//                           IconButton(
//                               onPressed: (){
//                                 invoiceItems.removeAt(index);
//                                 setState(() {
//
//                                 });
//                               },
//                               icon: const Icon(Icons.delete),
//                           ),
//                         ],
//                       );
//                     },
//                     separatorBuilder: (context, index) => const Divider(),
//                     itemCount: invoiceItems.length,
//                 ),
//             ),
//
//           ],
//         ),
//       ),
//
//     );
//   }
//
//   buildAppBar() {
//     return AppBar(
//       title: const Text('تسجيل فاتوره مبيعات'),
//       actions: [
//         CircleAvatar(
//             foregroundColor: Colors.red,
//             child: Text(invoiceItems.length.toString())),
//       ],
//     );
//   }
//
//   buildClientAndDateRow() {
//     return Row(
//       children: [
//         Flexible(
//           flex: 1,
//           child: SizedBox(
//             height: 40,
//             child: TypeAheadField<SupplierEntity>(
//               textFieldConfiguration: TextFieldConfiguration(
//                 controller: supplierNameController,
//                 focusNode: _nameFocusNode,
//                 decoration: InputDecoration(
//                   labelText: 'اسم العميل',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                 ),
//                 onEditingComplete: () {
//                   // Optional: Manually select the first suggestion when Enter is pressed
//                   final supplierController = Provider.of<ClientsController>(context, listen: false);
//                   final suggestions = supplierController.getSuggestions(supplierNameController.text);
//                   if (suggestions.isNotEmpty) {
//                     SupplierEntity selectedSupplier = suggestions.first;
//                     supplierNameController.text = selectedSupplier.supplierName ?? '';
//                     FocusScope.of(context).requestFocus(_codeFocusNode);
//                   } else {
//                     _nameFocusNode.unfocus();
//                     FocusScope.of(context).requestFocus(_codeFocusNode);
//                   }
//                 },
//                 // Add this to handle arrow key navigation
//                 onSubmitted: (value) {
//                   final supplierController = Provider.of<ClientsController>(context, listen: false);
//                   final suggestions = supplierController.getSuggestions(value);
//
//                   if (suggestions.isNotEmpty) {
//                     SupplierEntity selectedSupplier = suggestions.first;
//                     supplierNameController.text = selectedSupplier.supplierName ?? '';
//                     FocusScope.of(context).requestFocus(_codeFocusNode);
//                   } else {
//                     _nameFocusNode.unfocus();
//                     FocusScope.of(context).requestFocus(_codeFocusNode);
//                   }
//                 },
//               ),
//               suggestionsCallback: (pattern) {
//                 final supplierController = Provider.of<ClientsController>(context, listen: false);
//                 return supplierController.getSuggestions(pattern);
//               },
//               itemBuilder: (context, SupplierEntity suggestion) {
//                 return ListTile(
//                   title: Text(suggestion.supplierName ?? ''),
//                 );
//               },
//               onSuggestionSelected: (SupplierEntity suggestion) {
//                 supplierNameController.text = suggestion.supplierName ?? '';
//                 _nameFocusNode.unfocus();
//                 FocusScope.of(context).requestFocus(_codeFocusNode);
//               },
//               // Automatically flip suggestion highlight with arrow keys
//               autoFlipDirection: true, // Enables the direction flip when suggestions appear
//               hideOnEmpty: true,       // Hide when there's no suggestion
//             ),
//           ),
//         ),
//         const SizedBox(width: 16.0),
//         MaterialButton(
//           height: SizeManager.s_48,
//           minWidth: 350,
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(25),
//               side: const BorderSide(color: Colors.black)
//           ),
//           onPressed: () async {
//             DateTime? pickedDate = await showDatePicker(
//               context: context,
//               initialDate: DateTime.now(),
//               firstDate: DateTime(2000),
//               lastDate: DateTime(2100),
//             );
//             setState(() {
//               currentDate = pickedDate;
//               formattedDate = intl.DateFormat('yyyy-MM-dd').format(currentDate!);
//             });
//           },
//           child: Text('التاريخ $formattedDate'),
//         ),
//       ],
//     );
//   }
// }




///TODO : try again
// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:eltawfiq_suppliers/core/resources/size_manager.dart';
// import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
// import 'package:eltawfiq_suppliers/suppliers/domain/entities/item_entity.dart';
// import 'package:eltawfiq_suppliers/suppliers/domain/entities/supplier_entity.dart';
// import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/clients/clients_controller.dart';
// import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/item/items_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_textfield_autocomplete/flutter_textfield_autocomplete.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:provider/provider.dart';
// import 'package:intl/intl.dart' as intl;
//
// class AddNewClientInvoiceScreen extends StatefulWidget {
//
//   AddNewClientInvoiceScreen({super.key});
//
//   @override
//   State<AddNewClientInvoiceScreen> createState() => _AddNewClientInvoiceScreenState();
// }
//
// class _AddNewClientInvoiceScreenState extends State<AddNewClientInvoiceScreen> {
//   final TextEditingController supplierNameController = TextEditingController();
//
//   final TextEditingController _itemNameController = TextEditingController();
//   final TextEditingController _itemBarCodeController = TextEditingController();
//   final TextEditingController _priceController = TextEditingController();
//
//   final TextEditingController _kartonaController = TextEditingController();
//   final TextEditingController _dastaController = TextEditingController();
//   final TextEditingController _ketaaController = TextEditingController();
//
//   final TextEditingController totalController = TextEditingController();
//
//   ItemEntity? _selectedItem;
//
//
//   //   double _calculateInvoiceTotal() {
//   //   double total = 0.0;
//   //   for (ItemEntity item in Provider.of<ItemsController>(context, listen: false).invoiceItems) {
//   //     item.t
//   //     double price = double.tryParse(item.itemPriceController.text) ?? 0.0;
//   //     double quantity = double.tryParse(item.itemKartonaQuantityController.text) ?? 0.0;
//   //     total += price * quantity;
//   //   }
//   //   totalController.text = total.toStringAsFixed(2);
//   //   _updateRemainingAmount();
//   //   return total;
//   // }
//   //
//   // void _updateRemainingAmount() {
//   //   double total = double.tryParse(totalController.text) ?? 0.0;
//   //   double paid = double.tryParse(paidController.text) ?? 0.0;
//   //   double remain = total - paid;
//   //   remainController.text = remain.toInt().toString();
//   // }
//
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<ClientsController>(context, listen: false).getClients(const NoParameters());
//       Provider.of<ItemsController>(context, listen: false).getItems(const NoParameters());
//       Provider.of<ItemsController>(context, listen: false).invoiceItems.clear;
//     });
//   }
//
//
//   // @override
//   // void initState() {
//   //   super.initState();
//   //
//   //
//   //   // Add listener for the name field
//   //   _itemNameController.addListener(() {
//   //     final nameText = _itemNameController.text;
//   //     if (nameText.isNotEmpty) {
//   //       // Fetch the corresponding barcode
//   //       final matchingItem = Provider.of<ItemsController>(context, listen: false)
//   //           .getSuggestions(nameText)
//   //           .firstWhere((item) => item.name == nameText);
//   //
//   //       if (matchingItem != null) {
//   //         // Update barcode
//   //         _itemBarCodeController.text = matchingItem.barcode ?? '';
//   //         setState(() {
//   //           _selectedItem = matchingItem;
//   //         });
//   //       }
//   //     }
//   //   });
//   //
//   //   // Add listener for the barcode field
//   //   _itemBarCodeController.addListener(() {
//   //     final barcodeText = _itemBarCodeController.text;
//   //     if (barcodeText.isNotEmpty) {
//   //       // Fetch the corresponding name
//   //       final matchingItem = Provider.of<ItemsController>(context, listen: false)
//   //           .getSuggestions('')
//   //           .firstWhere((item) => item.barcode == barcodeText);
//   //
//   //       if (matchingItem != null) {
//   //         // Update name
//   //         _itemNameController.text = matchingItem.name ?? '';
//   //         setState(() {
//   //           _selectedItem = matchingItem;
//   //         });
//   //       }
//   //     }
//   //   });
//   //
//   // }
//
//   DateTime? currentDate = DateTime.now();
//   String formattedDate = '';
//
//
//   bool itemAlreadyExists(int itemId) {
//     // Loop through the current items in the invoice
//     for (var item in  Provider.of<ItemsController>(context, listen: false).invoiceItems) {
//       if (item.id == itemId) {
//         return true;
//       }
//     }
//     return false;
//   }
//
//   final GlobalKey<TextFieldAutoCompleteState<ItemEntity>> _textFieldAutoCompleteKey =  GlobalKey();
//
//   @override
//   Widget build(BuildContext context) {
//     final itemsController = Provider.of<ItemsController>(context);
//
//     return Scaffold(
//       appBar: AppBar(
//           title: const Text('فاتورة مبيعات'),
//         actions: [
//           CircleAvatar(
//             child: Text(Provider.of<ItemsController>(context, listen: false).invoiceItems.length.toString()),
//           )
//         ],
//       ),
//       body: Column(
//         children: [
//           Row(
//             children: [
//
//       Flexible(
//                   flex: 1,
//                   child: SizedBox(
//                     height: 40,
//                     child: TypeAheadField<SupplierEntity>(
//                       textFieldConfiguration: TextFieldConfiguration(
//                         controller: supplierNameController,
//                         //focusNode: _nameFocusNode,
//                         decoration: InputDecoration(
//                           labelText: 'اسم العميل',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                         ),
//                         onEditingComplete: () {
//                           // Optional: Manually select the first suggestion when Enter is pressed
//                           final supplierController = Provider.of<ClientsController>(context, listen: false);
//                           final suggestions = supplierController.getSuggestions(supplierNameController.text);
//                           if (suggestions.isNotEmpty) {
//                             SupplierEntity selectedSupplier = suggestions.first;
//                             supplierNameController.text = selectedSupplier.supplierName ?? '';
//                             //FocusScope.of(context).requestFocus(_codeFocusNode);
//                           } else {
//                             //_nameFocusNode.unfocus();
//                            // FocusScope.of(context).requestFocus(_codeFocusNode);
//                           }
//                         },
//                         // Add this to handle arrow key navigation
//                         onSubmitted: (value) {
//                           final supplierController = Provider.of<ClientsController>(context, listen: false);
//                           final suggestions = supplierController.getSuggestions(value);
//
//                           if (suggestions.isNotEmpty) {
//                             SupplierEntity selectedSupplier = suggestions.first;
//                             supplierNameController.text = selectedSupplier.supplierName ?? '';
//                             //FocusScope.of(context).requestFocus(_codeFocusNode);
//                           } else {
//                             //_nameFocusNode.unfocus();
//                             //FocusScope.of(context).requestFocus(_codeFocusNode);
//                           }
//                         },
//                       ),
//                       suggestionsCallback: (pattern) {
//                         final supplierController = Provider.of<ClientsController>(context, listen: false);
//                         return supplierController.getSuggestions(pattern);
//                       },
//                       itemBuilder: (context, SupplierEntity suggestion) {
//                         return ListTile(
//                           title: Text(suggestion.supplierName ?? ''),
//                         );
//                       },
//                       onSuggestionSelected: (SupplierEntity suggestion) {
//                         supplierNameController.text = suggestion.supplierName ?? '';
//                         //_nameFocusNode.unfocus();
//                         //FocusScope.of(context).requestFocus(_codeFocusNode);
//                       },
//                       // Automatically flip suggestion highlight with arrow keys
//                       autoFlipDirection: true, // Enables the direction flip when suggestions appear
//                       hideOnEmpty: true,       // Hide when there's no suggestion
//                     ),
//                   ),
//                 ),
//
//         MaterialButton(
//               height: SizeManager.s_48,
//               minWidth: Platform.isWindows ? 350 : 100,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(25),
//                   side: const BorderSide(color: Colors.black)
//               ),
//               onPressed: () async {
//                 DateTime? pickedDate = await showDatePicker(
//                   context: context,
//                   initialDate: DateTime.now(),
//                   firstDate: DateTime(2000),
//                   lastDate: DateTime(2100),
//                 );
//                 setState(() {
//                   currentDate = pickedDate ?? DateTime.now();
//                   formattedDate = intl.DateFormat('yyyy-MM-dd').format(currentDate!);
//                 });
//               },
//               child: Text('التاريخ ${formattedDate }'),
//             ),
//             ],
//           ),
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.black12,
//               border: Border.all()
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [
//                   // AutoCompleteTextField for Item Name (from API list)
//               Row(
//               children: [
//                 Platform.isAndroid
//                     ? Flexible(
//                   child: Container(
//                     height: 58,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                     child: TextFieldAutoComplete<ItemEntity>(
//                         decoration: const InputDecoration(
//                           enabledBorder:  OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.black),
//                           ),
//                           focusedBorder:  OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.purple),
//                           ),
//                           labelText: "اسم الصنف",
//                           hintText:
//                           "اسم الصنف",
//                           floatingLabelBehavior: FloatingLabelBehavior.always,
//                           hintStyle: TextStyle(
//                             color: Colors.black,
//                             fontSize: 16,
//                             fontFamily: 'Roboto',
//                             fontWeight: FontWeight.w300,
//                           ),
//                         ),
//                         clearOnSubmit: false,
//                         controller: _itemNameController,
//                         itemSubmitted: (item) {
//                           print('selected breed $item');
//                           _itemNameController.text = item.name ?? '';
//                           _priceController.text = item.sellingPrice.toString();
//                           print('selected breed 2 ${_itemNameController.text}');
//                         },
//                         key: _textFieldAutoCompleteKey,
//                         suggestions: itemsController.getSuggestions(''),
//                         itemBuilder: (context, item) {
//                           return Container(
//                             padding: const EdgeInsets.all(20),
//                             child: Row(
//                               children: [
//                                 Text(
//                                   item.name??'',
//                                   style: const TextStyle(color: Colors.black),
//                                 )
//                               ],
//                             ),
//                           );
//                         },
//                         itemFilter: (item, query) {
//                           return item.name!.toLowerCase().contains(query.toLowerCase());
//                         },
//                       itemSorter: (ItemEntity a, ItemEntity b) {
//                           return a.name!.compareTo(b.name??'');
//                       },
//                     ),
//                   ),
//
//                 )
//                     : Flexible(
//                   child: Autocomplete<ItemEntity>(
//
//                     optionsBuilder: (TextEditingValue textEditingValue) {
//                       if (textEditingValue.text.isEmpty) {
//                         return const Iterable.empty();
//                       }
//                       return Provider.of<ItemsController>(context, listen: false)
//                           .getSuggestions(textEditingValue.text)
//                           .where((item) => item.name!.toLowerCase().contains(textEditingValue.text.toLowerCase()));
//                     },
//                     displayStringForOption: (option) => option.name ?? '',
//                     onSelected: (ItemEntity selectedItem) {
//                       _itemNameController.text = selectedItem.name!;
//                       _itemBarCodeController.text = selectedItem.barcode ?? '';
//                       _priceController.text = selectedItem.sellingPrice?.toString() ?? '';
//                       setState(() {
//                         _selectedItem = selectedItem;
//                       });
//                     },
//
//                   ),
//                 ),
//
//                 IconButton(
//                   icon: const Icon(Icons.clear), // Icon for clearing the selection
//                   onPressed: () {
//                     // Clear the selected option and reset the fields
//                     _itemNameController.clear();
//                     _itemBarCodeController.clear();
//                     _priceController.clear();
//                     _kartonaController.clear();
//                     _dastaController.clear();
//                     _ketaaController.clear();
//                     setState(() {
//                       _selectedItem = null; // Reset the selected item
//                     });
//                   },
//                 ),
//                   ]
//               ),
//
//
//                   const SizedBox(height: 5,),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: TextField(
//                           controller: _kartonaController,
//                           keyboardType: TextInputType.number,
//                           decoration:  InputDecoration(
//                             enabledBorder:  const OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.black),
//                             ),
//                             focusedBorder:  const OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.purple),
//                             ),
//                             labelText: 'كرتونه = ${_selectedItem?.kartona.toString()} دسته',
//                             //hintText: 'كرتونه = ${_selectedItem?.kartona.toString()} دسته',
//                             floatingLabelBehavior: FloatingLabelBehavior.always,
//                             hintStyle: const TextStyle(
//                               color: Colors.black,
//                               fontSize: 16,
//                               fontFamily: 'Roboto',
//                               fontWeight: FontWeight.w300,
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 8), // Spacing between fields
//                       Expanded(
//                         child: TextField(
//                           controller: _dastaController,
//                           keyboardType: TextInputType.number,
//                           decoration:  InputDecoration(
//                             enabledBorder:  const OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.black),
//                             ),
//                             focusedBorder:  const OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.purple),
//                             ),
//                             labelText: 'دسته = ${_selectedItem?.dasta.toString()} قطعه',
//                             //hintText: 'كرتونه = ${_selectedItem?.kartona.toString()} دسته',
//                             floatingLabelBehavior: FloatingLabelBehavior.always,
//                             hintStyle: const TextStyle(
//                               color: Colors.black,
//                               fontSize: 16,
//                               //fontFamily: 'Roboto',
//                               fontWeight: FontWeight.w300,
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 8), // Spacing between fields
//                       Expanded(
//                         child: TextField(
//                           controller: _ketaaController,
//                           keyboardType: TextInputType.number,
//                           decoration:  const InputDecoration(
//                             enabledBorder:  OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.black),
//                             ),
//                             focusedBorder:  OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.purple),
//                             ),
//                             labelText: 'قطعه',
//                             //hintText: 'كرتونه = ${_selectedItem?.kartona.toString()} دسته',
//                             floatingLabelBehavior: FloatingLabelBehavior.always,
//                             hintStyle: TextStyle(
//                               color: Colors.black,
//                               fontSize: 16,
//                               //fontFamily: 'Roboto',
//                               fontWeight: FontWeight.w300,
//                             ),
//                           ),
//
//                         ),
//                       ),
//                     ],
//                   ),
//                   Text('الرصيد ${_selectedItem?.balanceKartona.toString()} كرتونه ${_selectedItem?.balanceDasta.toString()} دسته${_selectedItem?.balanceKetaa.toString()} قطعه'),
//
//                   Row(
//                     children: [
//
//                       Flexible(
//                         child: Container(
//                           height: 58,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(4),
//                           ),
//                           child: TextField(
//                             controller: _priceController,
//                             keyboardType: TextInputType.number,
//                             decoration:  const InputDecoration(
//                               enabledBorder:   OutlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.black),
//                               ),
//                               focusedBorder:   OutlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.purple),
//                               ),
//                               labelText:  'سعر الدسته',
//                               floatingLabelBehavior: FloatingLabelBehavior.always,
//                               hintStyle:  TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 16,
//                                 //fontFamily: 'Roboto',
//                                 fontWeight: FontWeight.w300,
//                               ),
//                             ),
//                           ),
//                         ),
//
//                       ),
//
//
//                       const SizedBox(width: 10,),
//                       ElevatedButton(
//                         onPressed: () {
//                           if (_selectedItem != null) {
//                             if(itemAlreadyExists(_selectedItem!.id!) == false){
//                               // Parse the values from the quantity fields
//                               final kartona = num.tryParse(_kartonaController.text) ?? 0;
//                               final dasta = num.tryParse(_dastaController.text) ?? 0;
//                               final ketaa = num.tryParse(_ketaaController.text) ?? 0;
//                               final price = num.tryParse(_priceController.text) ?? 0;
//
//                               // Create item with all quantities and price
//                               final itemWithDetails = _selectedItem!.copyWith(
//                                 sellingPrice: price,
//                                 kartonaQuntity: kartona, // Storing Kartona quantity
//                                 dastaQuntity: dasta,     // Storing Dasta quantity
//                                 ketaaQuntity: ketaa,     // Storing Ketaa quantity
//                               );
//
//                               // Add to invoice items
//                               itemsController.addItemToInvoice(itemWithDetails);
//
//                               _kartonaController.clear();
//                               _dastaController.clear();
//                               _ketaaController.clear();
//                             }
//                             else{
//                               showDialog(
//                                   context: context,
//                                   builder: (context){
//                                     return AlertDialog(
//                                       title: const Text('هل تريد تكرار الصنف ف الفاتوره؟'),
//                                       actions: [
//                                         ElevatedButton(
//                                             onPressed: (){
//                                               // Parse the values from the quantity fields
//                                               final kartona = num.tryParse(_kartonaController.text) ?? 0;
//                                               final dasta = num.tryParse(_dastaController.text) ?? 0;
//                                               final ketaa = num.tryParse(_ketaaController.text) ?? 0;
//                                               final price = num.tryParse(_priceController.text) ?? 0;
//
//                                               // Create item with all quantities and price
//                                               final itemWithDetails = _selectedItem!.copyWith(
//                                                 sellingPrice: price,
//                                                 kartonaQuntity: kartona, // Storing Kartona quantity
//                                                 dastaQuntity: dasta,     // Storing Dasta quantity
//                                                 ketaaQuntity: ketaa,     // Storing Ketaa quantity
//                                                 itemTotalPrice: _calculateInvoiceTotal()
//                                               );
//
//                                               // Add to invoice items
//                                               itemsController.addItemToInvoice(itemWithDetails);
//
//                                               _kartonaController.clear();
//                                               _dastaController.clear();
//                                               _ketaaController.clear();
//                                             },
//                                             child: const Text('نعم'),
//                                         ),
//                                         TextButton(
//                                             onPressed: (){
//                                               Navigator.pop(context);
//                                             },
//                                             child: const Text('لا')),
//                                       ],
//                                     );
//                                   },
//                               );
//                             }
//                           }
//                         },
//                         child: const Text('اضافه'),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const Divider(),
//           Flexible(
//             child: Consumer<ItemsController>(
//               builder: (context, controller, child) {
//                 final invoiceItems = controller.invoiceItems;
//                 return ListView.separated(
//                   itemCount: invoiceItems.length,
//                   separatorBuilder: (_, __) => const Divider(),
//                   itemBuilder: (context, index) {
//                     final item = invoiceItems[index];
//                     return InvoiceItemTile(item: item,);
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       persistentFooterButtons: [
//         Text(itemsController.invoiceTotal.toString()),
//         Text(itemsController.invoicePaid.toString()),
//         SizedBox(
//           height: 50,
//           width: 80,
//           child: TextFormField(
//             controller: totalController,
//           ),
//         )
//       ],
//     );
//   }
//
//
//   _calculateInvoiceTotal() {
//     double invtotal = 0.0;
//     double itemTotal = 0.0;
//     for (var item in Provider.of<ItemsController>(context,listen: false).invoiceItems) {
//       double pricePerDasta = double.tryParse(item.dasta.toString()) ?? 0.0;
//       double quantityPerKartoana = double.tryParse(item.kartonaQuntity.toString()) ?? 0.0;
//       double quantityPerDasta = double.tryParse(item.dastaQuntity.toString()) ?? 0.0;
//       double quantityPerKetaa = double.tryParse(item.ketaaQuntity.toString()) ?? 0.0;
//       // Calculate total pieces
//       int totalPieces = ((quantityPerKartoana * quantityPerKetaa * quantityPerDasta)
//           + (quantityPerDasta * pricePerDasta) + quantityPerKetaa).toInt();
//       // Convert total pieces into dasta and ketaa for pricing
//       int fullDastas = totalPieces ~/ pricePerDasta; // Full dasta count
//       int remainingKetaa = totalPieces % pricePerDasta.toInt(); // Remaining pieces
//       // Calculate total price
//       double itemTotalPrice = fullDastas * (item.sellingPrice?.toDouble() ?? 1)
//           + (remainingKetaa * ((item.sellingPrice?.toDouble() ?? 1) /( item?.dasta ?? 1)));
//      // Provider.of<ItemsController>(context, listen: false).
//       invtotal += itemTotalPrice;
//       itemTotal = itemTotalPrice;
//     }
//     totalController.text = invtotal.toStringAsFixed(2);
//     //_updateRemainingAmount();
//     return itemTotal;
//   }
//
// }
//
//
//
//
// class InvoiceItemTile extends StatefulWidget {
//   final ItemEntity item;
//
//
//   InvoiceItemTile({Key? key, required this.item}) : super(key: key);
//
//   @override
//   State<InvoiceItemTile> createState() => _InvoiceItemTileState();
// }
//
// class _InvoiceItemTileState extends State<InvoiceItemTile> {
//   final TextEditingController _itemNameController = TextEditingController();
//   final TextEditingController _quantityController = TextEditingController();
//   final TextEditingController _priceController = TextEditingController();
//
//   // updateItemTotalPrice(double totalPrice){
//   //   final updatedItem = widget.item.copyWith(
//   //     itemTotalPrice: totalPrice,
//   //   );
//   //   // Update the item in the invoice list
//   //   Provider.of<ItemsController>(context, listen: false).updateInvoiceItem(updatedItem);
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     final itemsController = Provider.of<ItemsController>(context, listen: false);
//
//     return ListTile(
//       //contentPadding: const EdgeInsets.all(0.0),
//       contentPadding: EdgeInsets.zero,
//       //horizontalTitleGap: 0.0,
//       minVerticalPadding: 0.0,
//       leading: CachedNetworkImage(
//         imageUrl: widget.item.images?.first ?? '',
//         placeholder: (context, url) => const CircularProgressIndicator(),
//         errorWidget: (context, url, error) => const Icon(Icons.error),
//       ),
//       title: Text(widget.item.name ?? 'Unknown Item'),
//       subtitle: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('سعر البيع: ${widget.item.sellingPrice ?? 'Not available'} للدسته التي تحتوي علي ${widget.item.dasta }قطعه'),
//           Text('الكميه ${widget.item.kartonaQuntity} كرتونه${widget.item.dastaQuntity} دسته${widget.item.ketaaQuntity} قطعه'),
//         ],
//       ),
//       trailing: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//             Text(widget.item.itemTotalPrice.toString(),
//              style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
//            ),
//           IconButton(
//             icon: const Icon(Icons.edit),
//             onPressed: () {
//               _showEditItemDialog(context, widget.item, itemsController);
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.delete),
//             onPressed: () {
//               itemsController.removeItemFromInvoice(widget.item);
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//     // Dialog to edit an invoice item
//   void _showEditItemDialog(BuildContext context, ItemEntity item, ItemsController itemsController) {
//     // Initialize the controllers with the existing item values
//     final TextEditingController _kartonaController = TextEditingController(text: item.kartonaQuntity?.toString() ?? '');
//     final TextEditingController _dastaController = TextEditingController(text: item.dastaQuntity?.toString() ?? '');
//     final TextEditingController _ketaaController = TextEditingController(text: item.ketaaQuntity?.toString() ?? '');
//     final TextEditingController _priceController = TextEditingController(text: item.sellingPrice?.toString() ?? '');
//
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text('تعديل'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // Kartona Field
//             TextField(
//               controller: _kartonaController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(labelText: 'كرتونه'),
//             ),
//             // Dasta Field
//             TextField(
//               controller: _dastaController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(labelText: 'دسته'),
//             ),
//             // Ketaa Field
//             TextField(
//               controller: _ketaaController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(labelText: 'قطعه'),
//             ),
//             // Price Field
//             TextField(
//               controller: _priceController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(labelText: 'السعر'),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               // Parse the updated values for kartona, dasta, and ketaa
//               final updatedItem = item.copyWith(
//                 sellingPrice: num.tryParse(_priceController.text),
//                 kartonaQuntity: num.tryParse(_kartonaController.text),
//                 dastaQuntity: num.tryParse(_dastaController.text),
//                 ketaaQuntity: num.tryParse(_ketaaController.text),
//               );
//               // Update the item in the invoice list
//               itemsController.updateInvoiceItem(updatedItem);
//               Navigator.of(context).pop();
//             },
//             child: const Text('Save'),
//           ),
//         ],
//       ),
//     );
//   }
//
//
//   }
//
//   Widget _buildPlaceholderImage() {
//     return Image.asset(
//       'assets/images/placeholder_image.png', // Ensure you have this image in your assets folder
//       width: 50,
//       height: 50,
//       fit: BoxFit.cover,
//     );
//   }
//
//
//
//
// class CustomAutocomplete extends StatelessWidget {
//   final TextEditingController _textEditingController = TextEditingController();
//   final FocusNode _focusNode = FocusNode();
//   final GlobalKey _autocompleteKey = GlobalKey();
//
//   final List<String> _options = <String>[
//     'aardvark',
//     'bobcat',
//     'chameleon',
//   ];
//
//   CustomAutocomplete({Key? key}) : super(key: key);
//
//   void clear() {
//     _textEditingController.clear();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return RawAutocomplete<String>(
//       key: _autocompleteKey,
//       focusNode: _focusNode,
//       textEditingController: _textEditingController,
//       optionsBuilder: (TextEditingValue textEditingValue) {
//         return _options.where((String option) {
//           return option.contains(textEditingValue.text.toLowerCase());
//         }).toList();
//       },
//       optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
//         return Material(
//           elevation: 4.0,
//           child: ListView(
//             children: options
//                 .map((String option) => GestureDetector(
//               onTap: () {
//                 onSelected(option);
//               },
//               child: ListTile(
//                 title: Text(option),
//               ),
//             ))
//                 .toList(),
//           ),
//         );
//       },
//     );
//   }
// }
//
//
//
//
// // // Method to calculate total pieces and total price for an invoice item
// // double calculateItemTotalPrice({
// //   required int kartonaQuantity,
// //   required int dastaQuantity,
// //   required int ketaaQuantity,
// //   required int piecesPerDasta, // e.g., 12
// //   required int dastasPerKartona, // e.g., the number of dastas in one kartona
// //   required double sellingPricePerDasta, // Price per dasta
// // }) {
// //   // Calculate total pieces
// //   int totalPieces = (kartonaQuantity * dastasPerKartona * piecesPerDasta)
// //       + (dastaQuantity * piecesPerDasta)
// //       + ketaaQuantity;
// //
// //   // Convert total pieces into dasta and ketaa for pricing
// //   int fullDastas = totalPieces ~/ piecesPerDasta; // Full dasta count
// //   int remainingKetaa = totalPieces % piecesPerDasta; // Remaining pieces
// //
// //   // Calculate total price
// //   double totalPrice = fullDastas * sellingPricePerDasta
// //       + (remainingKetaa * (sellingPricePerDasta / piecesPerDasta));
// //
// //   ///TODO : not working as expected
// //   //updateItemTotalPrice(totalPrice);
// //   //Provider.of<ItemsController>(context, listen: false).calculateInvoiceTotal(totalPrice);
// //   return totalPrice;
// // }
//







import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
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
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/clients/clients_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/invoice/add_new_supplier_invoice_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/item/hot_items_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/item/item_history_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/item/items_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/supplier/suppliers_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_textfield_autocomplete/flutter_textfield_autocomplete.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' as intl;
import 'package:shared_preferences/shared_preferences.dart';

class AddNewClientInvoiceScreen extends StatefulWidget {

  AddNewClientInvoiceScreen({super.key});

  @override
  State<AddNewClientInvoiceScreen> createState() => _AddNewClientInvoiceScreenState();
}

class _AddNewClientInvoiceScreenState extends State<AddNewClientInvoiceScreen> {
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
      Provider.of<ClientsController>(context, listen: false).getClients(const NoParameters());
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
          title: const Text('فاتورة مبيعات'),
          actions: [
            Column(
                children: [
                  const Text('كل الاصناف'),
                  Consumer<ItemsController>(
                      builder: (context, allItemsController, _){
                        return Text('${allItemsController.gettingItems?.length ?? 0}');
                      },
                  ),
                ],
            ),
            if(Platform.isWindows)
            ...[FlutterSwitch(
              activeText: 'hot',
              inactiveText: 'all',
              activeTextFontWeight: FontWeight.w100,
              width: 125.0,
              height: 55.0,
              activeColor: Colors.purple,
              valueFontSize: 16.0,
              toggleSize: 30.0,
              value: status,
              borderRadius: 30.0,
              padding: 8.0,
              showOnOff: true,
              onToggle: (val) {
                setState(() {
                  status = val;
                  print(status);
                });
              },
            )],
            if(Platform.isAndroid)
              ...[FlutterSwitch(
                activeText: 'hot',
                inactiveText: 'all',
                activeTextFontWeight: FontWeight.w100,
                width: 85.0,
                height: 34.0,
                activeColor: Colors.purple,
                valueFontSize: 16.0,
                toggleSize: 30.0,
                value: status,
                borderRadius: 30.0,
                padding: 4.0,
                showOnOff: true,
                onToggle: (val) {
                  setState(() {
                    status = val;
                    print(status);
                  });
                },
              )],
            Column(
              children: [
                const Text('اصناف خاصه'),
                Consumer<HotItemsController>(
                  builder: (context, hotItemsController, _){
                    return Text('${hotItemsController.gettingItems?.length ?? 0}');
                  },
                ),
              ],
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: SizedBox(
                      height: 40,
                      child: TypeAheadField<SupplierEntity>(
                        textFieldConfiguration: TextFieldConfiguration(
                          controller: supplierNameController,
                          //focusNode: _nameFocusNode,
                          decoration: InputDecoration(
                            labelText: 'اسم العميل',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onEditingComplete: () {
                            // Optional: Manually select the first suggestion when Enter is pressed
                            final supplierController = Provider.of<ClientsController>(context, listen: false);
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
                            final supplierController = Provider.of<ClientsController>(context, listen: false);
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
                          final supplierController = Provider.of<ClientsController>(context, listen: false);
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
                                      return Text(
                                        '0.0',
                                        style: const TextStyle(
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
                                  return Text(
                                    '0.0',
                                    style: const TextStyle(
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
                    return invoiceItems.isNotEmpty ? ListView.separated(
                      itemCount: invoiceItems.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (context, index) {
                        final item = invoiceItems[index];
                        return InvoiceItemTile(item: item,);
                      },
                    ) : const Center(
                      child: CircularProgressIndicator.adaptive(),
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
                        "type": "to client",
                        "payedAmount": double.tryParse(paidController.text),
                        "remainedAmount": double.tryParse(remainedController.text),
                        "invoiceItems": Provider.of<ItemsController>(context, listen: false).invoiceItems.map((e){
                          return {
                            "itemId": e.id,
                            "itemQuantity": 0,
                            "type": "to client",
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
              "type": "to client",
              "payedAmount": double.tryParse(paidController.text),
              "remainedAmount": double.tryParse(remainedController.text),
              "invoiceItems": Provider.of<ItemsController>(context, listen: false).invoiceItems.map((e){
                return {
                  "itemId": e.id,
                  "itemQuantity": 0,
                  "type": "to client",
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



