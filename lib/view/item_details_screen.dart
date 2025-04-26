// import 'package:eltawfiq_suppliers/controller/app_state_provider.dart';
// import 'package:eltawfiq_suppliers/core/network/api_constance.dart';
// import 'package:eltawfiq_suppliers/core/resources/string_manager.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class ItemDetailsScreen extends StatefulWidget {
//   const ItemDetailsScreen({super.key});
//
//   @override
//   State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
// }
//
// class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final appStateProvider = Provider.of<AppStateProvider>(context,listen: false);
//     //final _authStateProvider = Provider.of<AuthStateProvider>(context,listen: false);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(StringManager.itemDetails),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Image.network(
//               ApiConstance.getImage(appStateProvider.currentItem!.itemImageUrl),
//               height: 250,
//               width: double.infinity,
//               fit: BoxFit.fill,
//             ),
//             const SizedBox(height: 20,),
//             RichText(
//               textAlign: TextAlign.center,
//               softWrap: true,
//                 maxLines: 2,
//                 overflow: TextOverflow.visible,
//                 text: TextSpan(
//                   text: StringManager.itemName,
//                     style: const TextStyle(
//                         color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 22,
//                     ),
//                   children: [
//                     TextSpan(
//                       style: const TextStyle(
//                             color: Colors.black,
//                           fontWeight: FontWeight.bold
//                         ),
//                         text: StringManager.colon,
//                       children: [
//                         TextSpan(
//                           text: appStateProvider.currentItem!.itemName,
//                           style: const TextStyle(
//                             color: Colors.black,
//                               fontWeight: FontWeight.bold,
//                           )
//                         )
//                       ]
//                     )
//                   ]
//                 ),
//             ),
//             const Divider(),
//             RichText(
//               textAlign: TextAlign.center,
//               softWrap: true,
//               maxLines: 2,
//               overflow: TextOverflow.visible,
//               text: TextSpan(
//                   text: StringManager.itemCode,
//                   style: const TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 22,
//                   ),
//                   children: [
//                     TextSpan(
//                         style: const TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold
//                         ),
//                         text: StringManager.colon,
//                         children: [
//                           TextSpan(
//                               text: appStateProvider.currentItem?.itemCode?? '',
//                               style: const TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                           ),
//                         ]
//                     )
//                   ]
//               ),
//             ),
//             const Divider(),
//             RichText(
//               textAlign: TextAlign.center,
//               softWrap: true,
//               maxLines: 2,
//               overflow: TextOverflow.visible,
//               text: TextSpan(
//                   text: StringManager.itemSection,
//                   style: const TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 22,
//                   ),
//                   children: [
//                     TextSpan(
//                         style: const TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold
//                         ),
//                         text: StringManager.colon,
//                         children: [
//                           TextSpan(
//                               text: appStateProvider.currentItem!.sectionName,
//                               style: const TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold,
//                               )
//                           )
//                         ]
//                     )
//                   ]
//               ),
//             ),
//             const Divider(),
//             RichText(
//               textAlign: TextAlign.center,
//               softWrap: true,
//               maxLines: 2,
//               overflow: TextOverflow.visible,
//               text: TextSpan(
//                   text: StringManager.itemSellingPrice,
//                   style: const TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 22,
//                   ),
//                   children: [
//                     TextSpan(
//                         style: const TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold
//                         ),
//                         text: StringManager.colon,
//                         children: [
//                           TextSpan(
//                               text: appStateProvider.currentItem!.sellingPrice.toString(),
//                               style: const TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             children: const [
//                               TextSpan(
//                                 text: ' ',
//                                 children: [
//                                   TextSpan(
//                                       text: 'جنيه مصري'
//                                   )
//                                 ]
//                               )
//                             ]
//                           ),
//                         ]
//                     )
//                   ]
//               ),
//             ),
//             const Divider(),
//             //_authStateProvider.loginResult!.user!.roleId == 1 ?
//             RichText(
//               textAlign: TextAlign.center,
//               softWrap: true,
//               maxLines: 2,
//               overflow: TextOverflow.visible,
//               text: TextSpan(
//                   text: StringManager.itemPurshasingPrice,
//                   style: const TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 22,
//                   ),
//                   children: [
//                     TextSpan(
//                         style: const TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold
//                         ),
//                         text: StringManager.colon,
//                         children: [
//                           TextSpan(
//                               text: appStateProvider.currentItem!.purchasingPrice.toString(),
//                               style: const TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                               children: const [
//                                 TextSpan(
//                                     text: ' ',
//                                     children: [
//                                       TextSpan(
//                                           text: 'جنيه مصري'
//                                       )
//                                     ]
//                                 )
//                               ]
//                           ),
//                         ]
//                     )
//                   ]
//               ),
//             ),
//             //: const SizedBox(),
//
//
//             ///TODO : supplier Name
//             const Divider(),
//             //_authStateProvider.loginResult!.user!.roleId == 1 ?
//             RichText(
//               textAlign: TextAlign.center,
//               softWrap: true,
//               maxLines: 2,
//               overflow: TextOverflow.visible,
//               text: TextSpan(
//                   text: StringManager.supplierName,
//                   style: const TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 22,
//                   ),
//                   children: [
//                     TextSpan(
//                         style: const TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold
//                         ),
//                         text: StringManager.colon,
//                         children: [
//                           TextSpan(
//                               text: appStateProvider.currentItem!.supplierName,
//                               style: const TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                           ),
//                         ]
//                     )
//                   ]
//               ),
//             )
//                 //: const SizedBox(),
//
//           ],
//         ),
//       ),
//     );
//   }
// }
