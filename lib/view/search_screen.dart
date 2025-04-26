// // import 'package:eltawfiq_suppliers/controller/app_state_provider.dart';
// // import 'package:eltawfiq_suppliers/core/network/api_constance.dart';
// // import 'package:eltawfiq_suppliers/core/router/app_router.dart';
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// //
// // class SearchScreen extends StatelessWidget {
// //   final TextEditingController _searchController = TextEditingController();
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Search Items'),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(8.0),
// //         child: Column(
// //           children: [
// //             TextField(
// //               controller: _searchController,
// //               decoration: InputDecoration(
// //                 hintText: 'Enter item name or barcode',
// //                 suffixIcon: IconButton(
// //                   icon: const Icon(Icons.search),
// //                   onPressed: () {
// //                     Provider.of<AppStateProvider>(context, listen: false).serachItem(_searchController.text);
// //                   },
// //                 ),
// //               ),
// //             ),
// //             const SizedBox(height: 10),
// //             Consumer<AppStateProvider>(
// //               builder: (context, controller, child) {
// //                 if (controller.searchItemIsLoading == true) {
// //                   return const CircularProgressIndicator.adaptive();
// //                 } else if (controller.searchItemErrorMessage.isNotEmpty) {
// //                   return Text(
// //                     controller.searchItemErrorMessage,
// //                     style: const TextStyle(color: Colors.red),
// //                   );
// //                 } else if (controller.searchItemResult == null || controller.searchItemResult!.isEmpty) {
// //                   return const Text('No items found');
// //                 } else {
// //                   return Expanded(
// //                     child: ListView.separated(
// //                       shrinkWrap: true,
// //                       physics: const NeverScrollableScrollPhysics(),
// //                       itemCount: controller.searchItemResult!.length,
// //                       separatorBuilder: (context, index)=> const Divider(),
// //                       itemBuilder: (context, index){
// //                         return ListTile(
// //                           onTap: (){
// //                             Provider.of<AppStateProvider>(context,listen: false).changeCurrentItem(newItem:  controller.searchItemResult![index]);
// //                             RouteGenerator.navigationTo(AppRoutes.itemDetailsScreenRoute);
// //                           },
// //                           title: Text(
// //                             controller.searchItemResult![index].itemName,
// //                             style: const TextStyle(
// //                                 fontWeight: FontWeight.bold,
// //                                 fontSize: 18
// //                             ),
// //                           ),
// //                           leading: Text((index+1).toString()),
// //                           trailing: Image.network(
// //                             ApiConstance.getImage(controller.searchItemResult![index].itemImageUrl),
// //                             height: 100,
// //                             width: 100,
// //                           ),
// //                         );
// //                       },
// //                     ),
// //                   );
// //                 }
// //               },
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
//
// import 'dart:convert';
//
// import 'package:eltawfiq_suppliers/controller/auth_controller.dart';
// import 'package:eltawfiq_suppliers/core/services/service_locator.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:provider/provider.dart';
// import 'package:eltawfiq_suppliers/controller/app_state_provider.dart';
// import 'package:eltawfiq_suppliers/core/network/api_constance.dart';
// import 'package:eltawfiq_suppliers/core/router/app_router.dart';
// import 'package:http/http.dart'as http;
// class SearchScreen extends StatefulWidget {
//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }
//
// class _SearchScreenState extends State<SearchScreen> {
//   final TextEditingController _itemSearchController = TextEditingController();
//   final TextEditingController supplierSearchController = TextEditingController();
//
//   bool _searchingItems = true;
//
//
//   @override
//   void dispose() {
//     _itemSearchController.dispose();
//     super.dispose();
//   }
//
//   String _scannedBarcode = 'Unknown';
//
//   Future<void> scanBarcode() async {
//     String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
//       "#ff6666",
//       "Cancel",
//       true,
//       ScanMode.BARCODE,
//     );
//
//     if (barcodeScanRes != '-1') {
//       Provider.of<AppStateProvider>(context, listen: false).serachItem(
//           query: barcodeScanRes,
//          userId: Provider.of<AuthStateProvider>(context, listen: false).loginResult!.user!.id!,
//       );
//       setState(() {
//         _scannedBarcode = barcodeScanRes;
//         _itemSearchController.text = barcodeScanRes;
//       });
//       // Store the scanned barcode
//       print(barcodeScanRes);
//       print(barcodeScanRes.runtimeType);
//       //await DatabaseHelper.instance.insertItem(barcodeScanRes);
//     }
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     sl<AppStateProvider>().resetSearchScreen();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Search Items'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _itemSearchController,
//               decoration: InputDecoration(
//                 hintText: 'ابحث عن صنف',
//                 suffixIcon: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.search),
//                       onPressed: () {
//                         Provider.of<AppStateProvider>(context, listen: false).serachItem(
//                             query: _itemSearchController.text,
//                             userId: Provider.of<AuthStateProvider>(context, listen: false).loginResult!.user!.id!,
//                         );
//                       },
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.camera_alt),
//                       onPressed: () async {await scanBarcode();},
//                     ),
//                   ],
//                 ),
//                 prefixIcon: IconButton(
//                   onPressed: (){
//                     _itemSearchController.clear();
//                   },
//                   icon: Icon(Icons.delete_forever),
//                 )
//               ),
//             ),
//             const SizedBox(height: 10),
//             TextField(
//               controller: supplierSearchController,
//               decoration: InputDecoration(
//                   hintText: 'ابحث عن مورد',
//                   suffixIcon: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       IconButton(
//                         icon: const Icon(Icons.search),
//                         onPressed: () {
//                           Provider.of<AppStateProvider>(context, listen: false).serachSupplier(
//                             query: supplierSearchController.text,
//                           );
//                         },
//                       ),
//                       // IconButton(
//                       //   icon: const Icon(Icons.camera_alt),
//                       //   onPressed: () async {await scanBarcode();},
//                       // ),
//                     ],
//                   ),
//                   prefixIcon: IconButton(
//                     onPressed: (){
//                       supplierSearchController.clear();
//                     },
//                     icon: const Icon(Icons.delete_forever),
//                   )
//               ),
//             ),
//             const SizedBox(height: 10),
//             Consumer<AppStateProvider>(
//               builder: (context, controller, child) {
//                 if (controller.searchItemIsLoading == true || controller.searchSupplierIsLoading == true) {
//                   return const CircularProgressIndicator.adaptive();
//                 }
//                 else if (controller.searchItemErrorMessage.isNotEmpty || controller.searchSupplierErrorMessage.isNotEmpty) {
//                   return Text(
//                     controller.searchItemErrorMessage + controller.searchSupplierErrorMessage,
//                     style: const TextStyle(color: Colors.red),
//                   );
//                 }
//                 else if (controller.searchItemResult == null || controller.searchItemResult!.isEmpty ||
//                          controller.searchSupplierResult == null || controller.searchSupplierResult!.isEmpty) {
//                   return const Text('لا يوجد نتيجه');
//                 }
//                 else {
//                   print(controller.searchItemResult);
//                   print(controller.searchSupplierResult);
//                   return Expanded(
//                     child: controller.searchItemResult != null
//                         ? ListView.separated(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       itemCount: controller.searchItemResult!.length,
//                       separatorBuilder: (context, index) => const Divider(),
//                       itemBuilder: (context, index) {
//                         return ListTile(
//                           onTap: () {
//                             Provider.of<AppStateProvider>(context, listen: false).changeCurrentItem(newItem: controller.searchItemResult![index]);
//                             RouteGenerator.navigationTo(AppRoutes.itemDetailsScreenRoute);
//                           },
//                           title: Text(
//                             controller.searchItemResult![index].itemName,
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 18,
//                             ),
//                           ),
//                           leading: Text((index + 1).toString()),
//                           trailing: Image.network(
//                             ApiConstance.getImage(controller.searchItemResult![index].itemImageUrl),
//                             height: 100,
//                             width: 100,
//                           ),
//                         );
//                       },
//                     )
//                         : ListView.separated(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       itemCount: controller.searchSupplierResult!.length,
//                       separatorBuilder: (context, index) => const Divider(),
//                       itemBuilder: (context, index) {
//                         return ListTile(
//                           onTap: () {
//                             //Provider.of<AppStateProvider>(context, listen: false).changeCurrentItem(newItem: controller.searchSupplierResult![index]);
//                             //RouteGenerator.navigationTo(AppRoutes.itemDetailsScreenRoute);
//                           },
//                           title: Text(
//                             controller.searchSupplierResult![index].supplierName ?? '',
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 18,
//                             ),
//                           ),
//                           leading: Text((index + 1).toString()),
//                           subtitle: Text(
//                             controller.searchSupplierResult![index].company?.companyName ?? ''
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


