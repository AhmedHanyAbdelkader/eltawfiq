
import 'package:eltawfiq_suppliers/core/resources/string_manager.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/section_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/section/section_suppliers_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/widgets/suppliers_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionSuppliersScreen extends StatefulWidget {
  const SectionSuppliersScreen({super.key, required this.section});
  final SectionEntity section;
  @override
  State<SectionSuppliersScreen> createState() => _SectionSuppliersScreenState();
}

class _SectionSuppliersScreenState extends State<SectionSuppliersScreen> {


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchData();
  }

  _fetchData()async{
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SectionSupplierController>(context, listen: false).getSuppliers(widget.section.id!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text(StringManager.suppliers),
        automaticallyImplyLeading: true,
      ),
      body: Consumer<SectionSupplierController>(
        builder: (context, sectionSuppliersController, _){
          if(sectionSuppliersController.getSectionSuppliersIsLoading){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if(sectionSuppliersController.getSectionSuppliersErrorMessage.isNotEmpty){
            return Center(
              child: Text(sectionSuppliersController.getSectionSuppliersErrorMessage),
            );
          }
          if(sectionSuppliersController.gettingSectionSuppliers == null || sectionSuppliersController.gettingSectionSuppliers!.isEmpty){
            return const Center(
              child: Text('No Suppliers available'),
            );
          }
          else{
            return SuppliersListView(suppliers: sectionSuppliersController.gettingSectionSuppliers);
          }
        },
      ),
    );
  }

}
