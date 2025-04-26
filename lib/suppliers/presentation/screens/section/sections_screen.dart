import 'package:eltawfiq_suppliers/core/resources/string_manager.dart';
import 'package:eltawfiq_suppliers/core/router/app_router.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/section_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/section/edit_section_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/section/delete_section_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/section/edit_section_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/section/sections_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/widgets/add_new_section_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionsScreen extends StatefulWidget {
  const SectionsScreen({super.key});

  @override
  State<SectionsScreen> createState() => _SectionsScreenState();
}

class _SectionsScreenState extends State<SectionsScreen> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SectionsController>(context, listen: false).getSections(const NoParameters());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(StringManager.sections),
          automaticallyImplyLeading: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            showDialog(
                context: context,
                builder: (context) => const AddSectionDialog(),
            );
          },
          child: const Icon(Icons.add),
        ),
        body: Consumer<SectionsController>(
          builder: (context, sectionsController, _) {
            if (sectionsController.getSectionsIsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            else if (sectionsController.getSectionsErrorMessage.isNotEmpty) {
              return Center(
                child: Text(sectionsController.getSectionsErrorMessage),
              );
            }
            else if (sectionsController.gettingSections == null || sectionsController.gettingSections!.isEmpty) {
              return const Center(
                child: Text('No Sections available'),
              );
            }
            else {
              return ListView.separated(
                itemBuilder: (context, index) {
                  final section = sectionsController.gettingSections![index];
                  return SectionListTile(section: section,);
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: sectionsController.gettingSections!.length,
              );
            }
          },
        ),
      ),
    );
  }
}


class SectionListTile extends StatelessWidget {
  const SectionListTile({super.key, required this.section});
  final SectionEntity section;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(section.sectionName?? ''),
      leading: Text(section.id.toString()),
      onTap: (){
        RouteGenerator.navigationTo(AppRoutes.sectionSuppliersScreen, arguments: section);
      },
      onLongPress: () async {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('حذف التصنيف'),
              content: Text('${section.toString()}هل تريد حذف التصنيف : '),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: ()async{
                    final deleteSectionController = Provider.of<DeleteSectionController>(context, listen: false);
                    await deleteSectionController.deleteSection(section.id!);
                    Provider.of<SectionsController>(context, listen: false).getSections(const NoParameters());
                    if (deleteSectionController.deleteSectionResult != null) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${deleteSectionController.deleteSectionErrorMessage}deleted successfully',
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(deleteSectionController.deleteSectionErrorMessage)),
                      );
                    }
                  },
                  child: const Text(StringManager.delete),
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
                EditSectionDialog(section: section),
          );
        },
      ),
    );
  }
}


class EditSectionDialog extends StatelessWidget{
  const EditSectionDialog({super.key, required this.section});
  final SectionEntity section;
  @override
  Widget build(BuildContext context) {
    final TextEditingController sectionNameController = TextEditingController(
      text:  section.sectionName
    );
    final formKey = GlobalKey<FormState>();
    return AlertDialog(
      title: const Text('Edit Section'),
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: sectionNameController,
                decoration: const InputDecoration(labelText: 'Section Name'),
                validator: (value) =>
                value!.isEmpty ? 'Please enter section name' : null,
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
              final editSectionController = Provider.of<EditSecttionController>(context, listen: false);
              await editSectionController.editSections(
                UpdateSectionParameters(
                  id: section.id,
                  sectionName: sectionNameController.text,
                  sectionImageUrl: section.sectionImageUrl,
                  order: section.order,
                ),
              );
              Provider.of<SectionsController>(context, listen: false).getSections(const NoParameters());
              if (editSectionController.editSectionResult != null) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${editSectionController.editSectionErrorMessage}edited successfully',
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(editSectionController.editSectionErrorMessage)),
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



