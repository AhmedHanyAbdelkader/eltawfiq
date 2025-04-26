import 'package:cached_network_image/cached_network_image.dart';
import 'package:eltawfiq_suppliers/core/app/functions.dart';
import 'package:eltawfiq_suppliers/core/resources/string_manager.dart';
import 'package:eltawfiq_suppliers/core/router/app_router.dart';
import 'package:eltawfiq_suppliers/core/shared_widgets/full_network_image.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/supplier_invoice_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/invoice/invoice_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' as intl;

class SuppliersInvoices extends StatefulWidget {
  const SuppliersInvoices({super.key});

  @override
  State<SuppliersInvoices> createState() => _SuppliersInvoicesState();
}

class _SuppliersInvoicesState extends State<SuppliersInvoices> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<InvoiceController>(context, listen: false).getInvoices(const NoParameters());
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text(StringManager.invoices),
        automaticallyImplyLeading: true,
      ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: (){
            RouteGenerator.navigationTo(AppRoutes.addNewSupplierInvoiceScreenRoute);
          },
        ),
      body: Consumer<InvoiceController>(
          builder: (context, invoiceController, _){
            if(invoiceController.getInvoicesIsLoading){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if(invoiceController.getInvoicesErrorMessage.isNotEmpty){
              debugPrint(invoiceController.getInvoicesErrorMessage);
              return Center(
                child: Text(invoiceController.getInvoicesErrorMessage),
              );
            }
            if (invoiceController.gettingInvoices == null || invoiceController.gettingInvoices!.isEmpty) {
              return const Center(
                child: Text('No Invoices available'),
              );
            }
            else{
              return ListView.separated(
                itemBuilder: (context, index) {
                  final invoice = invoiceController.gettingInvoices![index];
                  return InvoiceListTile(invoice: invoice!,);
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: invoiceController.gettingInvoices!.length,
              );
            }
          },
        )
    );
  }
}





class InvoiceListTile extends StatelessWidget {
  const InvoiceListTile({super.key, required this.invoice});
  final SupplierInvoiceEntity invoice;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('تاريخ : ${intl.DateFormat('yyyy-MM-dd').format(DateTime.parse(invoice?.invDate ?? '0000-00-00'))}'),
      subtitle: Text('${invoice?.supplier?.supplierName ?? ''}     ${invoice?.supplier?.company?.companyName ?? ''}'),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(invoice.total.toString()),
          if(invoice.type == 'to client')
            ...[const Text('مبيعات')],
          if(invoice.type == 'from client')
            ...[const Text('مرتجع مبيعات')],
          if(invoice.type == 'to supplier')
            ...[const Text('مرتجع مشتريات')],
          if(invoice.type == 'from supplier')
            ...[const Text(' مشتريات')],
        ],
      ),
      leading: InkWell(
        onTap: () {
          if (invoice!.images != null && invoice.images!.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FullNetworkImageScreen(
                  imageUrl: invoice.images!.first!,
                ),
              ),
            );
          }
        },
        child: CachedNetworkImage(
          width: 100,
          height: 100,
          imageUrl: (invoice!.images != null && invoice.images!.isNotEmpty)
              ? invoice.images!.first!
              : 'https://placehold.co/400', // Placeholder URL
          placeholder: (context, url) {
            if (invoice.images != null && invoice.images!.isNotEmpty) {
              print(invoice.images != null && invoice.images!.isNotEmpty);
            } else {
              print("No image available");
            }
            return const CircularProgressIndicator();
          },
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
      onLongPress: () async {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('حذف فاتوره'),
              //content: Text('${invoice.props}هل تريد حذف الفاتوره : '),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                // ElevatedButton(
                //   onPressed: ()async{
                //     final deleteSupplierController = Provider.of<DeleteSupplierController>(context, listen: false);
                //     await deleteSupplierController.deleteSupplier(supplier.id!);
                //     Provider.of<SupplierController>(context, listen: false).getSuppliers(const NoParameters());
                //     if (deleteSupplierController.deleteSupplierResult != null) {
                //       Navigator.of(context).pop();
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         SnackBar(
                //           content: Text(
                //             deleteSupplierController.deleteSupplierErrorMessage +
                //                 'deleted successfully',
                //           ),
                //         ),
                //       );
                //     } else {
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         SnackBar(
                //             content: Text(deleteSupplierController
                //                 .deleteSupplierErrorMessage)),
                //       );
                //     }
                //   },
                //   child: Text('حذف'),
                // ),
              ],
            );
          },
        );
      },
      onTap: (){
        RouteGenerator.navigationTo(
          AppRoutes.supplierInvoiceDetailsScreenRoute,
          arguments: invoice?.id,
        );
      },
    );
  }
}
