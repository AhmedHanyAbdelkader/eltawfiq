import 'package:eltawfiq_suppliers/authentication/domain/entities/role_entity.dart';
import 'package:eltawfiq_suppliers/authentication/domain/use_cases/add_new_role_use_case.dart';
import 'package:eltawfiq_suppliers/authentication/domain/use_cases/edit_role_use_case.dart';
import 'package:eltawfiq_suppliers/authentication/presentation/controllers/add_new_role_controller.dart';
import 'package:eltawfiq_suppliers/authentication/presentation/controllers/delete_role_use_case.dart';
import 'package:eltawfiq_suppliers/authentication/presentation/controllers/edit_role_controller.dart';
import 'package:eltawfiq_suppliers/authentication/presentation/controllers/roles_controller.dart';
import 'package:eltawfiq_suppliers/core/resources/string_manager.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RolesScreen extends StatefulWidget {
  const RolesScreen({super.key});

  @override
  State<RolesScreen> createState() => _RolesScreenState();
}

class _RolesScreenState extends State<RolesScreen> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RolesController>(context, listen: false).getRoles(const NoParameters());
    });
  }

  @override
  Widget build(BuildContext context) {
    final deleteRoleController = Provider.of<DeleteRoleController>(context, listen: false);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(StringManager.role),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            showDialog(
                context: context,
                builder: (context) => const AddRoleAlertDialog(),
            );
          },
          child: const Icon(Icons.add),
        ),
        body: Consumer<RolesController>(
          builder: (context, rolesController, _){
            if (rolesController.getRolesIsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            else if (rolesController.getRolesErrorMessage.isNotEmpty) {
              return Center(
                child: Text(rolesController.getRolesErrorMessage),
              );
            }
            else if (rolesController.gettingRoles == null || rolesController.gettingRoles!.isEmpty) {
              return const Center(
                child: Text('No roles available'),
              );
            }
            else{
              return ListView.separated(
                itemBuilder: (context, index) {
                  final role = rolesController.gettingRoles![index];
                  return ListTile(
                    title: Text(role.role.toString()),
                    leading: Text(role.id.toString()),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: (){
                        showDialog(
                          context: context,
                          builder: (context) =>
                              EditRoleDialog(role: role),
                        );
                      },
                    ),
                    onLongPress: () async {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('حذف دور'),
                            content: Text('${role.props}هل تريد حذف الدور : '),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: ()async{
                                  await deleteRoleController.deleteRole(role.id);
                                  Provider.of<RolesController>(context, listen: false).getRoles(const NoParameters());
                                  if (deleteRoleController.deleteRoleResult != null) {
                                    Navigator.of(context).pop();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          '${deleteRoleController.deleteRoleErrorMessage}deleted successfully',
                                        ),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(deleteRoleController.deleteRoleErrorMessage)),
                                    );
                                  }
                                },
                                child: deleteRoleController.deleteRoleIsLoading
                                    ? const CircularProgressIndicator.adaptive()
                                    : const Text('حذف'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: rolesController.gettingRoles!.length,
              );
            }
          },
        ),
      ),
    );
  }
}

class EditRoleDialog extends StatelessWidget{
  const EditRoleDialog({super.key, required this.role});
  final RoleEntity role;
  
  @override
  Widget build(BuildContext context) {
    final TextEditingController roleNameController = TextEditingController(text:  role.role);
    final editRoleController = Provider.of<EditRoleController>(context, listen: false);
    final formKey = GlobalKey<FormState>();
    return AlertDialog(
      title: const Text('Edit Role'),
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: roleNameController,
                decoration: const InputDecoration(labelText: 'Role Name'),
                validator: (value) =>
                value!.isEmpty ? 'Please enter role name' : null,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              await editRoleController.editRole(
                EditRoleParameters(
                  id: role.id,
                  name: roleNameController.text,
                ),
              );
              Provider.of<RolesController>(context, listen: false).getRoles(const NoParameters());
              if (editRoleController.editRoleResult != null) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${editRoleController.editRoleErrorMessage}edited successfully',
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(editRoleController.editRoleErrorMessage)),
                );
              }
            }
          },
          child: editRoleController.editRoleIsLoading
              ? const CircularProgressIndicator.adaptive()
              : const Text('Edit'),
        ),
      ],
    );
  }
}



class AddRoleAlertDialog extends StatefulWidget {
  const AddRoleAlertDialog({super.key});

  @override
  State<AddRoleAlertDialog> createState() => _AddRoleAlertDialogState();
}

class _AddRoleAlertDialogState extends State<AddRoleAlertDialog> {
  final TextEditingController _roleNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final addNewRoleController = Provider.of<AddNewRoleController>(context, listen: false);
    return  AlertDialog(
      title: const Text('Add New Role'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _roleNameController,
                decoration: const InputDecoration(labelText: 'Role Name'),
                validator: (value) => value!.isEmpty ? 'Please enter role name' : null,
              ),
            ],
          ),
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
              await addNewRoleController.addNewRole(
                AddNewRoleParameters(
                  name: _roleNameController.text,
                ),
              );
              if (addNewRoleController.addNewRoleResult != null) {
                Provider.of<RolesController>(context, listen: false).getRoles(const NoParameters());
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${addNewRoleController.addNewRoleErrorMessage}created successfully',),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(addNewRoleController.addNewRoleErrorMessage)),
                );
              }
            }
          },
          child: addNewRoleController.addNewRoleIsLoading
              ? const CircularProgressIndicator.adaptive()
              : const Text('Add'),
        ),
      ],
    );
  }
}
