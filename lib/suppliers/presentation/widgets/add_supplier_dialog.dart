import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/supplier/add_new_supplier_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/supplier/add_new_supplier_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/supplier/suppliers_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddSupplierDialog extends StatefulWidget {
  const AddSupplierDialog({super.key});

  @override
  _AddSupplierDialogState createState() => _AddSupplierDialogState();
}

class _AddSupplierDialogState extends State<AddSupplierDialog> {
  final TextEditingController _supplierNameController = TextEditingController();
  final TextEditingController _supplierPhoneController = TextEditingController();
  final TextEditingController _supplierEmailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final addNewSupplierController = Provider.of<AddNewSupplierController>(context, listen: false);
    return AlertDialog(
      title: const Text('Add New Supplier'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _supplierNameController,
              decoration: const InputDecoration(labelText: 'Supplier Name'),
              validator: (value) =>
              value!.isEmpty ? 'Please enter supplier name' : null,
            ),
            TextFormField(
              controller: _supplierPhoneController,
              decoration: const InputDecoration(labelText: 'Supplier Phone'),
              validator: (value) =>
              value!.isEmpty ? 'Please enter supplier phone' : null,
            ),
            TextFormField(
              controller: _supplierEmailController,
              decoration: const InputDecoration(labelText: 'Supplier Email'),
              validator: (value) =>
              value!.isEmpty ? 'Please enter supplier email' : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              await addNewSupplierController.addNewSupplier(
                AddNewSupplierParameter(
                  issupp: true,
                  supplierName: _supplierNameController.text,
                  supplierWhatsappNumber: _supplierPhoneController.text,
                  email: _supplierEmailController.text,
                ),
              );
              Provider.of<SupplierController>(context, listen: false)
                  .getSuppliers(const NoParameters());
              if (addNewSupplierController.addNewSupplierResult != null) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${addNewSupplierController.addNewSupplierErrorMessage}created successfully',
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content:
                      Text(addNewSupplierController.addNewSupplierErrorMessage)),
                );
              }
            }
          },
          child: addNewSupplierController.addNewSupplierIsLoading
              ? const CircularProgressIndicator() : const Text('Add'),
        ),
      ],
    );
  }
}