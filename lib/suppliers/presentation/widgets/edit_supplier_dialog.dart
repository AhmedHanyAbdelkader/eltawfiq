import 'package:eltawfiq_suppliers/core/resources/string_manager.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/supplier_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/supplier/edit_supplier_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/supplier/edit_supplier_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/supplier/suppliers_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditSupplierDialog extends StatelessWidget{

  const EditSupplierDialog({super.key, required this.supplier});
  final SupplierEntity supplier;

  @override
  Widget build(BuildContext context) {
    final TextEditingController supplierNameController = TextEditingController(text:  supplier.supplierName);
    final TextEditingController supplierPhoneController = TextEditingController(text:  supplier.supplierWhatsappNumber);
    final TextEditingController supplierEmailController = TextEditingController(text:  supplier.email);
    final formKey = GlobalKey<FormState>();
    return AlertDialog(
      title: const Text('Edit Supplier'),
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: supplierNameController,
                decoration: const InputDecoration(labelText: 'Supplier Name'),
                validator: (value) =>
                value!.isEmpty ? 'Please enter supplier name' : null,
              ),
              TextFormField(
                controller: supplierEmailController,
                decoration: const InputDecoration(labelText: 'Supplier Email'),
                validator: (value) =>
                value!.isEmpty ? 'Please enter supplier email' : null,
              ),
              TextFormField(
                controller: supplierPhoneController,
                decoration: const InputDecoration(labelText: 'Supplier Phone'),
                validator: (value) =>
                value!.isEmpty ? 'Please enter supplier phone' : null,
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
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              final editSupplierController = Provider.of<EditSupplierController>(context, listen: false);
              await editSupplierController.editSupplier(
                EditSupplierParameters(
                  id: supplier.id,
                  supplierName: supplierNameController.text,
                  supplierWhatsappNumber: supplierPhoneController.text,
                  email: supplierEmailController.text,
                ),
              );
              Provider.of<SupplierController>(context, listen: false).getSuppliers(const NoParameters());
              if (editSupplierController.editSupplierResult != null) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${editSupplierController.editSupplierErrorMessage}edited successfully',
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(editSupplierController.editSupplierErrorMessage)),
                );
              }
            }
          },
          child: const Text('Edit'),
        ),
      ],
    );
  }
}