import 'package:eltawfiq_suppliers/core/resources/string_manager.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/company/add_new_company_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/company/add_new_company_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/company/companies_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCompanyDialog extends StatefulWidget {
  const AddCompanyDialog({super.key});

  @override
  State<AddCompanyDialog> createState() => _AddCompanyDialogState();
}

class _AddCompanyDialogState extends State<AddCompanyDialog> {

  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _companyDescribtionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final _companyNameFocusNode = FocusNode();
  final _companyDescriptionFocusNode = FocusNode();
  final _addCompanyButtonFocusNode = FocusNode();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_companyNameFocusNode);
    });
  }


  @override
  Widget build(BuildContext context) {
    final addNewCompanyController = Provider.of<AddNewCompanyController>(context, listen: false);
    return AlertDialog.adaptive(
      title: const Text('Add New Company'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
              decoration: const InputDecoration(labelText: 'Company Describtion'),
              onEditingComplete: (){
                _companyNameFocusNode.unfocus();
                FocusScope.of(context).requestFocus(_addCompanyButtonFocusNode);
              },
            ),
          ],
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
            if (_formKey.currentState!.validate()) {
              await addNewCompanyController.addNewCompany(
                AddNewCompanyParameters(
                  companyName: _companyNameController.text,
                  companyDescription: _companyDescribtionController.text,
                ),
              );
              Provider.of<CompaniesController>(context, listen: false).getCompanies(const NoParameters());
              if (addNewCompanyController.addNewCompanyResult != null) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${addNewCompanyController.addNewCompanyErrorMessage}created successfully',
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content:
                      Text(addNewCompanyController.addNewCompanyErrorMessage)),
                );
              }
            }
          },
          child: addNewCompanyController.addNewCompanyIsLoading
              ? const CircularProgressIndicator() : const Text(StringManager.add),
        ),
      ],
    );
  }
}