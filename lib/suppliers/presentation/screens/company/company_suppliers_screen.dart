import 'package:eltawfiq_suppliers/core/resources/string_manager.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/company_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/company/company_suppliers_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/widgets/suppliers_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompanySuppliersScreen extends StatefulWidget {
  const CompanySuppliersScreen({super.key, required this.company});
  final CompanyEntity company;
  @override
  State<CompanySuppliersScreen> createState() => _CompanySuppliersScreenState();
}

class _CompanySuppliersScreenState extends State<CompanySuppliersScreen> {


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchData();
  }

  _fetchData()async{
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CompanySupplierController>(context, listen: false).getSuppliers(widget.company.id!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('${StringManager.suppliers} ${widget.company.companyName}'),
        automaticallyImplyLeading: true,
      ),
      body: Consumer<CompanySupplierController>(
        builder: (context, companySuppliersController, _){
          if(companySuppliersController.getCompanySuppliersIsLoading){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if(companySuppliersController.getCompanySuppliersErrorMessage.isNotEmpty){
            return Center(
              child: Text(companySuppliersController.getCompanySuppliersErrorMessage),
            );
          }
          if(companySuppliersController.gettingCompanySuppliers == null || companySuppliersController.gettingCompanySuppliers!.isEmpty){
            return const Center(
              child: Text('No Suppliers available'),
            );
          }
          else{
            return SuppliersListView(suppliers: companySuppliersController.gettingCompanySuppliers);
          }
        },
      ),
    );
  }

}