///TODO:


// import 'package:eltawfiq_suppliers/controller/app_state_provider.dart';
// import 'package:eltawfiq_suppliers/controller/search_state_provider.dart';
// import 'package:eltawfiq_suppliers/core/app/functions.dart';
// import 'package:eltawfiq_suppliers/core/network/api_constance.dart';
// import 'package:eltawfiq_suppliers/core/router/app_router.dart';
// import 'package:eltawfiq_suppliers/core/services/service_locator.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:provider/provider.dart';
//
//
// class SearchScreen extends StatefulWidget {
//   const SearchScreen({super.key});
//
//   @override
//   _SearchScreenState createState() => _SearchScreenState();
// }
//
// class _SearchScreenState extends State<SearchScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   String _searchType = 'items'; // Default search type
//
//   //String _scannedBarcode = 'Unknown';
//
//   Future<void> scanBarcode() async {
//     String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
//       "#ff6666",
//       "Cancel",
//       true,
//       ScanMode.BARCODE,
//     );
//
//     if (barcodeScanRes != '-1') {
//       Provider.of<AppStateProvider>(context, listen: false).serachItem(
//           query: barcodeScanRes,
//          userId: 1
//          //Provider.of<AuthStateProvider>(context, listen: false).loginResult!.user!.id!,
//       );
//       setState(() {
//         //_scannedBarcode = barcodeScanRes;
//         _searchController.text = barcodeScanRes;
//       });
//       // Store the scanned barcode
//       //await DatabaseHelper.instance.insertItem(barcodeScanRes);
//     }
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     sl<AppStateProvider>().resetSearchScreen();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Search'),
//         actions: [
//           DropdownButton<String>(
//             value: _searchType,
//             onChanged: (String? newValue) {
//               setState(() {
//                 _searchType = newValue!;
//               });
//             },
//             items: <String>['items', 'suppliers']
//                 .map<DropdownMenuItem<String>>((String value) {
//               return DropdownMenuItem<String>(
//                 value: value,
//                 child: Text(value),
//               );
//             }).toList(),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 hintText: _searchType == 'items' ? 'Search for items' : 'Search for suppliers',
//                 suffixIcon: SizedBox(
//                   width: 100,
//                   child: Row(
//                     children: [
//                       IconButton(
//                         icon: const Icon(Icons.search),
//                         onPressed: () {
//                           if (_searchType == 'items') {
//                             Provider.of<ItemSearchProvider>(context, listen: false)
//                                 .serachItem(query: _searchController.text,
//                                 userId: 1,
//                                 //Provider.of<AuthStateProvider>(context, listen: false).loginResult!.user!.id!,); // Pass userId appropriately
//                             );
//                           } else {
//                             Provider.of<SupplierSearchProvider>(context, listen: false)
//                                 .serachSupplier(query: _searchController.text);
//                           }
//                         },
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.camera_alt),
//                         onPressed: () async {await scanBarcode();},
//                       ),
//                     ],
//                   ),
//                 ),
//                 prefixIcon: IconButton(
//                   onPressed: () {
//                     _searchController.clear();
//                   },
//                   icon: const Icon(Icons.clear),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             Consumer<ItemSearchProvider>(
//               builder: (context, itemProvider, child) {
//                 if (_searchType == 'items') {
//                   if (itemProvider.searchItemIsLoading) {
//                     return const CircularProgressIndicator();
//                   } else if (itemProvider.searchItemErrorMessage.isNotEmpty) {
//                     return Text(itemProvider.searchItemErrorMessage, style: const TextStyle(color: Colors.red));
//                   } else if (itemProvider.searchItemResult == null || itemProvider.searchItemResult!.isEmpty) {
//                     return const Text('No items found');
//                   } else {
//                     return Expanded(
//                       child: ListView.separated(
//                         itemCount: itemProvider.searchItemResult!.length,
//                         separatorBuilder:  (context, index) => const Divider(),
//                         itemBuilder: (context, index) {
//                           final item = itemProvider.searchItemResult![index];
//                           return ListTile(
//                             title: Text(item.itemName),
//                             subtitle: Text('سعر البيع : ${item.sellingPrice}'),
//                             leading: Text((index + 1).toString()),
//                            trailing: Image.network(
//                              ApiConstance.getImage(itemProvider.searchItemResult![index].itemImageUrl),
//                              height: 100,
//                              width: 100,
//                            ),
//                             onTap: () {
//                               Provider.of<AppStateProvider>(context, listen: false).changeCurrentItem(newItem: itemProvider.searchItemResult![index]);
//                              RouteGenerator.navigationTo(AppRoutes.itemDetailsScreenRoute);
//                             },
//                           );
//                         },
//                       ),
//                     );
//                   }
//                 }
//                 return const SizedBox.shrink(); // Empty widget for suppliers
//               },
//             ),
//             Consumer<SupplierSearchProvider>(
//               builder: (context, supplierProvider, child) {
//                 if (_searchType == 'suppliers') {
//                   if (supplierProvider.searchSupplierIsLoading) {
//                     return const CircularProgressIndicator();
//                   } else if (supplierProvider.searchSupplierErrorMessage.isNotEmpty) {
//                     return Text(supplierProvider.searchSupplierErrorMessage, style: const TextStyle(color: Colors.red));
//                   } else if (supplierProvider.searchSupplierResult == null || supplierProvider.searchSupplierResult!.isEmpty) {
//                     return const Text('No suppliers found');
//                   } else {
//                     return Expanded(
//                       child: ListView.builder(
//                         itemCount: supplierProvider.searchSupplierResult!.length,
//                         itemBuilder: (context, index) {
//                           final supplier = supplierProvider.searchSupplierResult![index];
//                           return ListTile(
//                             title: Text(supplier.supplierName ?? ''),
//                             leading: Text((index + 1).toString()),
//                             trailing: supplier.supplierWhatsappNumber != null
//                                 ? IconButton(
//                               onPressed: () {
//                                 String formattedWhatsappNumber =
//                                 formatPhoneNumber(supplier.supplierWhatsappNumber!);
//                                 launchWhatsAppUri(whatsappNumber: formattedWhatsappNumber);
//                               },
//                               icon: const Icon(
//                                 Icons.chat,
//                                 color: Colors.green,
//                               ),
//                             )
//                                 : null,
//                             subtitle: Text(supplier.company?.companyName ?? ''),
//                             onTap: () {
//                               Provider.of<AppStateProvider>(context, listen: false)
//                                   .changeCurrentISupplier(newSupplier: supplier);
//                               RouteGenerator.navigationTo(AppRoutes.supplierScreenRoute);
//                             },
//                           );
//                         },
//                       ),
//                     );
//                   }
//                 }
//                 return const SizedBox.shrink(); // Empty widget for items
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
