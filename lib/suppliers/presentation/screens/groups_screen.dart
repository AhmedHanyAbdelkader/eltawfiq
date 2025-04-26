import 'package:eltawfiq_suppliers/core/resources/string_manager.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/group_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/group/edit_group_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/group/delete_group_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/group/edit_group_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/group/groups_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/widgets/add_new_group_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupsScreen extends StatefulWidget {
  const GroupsScreen({super.key});

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GroupsController>(context, listen: false).getGroups(const NoParameters());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(StringManager.groups),
          automaticallyImplyLeading: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            showDialog(
                context: context,
                builder: (context) => const AddGroupDialog(),
            );
          },
          child: const Icon(Icons.add),
        ),
        body: Consumer<GroupsController>(
          builder: (context, groupsController, _) {
            if (groupsController.getGroupsIsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            else if (groupsController.getGroupsErrorMessage.isNotEmpty) {
              return Center(
                child: Text(groupsController.getGroupsErrorMessage),
              );
            }
            else if (groupsController.gettingGroups == null || groupsController.gettingGroups!.isEmpty) {
              return const Center(
                child: Text('No Groups available'),
              );
            }
            else {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    final group = groupsController.gettingGroups![index];
                    return ListTile(
                      title: Text(group.groupName?? ''),
                      leading: Text(group.id.toString()),
                      onTap: (){
                        //RouteGenerator.navigationTo(AppRoutes.storesItemsBalancesScreenRoute, arguments: store);
                      },
                      onLongPress: () async {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('حذف مجموعه'),
                              content: Text('${group.props}هل تريد حذف المجموعه : '),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('Cancel'),
                                ),
                                ElevatedButton(
                                  onPressed: ()async{
                                    final deleteGroupController = Provider.of<DeleteGroupController>(context, listen: false);
                                    await deleteGroupController.deleteGroup(group.id!);
                                    Provider.of<GroupsController>(context, listen: false).getGroups(const NoParameters());
                                    if (deleteGroupController.deleteGroupResult != null) {
                                      Navigator.of(context).pop();
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            '${deleteGroupController.deleteGroupErrorMessage}deleted successfully',
                                          ),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(deleteGroupController.deleteGroupErrorMessage)),
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
                                  EditGroupDialog(group: group),
                              );
                        },
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: groupsController.gettingGroups!.length,
                );
            }
          },
        ),
      ),
    );
  }
}

class EditGroupDialog extends StatefulWidget{
  const EditGroupDialog({super.key, required this.group});
  final GroupEntity group;

  @override
  State<EditGroupDialog> createState() => _EditGroupDialogState();
}

class _EditGroupDialogState extends State<EditGroupDialog> {

  late TextEditingController _groupNameController;
  final FocusNode _groupNameFocusNode = FocusNode();
  final FocusNode _editGroupButtomFocusNode = FocusNode();


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _groupNameController = TextEditingController(text:  widget.group.groupName);
      FocusScope.of(context).requestFocus(_groupNameFocusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return AlertDialog(
      title: const Text('Edit Group'),
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                focusNode: _groupNameFocusNode,
                controller: _groupNameController,
                decoration: const InputDecoration(labelText: 'Group Name'),
                validator: (value) => value!.isEmpty ? 'Please enter group name' : null,
                onEditingComplete: (){
                  _groupNameFocusNode.unfocus();
                  FocusScope.of(context).requestFocus(_editGroupButtomFocusNode);
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
          focusNode: _editGroupButtomFocusNode,
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              final editGroupController = Provider.of<EditGroupController>(context, listen: false);
              await editGroupController.editGroups(
                EditGroupParameters(
                  id: widget.group.id,
                  groupName: _groupNameController.text,
                ),
              );
              Provider.of<GroupsController>(context, listen: false).getGroups(const NoParameters());
              if (editGroupController.editGroupResult != null) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${editGroupController.editGroupErrorMessage}edited successfully',
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(editGroupController.editGroupErrorMessage)),
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



