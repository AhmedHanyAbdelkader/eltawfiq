import 'package:eltawfiq_suppliers/authentication/domain/entities/role_entity.dart';
import 'package:eltawfiq_suppliers/authentication/domain/entities/user_entity.dart';
import 'package:eltawfiq_suppliers/authentication/domain/use_cases/add_new_user_use_case.dart';
import 'package:eltawfiq_suppliers/authentication/domain/use_cases/edit_user_use_case.dart';
import 'package:eltawfiq_suppliers/authentication/presentation/controllers/add_new_user_controller.dart';
import 'package:eltawfiq_suppliers/authentication/presentation/controllers/delete_user_controller.dart';
import 'package:eltawfiq_suppliers/authentication/presentation/controllers/edit_user_controller.dart';
import 'package:eltawfiq_suppliers/authentication/presentation/controllers/roles_controller.dart';
import 'package:eltawfiq_suppliers/authentication/presentation/controllers/users_controller.dart';
import 'package:eltawfiq_suppliers/core/resources/size_manager.dart';
import 'package:eltawfiq_suppliers/core/resources/string_manager.dart';
import 'package:eltawfiq_suppliers/core/router/app_router.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UsersController>(context, listen: false).getUsers(const NoParameters());
      Provider.of<RolesController>(context, listen: false).getRoles(const NoParameters());
    });
  }

  @override
  Widget build(BuildContext context) {
    final deleteUserController = Provider.of<DeleteUserController>(context, listen: false);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(StringManager.users),
          actions: [
            PopupMenuButton<String>(
                itemBuilder: (context){
                  return {StringManager.role}.map((choice){
                    return PopupMenuItem<String>(
                      value: choice,
                        child: Text(choice),
                      onTap: (){
                        RouteGenerator.navigationTo(AppRoutes.rolesScreenRoute);
                      },
                    );
                  }).toList();
                },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            showDialog(
                context: context,
                builder: (context)=> const AddUserDialog(),
            );
          },
          child: const Icon(Icons.add),
        ),
        body: Consumer<UsersController>(
          builder: (context, usersController , _){
            if (usersController.getUsersIsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            else if (usersController.getUsersErrorMessage.isNotEmpty) {
              return Center(
                child: Text(usersController.getUsersErrorMessage),
              );
            }
            else if (usersController.gettingUsers == null || usersController.gettingUsers!.isEmpty) {
              return const Center(
                child: Text('No users available'),
              );
            }
            else{
              return ListView.separated(
                itemBuilder: (context, index) {
                  final user = usersController.gettingUsers![index];
                  return ListTile(
                    title: Text('${user.userRoleEntity?.role.toString()}      ${user.name.toString()}'),
                    subtitle: Text(user.email?? ''),
                    leading: Text(user.id.toString()),
                    onLongPress: () async {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('حذف مستخدم'),
                            content: Text('${user.props}هل تريد حذف المستخدم : '),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: ()async{
                                  await deleteUserController.deleteUser(user.id);
                                  Provider.of<UsersController>(context, listen: false).getUsers(const NoParameters());
                                  if (deleteUserController.deleteUserResult != null) {
                                    Navigator.of(context).pop();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          '${deleteUserController.deleteUserErrorMessage}deleted successfully',
                                        ),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(deleteUserController
                                              .deleteUserErrorMessage)),
                                    );
                                  }
                                },
                                child: deleteUserController.deleteUserIsLoading
                                    ? const CircularProgressIndicator.adaptive()
                                    : const Text('حذف'),
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
                              EditUserDialog(user: user),
                        );
                      },
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: usersController.gettingUsers!.length,
              );
            }
          },
        ),
      ),
    );
  }

}

class EditUserDialog extends StatefulWidget{
  const EditUserDialog({super.key, required this.user});
  final UserEntity user;

  @override
  State<EditUserDialog> createState() => _EditUserDialogState();
}

