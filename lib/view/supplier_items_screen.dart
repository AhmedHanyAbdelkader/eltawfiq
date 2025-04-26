import 'package:eltawfiq_suppliers/controller/app_state_provider.dart';
import 'package:eltawfiq_suppliers/core/network/api_constance.dart';
import 'package:eltawfiq_suppliers/core/resources/string_manager.dart';
import 'package:eltawfiq_suppliers/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SupplierItemsScreen extends StatefulWidget {
  const SupplierItemsScreen({super.key});

  @override
  State<SupplierItemsScreen> createState() => _SupplierItemsScreenState();
}

class _SupplierItemsScreenState extends State<SupplierItemsScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, (){
      Provider.of<AppStateProvider>(context,listen: false).getSupplierItems(id: Provider.of<AppStateProvider>(context,listen: false).currentSupplier!.supplierId!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${StringManager.suppliedFrom}${StringManager.colon} ${Provider.of<AppStateProvider>(context,listen: false).currentSupplier?.supplierName ?? ''}'),
      ),
      body: Consumer<AppStateProvider>(
        builder: (context, supplierItemsStateProvider, _){
          if(supplierItemsStateProvider.getSupplierItemsIsLoading == true){
            return const Center(child: CircularProgressIndicator.adaptive(),);
          }else if(supplierItemsStateProvider.getSupplierItemsErrorMessage.isNotEmpty){
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text(StringManager.error),
                content: Text(supplierItemsStateProvider.getSupplierItemsErrorMessage),
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
          }else if(supplierItemsStateProvider.getSupplierItemsResult != null){
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: supplierItemsStateProvider.getSupplierItemsResult!.length,
              separatorBuilder: (context, index)=> const Divider(),
              itemBuilder: (context, index){
                return ListTile(
                  onTap: (){
                    Provider.of<AppStateProvider>(context,listen: false).changeCurrentItem(newItem: supplierItemsStateProvider.getSupplierItemsResult![index]);
                    RouteGenerator.navigationTo(AppRoutes.itemDetailsScreenRoute);
                  },
                  title: Text(
                    supplierItemsStateProvider.getSupplierItemsResult![index].itemName,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),
                  ),
                  leading: Text((index+1).toString()),
                  trailing: Image.network(
                    ApiConstance.getImage(supplierItemsStateProvider.getSupplierItemsResult![index].itemImageUrl),
                    height: 100,
                    width: 100,
                  ),
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator.adaptive(),);
        },
      ),
    );
  }

}
