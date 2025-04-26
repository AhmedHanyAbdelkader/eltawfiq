import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/section/add_new_section_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/section/add_new_section_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/section/sections_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddSectionDialog extends StatefulWidget {
  const AddSectionDialog({super.key});

  @override
  State<AddSectionDialog> createState() => _AddSectionDialogState();
}

class _AddSectionDialogState extends State<AddSectionDialog> {

  final TextEditingController _sectionNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final addNewSectionController = Provider.of<AddNewSectionController>(context, listen: false);
    return AlertDialog(
      title: const Text('Add New Section'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _sectionNameController,
              decoration: const InputDecoration(labelText: 'Section Name'),
              validator: (value) =>
              value!.isEmpty ? 'Please enter section name' : null,
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
              await addNewSectionController.addNewSection(
                AddNewSectionParameters(
                    sectionName: _sectionNameController.text
                ),
              );
              Provider.of<SectionsController>(context, listen: false).getSections(const NoParameters());
              if (addNewSectionController.addNewSectionResult != null) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${addNewSectionController.addNewSectionErrorMessage}created successfully',
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content:
                      Text(addNewSectionController.addNewSectionErrorMessage)),
                );
              }
            }
          },
          child: addNewSectionController.addNewSectionIsLoading
              ? const CircularProgressIndicator() : const Text('Add'),
        ),
      ],
    );
  }
}