class _EditUserDialogState extends State<EditUserDialog> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RolesController>(context, listen: false).getRoles(const NoParameters());
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController userNameController = TextEditingController(text:  widget.user.name);
    final TextEditingController userPasswordController = TextEditingController(text:  widget.user.password);
    final TextEditingController userEmailController = TextEditingController(text:  widget.user.email);
    final TextEditingController userPhoneController = TextEditingController(text:  widget.user.phone);
    final TextEditingController userRoleIdController = TextEditingController(text: widget.user.userRoleEntity?.id.toString());
    final TextEditingController userRoleNameController = TextEditingController(text: widget.user.userRoleEntity?.role ?? '');
    final editUserController = Provider.of<EditUserController>(context, listen: false);
    final formKey = GlobalKey<FormState>();
    return AlertDialog(
      title: const Text('Edit User'),
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: userNameController,
                decoration: const InputDecoration(labelText: 'User Name'),
                validator: (value) =>
                value!.isEmpty ? 'Please enter user name' : null,
              ),
              TextFormField(
                controller: userPasswordController,
                decoration: const InputDecoration(labelText: 'User Password'),
                validator: (value) =>
                value!.isEmpty ? 'Please enter user password' : null,
              ),
              TextFormField(
                controller: userEmailController,
                decoration: const InputDecoration(labelText: 'User Email'),
                validator: (value) =>
                value!.isEmpty ? 'Please enter user email' : null,
              ),
              TextFormField(
                controller: userPhoneController,
                decoration: const InputDecoration(labelText: 'User Phone'),
                validator: (value) =>
                value!.isEmpty ? 'Please enter user phone' : null,
              ),
              Consumer<RolesController>(
                builder: (context,  rolesController, _){
                  return TypeAheadFormField<RoleEntity>(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: userRoleNameController,
                      decoration: const InputDecoration(labelText: 'Role'),
                    ),
                    onSuggestionSelected: (RoleEntity suggestion) {
                      userRoleIdController.text = suggestion.id.toString();
                      userRoleNameController.text = suggestion.role;
                    },
                    validator: (value) => value!.isEmpty ? 'Please select Role' : null,

                    itemBuilder: (context, RoleEntity suggestion) {
                      return ListTile(
                        title: Text(suggestion.role),
                      );
                    },
                    suggestionsCallback: (pattern) {
                      return rolesController.gettingRoles != null
                          ? rolesController.gettingRoles!.where((role) => role.role.contains(pattern))
                          : [];
                    },
                  );
                },
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
              await editUserController.editUser(
                EditUserParameters(
                  id: widget.user.id,
                  name: userNameController.text,
                  password: userPasswordController.text,
                  email: userEmailController.text,
                  phone: userPhoneController.text,
                  roleId: int.parse(userRoleIdController.text),
                ),
              );
              Provider.of<UsersController>(context, listen: false).getUsers(const NoParameters());
              if (editUserController.editUserResult != null) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${editUserController.editUserErrorMessage}edited successfully',
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(editUserController.editUserErrorMessage)),
                );
              }
            }
          },
          child: editUserController.editUserIsLoading
              ? const CircularProgressIndicator.adaptive()
              : const Text('Edit'),
        ),
      ],
    );
  }
}





class AddUserDialog extends StatefulWidget {
  const AddUserDialog({super.key});

  @override
  _AddUserDialogState createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<AddUserDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userPhoneController = TextEditingController();
  final TextEditingController _userPasswordController = TextEditingController();
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _userRoleNameController = TextEditingController();
  final TextEditingController _userRoleIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final addNewUserController = Provider.of<AddNewUserController>(context, listen: false);
    return AlertDialog(
      title: const Text('Add New User'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _userNameController,
                decoration: const InputDecoration(labelText: 'User Name'),
                validator: (value) => value!.isEmpty ? 'Please enter User name' : null,
              ),
              const SizedBox(height: SizeManager.s_16,),
              TextFormField(
                controller: _userPasswordController,
                decoration: const InputDecoration(labelText: 'User Password'),
                validator: (value) => value!.isEmpty ? 'Please enter User password' : null,
              ),
              const SizedBox(height: SizeManager.s_16,),
              TextFormField(
                controller: _userEmailController,
                decoration: const InputDecoration(labelText: 'User Email'),
                validator: (value) => value!.isEmpty ? 'Please enter User email' : null,
              ),
              const SizedBox(height: SizeManager.s_16,),
              TextFormField(
                controller: _userPhoneController,
                decoration: const InputDecoration(labelText: 'User Phone'),
                validator: (value) => value!.isEmpty ? 'Please enter User phone' : null,
              ),
              const SizedBox(height: SizeManager.s_16,),
              Consumer<RolesController>(
                  builder: (context, rolesController, _){
                    return TypeAheadField<RoleEntity>(
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: _userRoleNameController,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: (){
                              _userRoleNameController.clear();
                              _userRoleIdController.clear();
                            },
                            icon: const Icon(Icons.delete_forever),
                          ),
                          label: const Text('اختر الدور/ الصلاحيه'),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      suggestionsCallback: (String pattern) async {
                        if (rolesController.gettingRoles == null) return [];
                        return rolesController.gettingRoles!.where(
                              (role) => role.role.contains(pattern),
                        ).toList();
                      },
                      itemBuilder: (context, role) {
                        return ListTile(
                          title: Text(role.role.toString(),textAlign: TextAlign.end),
                          //subtitle: Text(company. ?? ''),
                        );
                      },
                      onSuggestionSelected: (suggestion) {
                        _userRoleNameController.text = suggestion.role.toString();
                        _userRoleIdController.text = suggestion.id.toString();
                      },
                    );
                  },
              ),
              const SizedBox(height: SizeManager.s_16,),
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
              await addNewUserController.addNewUser(
                AddNewUserParameters(
                    name: _userNameController.text,
                    email: _userEmailController.text,
                    password: _userPasswordController.text,
                    phone: _userPhoneController.text,
                    roleId: int.parse(_userRoleIdController.text),
                ),
              );
              if (addNewUserController.addNewUserResult != null) {
                Provider.of<UsersController>(context, listen: false).getUsers(const NoParameters());
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${addNewUserController.addNewUserErrorMessage}created successfully',),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(addNewUserController.addNewUserErrorMessage)),
                );
              }
            }
          },
          child:addNewUserController.addNewUserIsLoading
              ? const CircularProgressIndicator.adaptive()
              : const Text('Add'),
        ),
      ],
    );
  }
}