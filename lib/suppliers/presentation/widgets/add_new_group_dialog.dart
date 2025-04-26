import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/group/add_new_group_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/group/add_new_group_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/group/groups_controller.dart';

class AddGroupDialog extends StatefulWidget {
  const AddGroupDialog({super.key});

  @override
  State<AddGroupDialog> createState() => _AddGroupDialogState();
}

class _AddGroupDialogState extends State<AddGroupDialog> {

  final TextEditingController _groupNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FocusNode _groupNameFocusNode = FocusNode();
  final FocusNode _addGroupButtonFocusNode = FocusNode();


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_groupNameFocusNode);
    });
  }


  @override
  Widget build(BuildContext context) {
    final addNewGroupController = Provider.of<AddNewGroupController>(context, listen: false);
    return AlertDialog(
      title: const Text('Add New Group'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              focusNode: _groupNameFocusNode,
              controller: _groupNameController,
              decoration: const InputDecoration(labelText: 'Group Name'),
              validator: (value) => value!.isEmpty ? 'Please enter group name' : null,
              onEditingComplete: (){
                _groupNameFocusNode.unfocus();
                FocusScope.of(context).requestFocus(_addGroupButtonFocusNode);
              },
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
          focusNode: _addGroupButtonFocusNode,
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              await addNewGroupController.addNewGroup(
                AddNewGroupParameters(
                    groupName: _groupNameController.text
                ),
              );
              Provider.of<GroupsController>(context, listen: false).getGroups(const NoParameters());
              if (addNewGroupController.addNewGroupResult != null) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${addNewGroupController.addNewGroupErrorMessage}created successfully',
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content:
                      Text(addNewGroupController.addNewGroupErrorMessage)),
                );
              }
            }
          },
          child: Consumer<AddNewGroupController>(
            builder: (context, addNewGroupController, _){
              return addNewGroupController.addNewGroupIsLoading
                  ? const CircularProgressIndicator.adaptive()
                  : const Text('Add');
            },

          ),
        ),
      ],
    );
  }
}