// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:eltawfiq_suppliers/controller/app_state_provider.dart';
// import 'package:eltawfiq_suppliers/controller/auth_controller.dart';
// import 'package:eltawfiq_suppliers/core/network/api_constance.dart';
// import 'package:eltawfiq_suppliers/core/resources/string_manager.dart';
// import 'package:eltawfiq_suppliers/core/router/app_router.dart';
// import 'package:eltawfiq_suppliers/core/services/service_locator.dart';
// import 'package:eltawfiq_suppliers/model/item_model.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// class SectionItemsScreen extends StatefulWidget {
//   const SectionItemsScreen({super.key});
//
//   @override
//   State<SectionItemsScreen> createState() => _SectionItemsScreenState();
// }
//
// class _SectionItemsScreenState extends State<SectionItemsScreen> {
//
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(Duration.zero, () {
//       Provider.of<AppStateProvider>(context, listen: false).getItemsForSection(
//         sectionId: Provider.of<AppStateProvider>(context, listen: false).currentSection!.id,
//         userId: Provider.of<AuthStateProvider>(context, listen: false).loginResult!.user!.id!,
//       );
//     });
//   }
//
//   late AppStateProvider _appStateProvider;
//
//   @override
//   void didChangeDependencies() {
//     _appStateProvider = sl<AppStateProvider>();
//     super.didChangeDependencies();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider.value(
//       value: _appStateProvider,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(Provider.of<AppStateProvider>(context, listen: false).currentSection!.name),
//         ),
//         floatingActionButton: Provider.of<AuthStateProvider>(context,listen: false).loginResult!.user!.roleId == 1
//             ? FloatingActionButton(
//           onPressed: (){
//             RouteGenerator.navigationReplacementTo(AppRoutes.addNewItemScreenRoute);
//           },
//           child: const Icon(Icons.add),
//         ) : null,
//         body: Column(
//           children: [
//             Consumer<AppStateProvider>(
//               builder: (context, itemsStateProvider, _){
//                 if(itemsStateProvider.getItemsForSectionIsLoading == true){
//                   return const Center(child: CircularProgressIndicator.adaptive());
//                 }
//                 else if(itemsStateProvider.getItemsForSectionErrorMessage.isNotEmpty){
//                   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//                     showDialog(
//                       context: context,
//                       builder: (context) => AlertDialog(
//                         title: const Text(StringManager.error),
//                         content: Text(itemsStateProvider.getItemsForSectionErrorMessage),
//                         actions: [
//                           TextButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             child: const Text(StringManager.ok),
//                           ),
//                         ],
//                       ),
//                     );
//                   });
//                 }
//                 else if(itemsStateProvider.getItemsForSectionResult != null){
//                   return ReorderableListView(
//                     onReorder: (oldIndex, newIndex) {
//                       setState(() {
//                         if (newIndex > oldIndex) {
//                           newIndex -= 1;
//                         }
//                         final section = itemsStateProvider.getItemsForSectionResult!.removeAt(oldIndex);
//                         itemsStateProvider.getItemsForSectionResult!.insert(newIndex, section);
//                       });
//                       _appStateProvider.saveItemsOrder(itemsStateProvider.getItemsForSectionResult!);
//                     },
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     // itemCount: itemsStateProvider.getItemsForSectionResult!.length,
//                     //   separatorBuilder: (context, index)=> const Divider(),
//                     //   itemBuilder: (context, index){
//                     //   return ListTile(
//                     //     onTap: (){
//                     //       Provider.of<AppStateProvider>(context,listen: false).changeCurrentItem(newItem:  itemsStateProvider.getItemsForSectionResult![index]);
//                     //       RouteGenerator.navigationTo(AppRoutes.itemDetailsScreenRoute);
//                     //     },
//                     //     title: Text(
//                     //         itemsStateProvider.getItemsForSectionResult![index].itemName,
//                     //       style: const TextStyle(
//                     //         fontWeight: FontWeight.bold,
//                     //         fontSize: 18
//                     //       ),
//                     //     ),
//                     //     subtitle: Text(
//                     //       '${StringManager.itemSellingPrice} : ${itemsStateProvider.getItemsForSectionResult![index].sellingPrice}',
//                     //       style: TextStyle(fontWeight: FontWeight.w600,),
//                     //     ),
//                     //     leading: Text((index+1).toString()),
//                     //     trailing: CachedNetworkImage(
//                     //       imageUrl: ApiConstance.getImage(itemsStateProvider.getItemsForSectionResult![index].itemImageUrl),
//                     //       placeholder: (context, url) => CircularProgressIndicator(),
//                     //       errorWidget: (context, url, error) => Icon(Icons.error),
//                     //       height: 100,
//                     //       width: 100,
//                     //       fit: BoxFit.cover,
//                     //     ),
//                     //   );
//                     //   },
//                     children: List.generate(
//                       itemsStateProvider.getItemsForSectionResult!.length,
//                             (index) {
//                         return ListTile(
//                           key: ValueKey( itemsStateProvider.getItemsForSectionResult![index]),
//                                 onTap: (){
//                                   Provider.of<AppStateProvider>(context,listen: false).changeCurrentItem(newItem:  itemsStateProvider.getItemsForSectionResult![index]);
//                                   RouteGenerator.navigationTo(AppRoutes.itemDetailsScreenRoute);
//                                 },
//                                 title: Text(
//                                     itemsStateProvider.getItemsForSectionResult![index].itemName,
//                                   style: const TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 18
//                                   ),
//                                 ),
//                                 subtitle: Text(
//                                   '${StringManager.itemSellingPrice} : ${itemsStateProvider.getItemsForSectionResult![index].sellingPrice}',
//                                   style: TextStyle(fontWeight: FontWeight.w600,),
//                                 ),
//                                 leading: Text((index+1).toString()),
//                                 trailing: CachedNetworkImage(
//                                   imageUrl: ApiConstance.getImage(itemsStateProvider.getItemsForSectionResult![index].itemImageUrl),
//                                   placeholder: (context, url) => CircularProgressIndicator(),
//                                   errorWidget: (context, url, error) => Icon(Icons.error),
//                                   height: 100,
//                                   width: 100,
//                                   fit: BoxFit.cover,
//                                 ),
//                         );
//                             },
//                     ),
//                   );
//                 }
//                   return const Center(child: CircularProgressIndicator.adaptive());
//               },
//
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




import 'package:cached_network_image/cached_network_image.dart';
import 'package:eltawfiq_suppliers/controller/app_state_provider.dart';
import 'package:eltawfiq_suppliers/core/network/api_constance.dart';
import 'package:eltawfiq_suppliers/core/resources/string_manager.dart';
import 'package:eltawfiq_suppliers/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionItemsScreen extends StatefulWidget {
  const SectionItemsScreen({super.key});

  @override
  State<SectionItemsScreen> createState() => _SectionItemsScreenState();
}

class _SectionItemsScreenState extends State<SectionItemsScreen> {
  //late AppStateProvider _appStateProvider;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<AppStateProvider>(context, listen: false).getItemsForSection(
        sectionId: Provider.of<AppStateProvider>(context, listen: false).currentSection!.id,
        userId: 1,
        //Provider.of<AuthStateProvider>(context, listen: false).loginResult!.user!.id!,
      );
    });
  }

  @override
  void didChangeDependencies() {
    //_appStateProvider = sl<AppStateProvider>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<AppStateProvider>(
          builder: (context, appStateProvider, _) {
            return Text(appStateProvider.currentSection?.name ?? 'Section');
          },
        ),
      ),

        //floatingActionButton: Provider.of<AuthStateProvider>(context,listen: false).loginResult!.user!.roleId == 1 ?
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            RouteGenerator.navigationReplacementTo(AppRoutes.addNewItemScreenRoute);
          },
          child: const Icon(Icons.add),
        ) ,
            //: null,
      body: Consumer<AppStateProvider>(
        builder: (context, itemsStateProvider, _) {
          if (itemsStateProvider.getItemsForSectionIsLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (itemsStateProvider.getItemsForSectionErrorMessage.isNotEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text(StringManager.error),
                  content: Text(itemsStateProvider.getItemsForSectionErrorMessage),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(StringManager.ok),
                    ),
                  ],
                ),
              );
            });
          } else if (itemsStateProvider.getItemsForSectionResult != null) {
            return ReorderableListView(
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  if (newIndex > oldIndex) {
                    newIndex -= 1;
                  }
                  final item = itemsStateProvider.getItemsForSectionResult!.removeAt(oldIndex);
                  itemsStateProvider.getItemsForSectionResult!.insert(newIndex, item);
                });
                itemsStateProvider.saveItemsOrder(itemsStateProvider.getItemsForSectionResult!);
              },
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(
                itemsStateProvider.getItemsForSectionResult!.length,
                    (index) {
                  final item = itemsStateProvider.getItemsForSectionResult![index];
                  return ListTile(
                    key: ValueKey(item.itemId),
                    onTap: () {
                      itemsStateProvider.changeCurrentItem(newItem: item);
                      RouteGenerator.navigationTo(AppRoutes.itemDetailsScreenRoute);
                    },
                    title: Text(
                      item.itemName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      '${StringManager.itemSellingPrice} : ${item.sellingPrice}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    leading: Text((index + 1).toString()),
                    trailing: CachedNetworkImage(
                      imageUrl: ApiConstance.getImage(item.itemImageUrl),
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            );
          }
          return const Center(child: CircularProgressIndicator.adaptive());
        },
      ),
    );
  }
}
