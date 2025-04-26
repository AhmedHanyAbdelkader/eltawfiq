import 'package:eltawfiq_suppliers/core/resources/string_manager.dart';
import 'package:eltawfiq_suppliers/core/router/app_router.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/supplier_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/supplier/get_supplier_invoices_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/screens/supplier/suppliers_invoices_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' as intl;

class SupplierInvoicesScreen extends StatefulWidget {
  const SupplierInvoicesScreen({super.key, required this.supplier});
  final SupplierEntity supplier;
  @override
  State<SupplierInvoicesScreen> createState() => _SupplierInvoicesScreenState();
}

class _SupplierInvoicesScreenState extends State<SupplierInvoicesScreen> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GetSupplierInvoicesController>(context, listen: false).getSupplierInvoices(supplierId: widget.supplier.id!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title:  Text('${StringManager.invoices} ${widget.supplier.supplierName}'),
        automaticallyImplyLeading: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
          RouteGenerator.navigationTo(AppRoutes.addNewSupplierInvoiceScreenRoute);
        },
      ),
      body: Consumer<GetSupplierInvoicesController>(
          builder: (context, supplierInvoiceController, _){
            if(supplierInvoiceController.getSupplierInvoicesIsLoading){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if(supplierInvoiceController.getSupplierInvoicesErrorMessage.isNotEmpty){
              return Center(
                child: Text(supplierInvoiceController.getSupplierInvoicesErrorMessage),
              );
            }
            if(supplierInvoiceController.gettingSupplierInvoices == null || supplierInvoiceController.gettingSupplierInvoices!.isEmpty){
              return const Center(
                child: Text('No Invoices available'),
              );
            }
            else{
              return ListView.separated(
                itemBuilder: (context, index) {
                  final invoice = supplierInvoiceController.gettingSupplierInvoices![index];
                  return InvoiceListTile(invoice: invoice!,);

                  //   ListTile(
                  //   title: Text('تاريخ الفاتوره : ${intl.DateFormat('yyyy-MM-dd').format(DateTime.parse(invoice?.invDate ?? '0000-00-00'))}'),
                  //   subtitle: Text('${invoice?.supplier?.supplierName ?? ''}     ${invoice?.supplier?.company?.companyName ?? ''}'),
                  //   trailing: IconButton(
                  //     onPressed: (){
                  //       // showDialog(
                  //       //   context: context,
                  //       //   builder: (context) => EditSupplierDialog(supplier: supplier),
                  //       // );
                  //     },
                  //     icon: const Icon(Icons.edit),
                  //   ),
                  //   leading: Text(invoice?.id.toString()?? ''),
                  //   onLongPress: () async {
                  //     showDialog(
                  //       context: context,
                  //       builder: (context) {
                  //         return AlertDialog(
                  //           title: const Text('حذف فاتوره'),
                  //           content: Text('${invoice.toString()}هل تريد حذف الفاتوره : '),
                  //           actions: [
                  //             TextButton(
                  //               onPressed: () => Navigator.of(context).pop(),
                  //               child: const Text('Cancel'),
                  //             ),
                  //             // ElevatedButton(
                  //             //   onPressed: ()async{
                  //             //     final deleteSupplierController = Provider.of<DeleteSupplierController>(context, listen: false);
                  //             //     await deleteSupplierController.deleteSupplier(supplier.id!);
                  //             //     Provider.of<SupplierController>(context, listen: false).getSupplier(const NoParameters());
                  //             //     if (deleteSupplierController.deleteSupplierResult != null) {
                  //             //       Navigator.of(context).pop();
                  //             //       ScaffoldMessenger.of(context).showSnackBar(
                  //             //         SnackBar(
                  //             //           content: Text(
                  //             //             deleteSupplierController.deleteSupplierErrorMessage +
                  //             //                 'deleted successfully',
                  //             //           ),
                  //             //         ),
                  //             //       );
                  //             //     } else {
                  //             //       ScaffoldMessenger.of(context).showSnackBar(
                  //             //         SnackBar(
                  //             //             content: Text(deleteSupplierController
                  //             //                 .deleteSupplierErrorMessage)),
                  //             //       );
                  //             //     }
                  //             //   },
                  //             //   child: Text('حذف'),
                  //             // ),
                  //           ],
                  //         );
                  //       },
                  //     );
                  //   },
                  //   onTap: (){
                  //     RouteGenerator.navigationTo(
                  //       AppRoutes.supplierInvoiceDetailsScreenRoute,
                  //       arguments: invoice?.id,
                  //     );
                  //   },
                  // );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: supplierInvoiceController.gettingSupplierInvoices!.length,
              );
            }
          },
        )
    );
  }
}
