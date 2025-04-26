import 'package:eltawfiq_suppliers/core/resources/string_manager.dart';
import 'package:eltawfiq_suppliers/core/router/app_router.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/company_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/company/edit_company_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/company/companies_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/company/delete_company_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/company/edit_company_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/widgets/add_new_company_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompaniesScreen extends StatefulWidget {
  const CompaniesScreen({super.key});

  @override
  State<CompaniesScreen> createState() => _StoresScreenState();
}

class _StoresScreenState extends State<CompaniesScreen> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CompaniesController>(context, listen: false).getCompanies(const NoParameters());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(StringManager.companies),
          automaticallyImplyLeading: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            showDialog(
                context: context,
                builder: (context) => const AddCompanyDialog(),
            );
          },
          child: const Icon(Icons.add),
        ),
        body: Consumer<CompaniesController>(
          builder: (context, companiesController, _) {
            if (companiesController.getCompaniesIsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            else if (companiesController.getCompaniesErrorMessage.isNotEmpty) {
              return Center(
                child: Text(companiesController.getCompaniesErrorMessage),
              );
            }
            else if (companiesController.gettingCompanies == null || companiesController.gettingCompanies!.isEmpty) {
              return const Center(
                child: Text('No stores available'),
              );
            }
            else {
              return ListView.separated(
                itemBuilder: (context, index) {
                  final company = companiesController.gettingCompanies![index];
                  return ListTile(
                    title: Text(company.companyName?? ''),
                    subtitle: Text(company.companyDescription?? ''),
                    leading: Text(company.id.toString()),
                    onTap: (){
                      RouteGenerator.navigationTo(AppRoutes.companySuppliersScreen, arguments: company);
                    },
                    onLongPress: () async {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('حذف مخزن'),
                            content: Text('${company.props}هل تريد حذف المخزن : '),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: ()async{
                                  final deleteCompanyController =
                                  Provider.of<DeleteCompanyController>(context, listen: false);
                                  await deleteCompanyController.deleteCompany(company.id!);
                                  Provider.of<CompaniesController>(context, listen: false).getCompanies(const NoParameters());
                                  if (deleteCompanyController.deleteCompanyResult != null) {
                                    Navigator.of(context).pop();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          '${deleteCompanyController.deleteCompanyErrorMessage}deleted successfully',
                                        ),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(deleteCompanyController.deleteCompanyErrorMessage)),
                                    );
                                  }
                                },
                                child: const Text('حذف'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: (){
                        showDialog(
                            context: context,
                            builder: (context) =>
                                EditStoreDialog(company: company),
                            );
                      },
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: companiesController.gettingCompanies!.length,
              );
            }
          },
        ),
      ),
    );
  }
}

class EditStoreDialog extends StatefulWidget{
  const EditStoreDialog({super.key, required this.company});
  final CompanyEntity company;

  @override
  State<EditStoreDialog> createState() => _EditStoreDialogState();
}

class _EditStoreDialogState extends State<EditStoreDialog> {

  late TextEditingController _companyNameController;
  late TextEditingController _companyDescribtionController;
  final _companyNameFocusNode = FocusNode();
  final _companyDescriptionFocusNode = FocusNode();
  final _addCompanyButtonFocusNode = FocusNode();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _companyNameController = TextEditingController(text:  widget.company.companyName);
      _companyDescribtionController = TextEditingController(text:  widget.company.companyDescription);
      FocusScope.of(context).requestFocus(_companyNameFocusNode);
    });
  }


  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return AlertDialog(
      title: const Text('Edit Company'),
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                focusNode: _companyNameFocusNode,
                controller: _companyNameController,
                decoration: const InputDecoration(labelText: 'Company Name'),
                validator: (value) => value!.isEmpty ? 'Please enter company name' : null,
                onEditingComplete: (){
                  _companyNameFocusNode.unfocus();
                  FocusScope.of(context).requestFocus(_companyDescriptionFocusNode);
                },
              ),
              TextFormField(
                focusNode: _companyDescriptionFocusNode,
                controller: _companyDescribtionController,
                decoration: const InputDecoration(labelText: 'Company Description'),
                onEditingComplete: (){
                  _companyDescriptionFocusNode.unfocus();
                  FocusScope.of(context).requestFocus(_addCompanyButtonFocusNode);
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(StringManager.cancel),
        ),
        ElevatedButton(
          focusNode: _addCompanyButtonFocusNode,
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              final editCompanyController = Provider.of<EditCompanyController>(context, listen: false);
              await editCompanyController.editCompany(
                EditCompanyParameters(
                  id: widget.company.id,
                  companyName: _companyNameController.text,
                  companyDescription: _companyDescribtionController.text
                ),
              );
              Provider.of<CompaniesController>(context, listen: false).getCompanies(const NoParameters());
              if (editCompanyController.editCompanyResult != null) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${editCompanyController.editCompanyErrorMessage}edited successfully',
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(editCompanyController.editCompanyErrorMessage)),
                );
              }
            }
          },
          child: const Text(StringManager.edit),
        ),
      ],
    );
  }
}



