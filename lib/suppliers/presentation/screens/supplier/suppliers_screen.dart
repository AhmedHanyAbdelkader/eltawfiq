import 'package:eltawfiq_suppliers/core/resources/string_manager.dart';
import 'package:eltawfiq_suppliers/core/router/app_router.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/supplier/suppliers_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/widgets/suppliers_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';

class SuppliersScreen extends StatefulWidget {
  const SuppliersScreen({super.key});

  @override
  State<SuppliersScreen> createState() => _SuppliersScreenState();
}

class _SuppliersScreenState extends State<SuppliersScreen> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SupplierController>(context, listen: false).getSuppliers(const NoParameters());
    });
  }


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(StringManager.suppliers),
          automaticallyImplyLeading: true,
        ),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.add_event,
          tooltip: 'اضافة مورد جديد',
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

        body: Consumer<SupplierController>(
          builder: (context, supplierController, _){
            if(supplierController.getSuppliersIsLoading){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if(supplierController.getSuppliersErrorMessage.isNotEmpty){
              return Center(
                child: Text(supplierController.getSuppliersErrorMessage),
              );
            }
            if(supplierController.gettingSuppliers == null || supplierController.gettingSuppliers!.isEmpty){
              return const Center(
                child: Text('No Suppliers available'),
              );
            }
            else{
              return SuppliersListView(suppliers: supplierController.gettingSuppliers,);
            }
          },
        ),
      ),
    );
  }

}






