import 'package:eltawfiq_suppliers/controller/app_state_provider.dart';
import 'package:eltawfiq_suppliers/core/resources/string_manager.dart';
import 'package:eltawfiq_suppliers/view/add_new_invoice_screen.dart';
import 'package:eltawfiq_suppliers/view/invoice_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SupplierInvoicesScreen extends StatefulWidget {
  const SupplierInvoicesScreen({super.key});

  @override
  State<SupplierInvoicesScreen> createState() => _SupplierInvoicesScreenState();
}

class _SupplierInvoicesScreenState extends State<SupplierInvoicesScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, (){
      Provider.of<AppStateProvider>(context,listen: false).getSupplierInvoices(
          id: 1,
          //Provider.of<AuthStateProvider>(context,listen: false).loginResult!.user!.id!,
          supplierId:  Provider.of<AppStateProvider>(context,listen: false).currentSupplier!.supplierId!
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final invoices = Provider.of<AppStateProvider>(context, listen: false).currentSupplier!;
    return Scaffold(
      appBar: AppBar(
        title: Text('${StringManager.supplierAccountFrom} ${invoices.supplierName}'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddNewInvoiceScreen()));
          //RouteGenerator.navigationTo(AppRoutes.addNewInvoiceScreenRoute);
        },
        tooltip: StringManager.newInvoice,
        child: const Icon(Icons.add_card_rounded),
      ),
      body: Consumer<AppStateProvider>(
        builder: (context, supplierInvoiceStateProvider, _){
      if(supplierInvoiceStateProvider.getSupplierInvoicesIsLoading == true){
        return const Center(child: CircularProgressIndicator.adaptive(),);
      }else if(supplierInvoiceStateProvider.getSupplierInvoicesErrorMessage.isNotEmpty){
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          showDialog(context: context, builder: (context) => AlertDialog(
            title: const Text(StringManager.error),
            content: Text(supplierInvoiceStateProvider.getSupplierInvoicesErrorMessage),
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
      }else if(supplierInvoiceStateProvider.getSupplierInvoicesResult != null){
        return ListView.separated(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: supplierInvoiceStateProvider.getSupplierInvoicesResult!.length,
          separatorBuilder: (context, index)=> const Divider(),
          itemBuilder: (context, index){
            return ListTile(
              onTap: (){
                int invId = supplierInvoiceStateProvider.getSupplierInvoicesResult![index].id;
                //Provider.of<AppStateProvider>(context,listen: false).changeCurrentItem(newItem: supplierItemsStateProvider.getSupplierItemsResult![index]);
                //RouteGenerator.navigationTo(AppRoutes.itemDetailsScreenRoute);
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> InvoiceDetailsScreen(
                  invId: invId,
                )));
              },
              title:Text(
                '${StringManager.invoiceNumber} ${supplierInvoiceStateProvider.getSupplierInvoicesResult![index].id}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                    fontSize: 14
                ),
              ),
              // title: Text(
              //   '${StringManager.invoiceFrom} ${supplierInvoiceStateProvider.getSupplierInvoicesResult![index].invoiceSupplier!.supplierName}',
              //   style: const TextStyle(
              //       fontWeight: FontWeight.bold,
              //       fontSize: 18
              //   ),
              // ),
              subtitle: Text(
            '${supplierInvoiceStateProvider.getSupplierInvoicesResult![index].invDate}',
              style: const TextStyle(
                //fontWeight: FontWeight.bold,
                  fontSize: 14
              ),
            ),
              leading: Text((index+1).toString()),
              trailing: Column(
                children: [
                  Text(
                    supplierInvoiceStateProvider.getSupplierInvoicesResult![index].total.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),
                  ),
                  Text(
                    supplierInvoiceStateProvider.getSupplierInvoicesResult![index].payedAmount.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),
                  ),
                ],
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
