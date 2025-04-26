import 'package:eltawfiq_suppliers/core/resources/string_manager.dart';
import 'package:eltawfiq_suppliers/core/router/app_router.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/supplier_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/supplier/delete_supplier_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/supplier/suppliers_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/widgets/edit_supplier_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SuppliersListView extends StatelessWidget {
  const SuppliersListView({super.key, required this.suppliers});
  final List<SupplierEntity>? suppliers;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        final supplier = suppliers![index];
        return SuppliersListTile(supplier: supplier,);
      },
      separatorBuilder: (context, index) => const Divider(),
      itemCount: suppliers!.length,
    );
  }
}


class SuppliersListTile extends StatelessWidget {
  const SuppliersListTile({super.key, required this.supplier});
  final SupplierEntity supplier;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(supplier.supplierName?? ''),
      subtitle: Text('${supplier.supplierWhatsappNumber}     ${supplier.email}'),
      trailing: IconButton(
        onPressed: (){
          showDialog(
            context: context,
            builder: (context) => EditSupplierDialog(supplier: supplier),
          );
        },
        icon: const Icon(Icons.edit),
      ),
      leading: Text(supplier.id.toString()),
      onLongPress: () async {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('حذف مورد'),
              //content: Text('${supplier.props}هل تريد حذف المورد : '),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(StringManager.cancel),
                ),
                ElevatedButton(
                  onPressed: ()async{
                    final deleteSupplierController = Provider.of<DeleteSupplierController>(context, listen: false);
                    await deleteSupplierController.deleteSupplier(supplier.id!);
                    Provider.of<SupplierController>(context, listen: false).getSuppliers(const NoParameters());
                    if (deleteSupplierController.deleteSupplierResult != null) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${deleteSupplierController.deleteSupplierErrorMessage}deleted successfully',
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(deleteSupplierController.deleteSupplierErrorMessage)),
                      );
                    }
                  },
                  child: const Text(StringManager.delete),
                ),
              ],
            );
          },
        );
      },
      onTap: (){
        if(supplier.isSup == true){
          RouteGenerator.navigationTo(AppRoutes.supplierScreenRoute, arguments: supplier,);
        }else{
          RouteGenerator.navigationTo(AppRoutes.clientScreenRoute, arguments: supplier,);
        }
      },
    );
  }
}
