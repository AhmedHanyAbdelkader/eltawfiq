import 'dart:developer';

import 'package:eltawfiq_suppliers/controller/app_state_provider.dart';
import 'package:eltawfiq_suppliers/core/resources/string_manager.dart';
import 'package:eltawfiq_suppliers/core/router/app_router.dart';
import 'package:eltawfiq_suppliers/core/shared_widgets/custom_elevated_button.dart';
import 'package:eltawfiq_suppliers/core/shared_widgets/custom_text_field.dart';
import 'package:eltawfiq_suppliers/core/use_case/base_use_case.dart';
import 'package:eltawfiq_suppliers/model/company_model.dart';
import 'package:eltawfiq_suppliers/model/group_model.dart';
import 'package:eltawfiq_suppliers/model/section_model.dart';
import 'package:eltawfiq_suppliers/model/supplier_model.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/bank_info_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/company_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/group_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/phone_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/entities/section_entity.dart';
import 'package:eltawfiq_suppliers/suppliers/domain/use_cases/supplier/add_new_supplier_use_case.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/clients/clients_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/company/companies_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/group/groups_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/section/sections_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/supplier/add_new_supplier_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/controllers/supplier/suppliers_controller.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/widgets/add_new_company_dialog.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/widgets/add_new_group_dialog.dart';
import 'package:eltawfiq_suppliers/suppliers/presentation/widgets/add_new_section_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

class AddClientFromContcts extends StatefulWidget {
  const AddClientFromContcts({super.key, required this.contact});

  final Contact contact;

  @override
  State<AddClientFromContcts> createState() => _AddClientFromContctsState();
}

class _AddClientFromContctsState extends State<AddClientFromContcts> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController supplierNameController = TextEditingController();
  final TextEditingController supplierPositionController = TextEditingController();
  final TextEditingController supplierCompanyNameController = TextEditingController();
  final TextEditingController supplierCompanyIdController = TextEditingController();
  final TextEditingController supplierSectionIdController = TextEditingController();
  final TextEditingController supplierSectionNameController = TextEditingController();
  final TextEditingController supplierGroupIdController = TextEditingController();
  final TextEditingController supplierGroupNameController = TextEditingController();
  final TextEditingController supplierFullNameController = TextEditingController();
  final TextEditingController supplierPostalCodeController = TextEditingController();
  final TextEditingController supplierPhoneController = TextEditingController();
  final TextEditingController supplierWhatsAppController = TextEditingController();
  final TextEditingController supplierAddressController = TextEditingController();
  final TextEditingController supplierLocationLinkController = TextEditingController();
  final TextEditingController supplierEmailController = TextEditingController();
  final TextEditingController supplierFacebookController = TextEditingController();
  final TextEditingController supplierNoteController = TextEditingController();


  final List<TextEditingController> _controllers = [
    TextEditingController(text: ''),
  ];
  void _addPhoneField() {
    setState(() {
      _controllers.add(TextEditingController());
    });
  }
  void _deletePhoneField(int index) {
    setState(() {
      _controllers.removeAt(index);
    });
  }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(Duration.zero, (){
        Provider.of<CompaniesController>(context, listen: false).getCompanies(const NoParameters());
        Provider.of<SectionsController>(context, listen: false).getSections(const NoParameters());
        Provider.of<GroupsController>(context, listen: false).getGroups(const NoParameters());
      });
    });
    _addBankField();
  }


  final List<TextEditingController> _bankNameControllers = [];
  final List<TextEditingController> _bankAccountControllers = [];
  final List<FocusNode> _bankNameFocusNodes = [];
  final List<FocusNode> _bankAccountFocusNodes = [];
  List<Widget> _bankFields = [];

  void _addBankField() {
    TextEditingController bankNameController = TextEditingController();
    TextEditingController bankAccountController = TextEditingController();
    FocusNode bankNameFocusNode = FocusNode();
    FocusNode bankAccountFocusNode = FocusNode();

    bankNameFocusNode.addListener(() {
      if (bankNameFocusNode.hasFocus && _bankNameControllers.last == bankNameController) {
        //_addBankField();
      }
    });

    bankAccountFocusNode.addListener(() {
      if (bankAccountFocusNode.hasFocus && _bankAccountControllers.last == bankAccountController) {
        //_addBankField();
      }
    });

    _bankNameControllers.add(bankNameController);
    _bankAccountControllers.add(bankAccountController);
    _bankNameFocusNodes.add(bankNameFocusNode);
    _bankAccountFocusNodes.add(bankAccountFocusNode);

    setState(() {
      _bankFields.add(_buildBankField(bankNameController, bankAccountController, bankNameFocusNode, bankAccountFocusNode));
    });
  }

  Widget _buildBankField(TextEditingController bankNameController, TextEditingController bankAccountController, FocusNode bankNameFocusNode, FocusNode bankAccountFocusNode) {
    int index = _bankNameControllers.indexOf(bankNameController);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: bankNameController,
                  focusNode: bankNameFocusNode,
                  decoration: const InputDecoration(
                    labelText: 'اسم البنك',
                  ),
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: bankAccountController,
                  focusNode: bankAccountFocusNode,
                  decoration: const InputDecoration(
                    labelText: 'رقم الحساب',
                  ),
                  keyboardType: TextInputType.text,
                ),
              ],
            ),
          ),
          if (_bankFields.length > 1) // Show delete icon only if there's more than one bank field
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _removeBankField(index),
            ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              setState(() {
                _addNewBankField();
              });
            },
          ),
        ],
      ),
    );
  }

  void _removeBankField(int index) {
    if (index >= 0 && index < _bankNameControllers.length) {
      setState(() {
        _bankNameControllers[index].dispose();
        _bankAccountControllers[index].dispose();
        _bankNameFocusNodes[index].dispose();
        _bankAccountFocusNodes[index].dispose();
        _bankNameControllers.removeAt(index);
        _bankAccountControllers.removeAt(index);
        _bankNameFocusNodes.removeAt(index);
        _bankAccountFocusNodes.removeAt(index);
        _bankFields.removeAt(index);

        // Update the remaining bank fields
        _bankFields = List.generate(_bankNameControllers.length, (i) {
          return _buildBankField(
            _bankNameControllers[i],
            _bankAccountControllers[i],
            _bankNameFocusNodes[i],
            _bankAccountFocusNodes[i],
          );
        });
      });
    }
  }

  void _addNewBankField() {
    _addBankField();
  }

  @override
  void dispose() {
    supplierNameController.dispose();
    supplierPositionController.dispose();
    supplierFullNameController.dispose();
    supplierPhoneController.dispose();
    supplierWhatsAppController.dispose();
    for (var controller in _bankNameControllers) {
      controller.dispose();
    }
    for (var controller in _bankAccountControllers) {
      controller.dispose();
    }
    for (var focusNode in _bankNameFocusNodes) {
      focusNode.dispose();
    }
    for (var focusNode in _bankAccountFocusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    supplierNameController.text = widget.contact.name?.nickname ?? '';
    supplierPositionController.text = widget.contact.organizations?.isNotEmpty == true ? widget.contact.organizations!.first.title ?? '' : '';
    supplierFullNameController.text = (widget.contact.name?.first ?? '') + ' ' + (widget.contact.name?.middle ?? '') + ' ' + (widget.contact.name?.last ?? '');
    supplierPostalCodeController.text = widget.contact.addresses?.isNotEmpty == true ? widget.contact.addresses!.first.postalCode ?? '' : '';
    _controllers.first.text = widget.contact.phones?.isNotEmpty == true ? widget.contact.phones!.first.normalizedNumber ?? '' : '';
    supplierWhatsAppController.text = widget.contact.phones.length > 1 ? widget.contact.phones!.last.normalizedNumber ?? '' : '';
    supplierAddressController.text = widget.contact.addresses?.isNotEmpty == true ? widget.contact.addresses!.first.address ?? '' : '';
    supplierLocationLinkController.text = widget.contact.organizations?.isNotEmpty == true ? widget.contact.organizations!.first.officeLocation ?? '' : '';
    supplierEmailController.text = widget.contact.emails?.isNotEmpty == true ? widget.contact.emails!.first.address ?? '' : '';
    supplierFacebookController.text = widget.contact.accounts?.isNotEmpty == true ? widget.contact.accounts!.first.name ?? '' : '';
    supplierNoteController.text = widget.contact.notes?.isNotEmpty == true ? widget.contact.notes!.first.note ?? '' : '';

    return Scaffold(
      appBar: AppBar(
        title: const Text(StringManager.addNewSupplier),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text('بيانات العميل',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22
                  ),),
                CustomTextField(
                  textEditingController: supplierNameController,
                  label: StringManager.clientName,
                  keyboardType: TextInputType.name,
                  suffixIcon: const Icon(Icons.person_pin),
                  validator: (String? input) {
                    if (input == null || input.isEmpty) {
                      return StringManager.fieldRequired;
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 8,),
                CustomTextField(
                  textEditingController: supplierFullNameController,
                  label: StringManager.clientFullName,
                  suffixIcon: const Icon(Icons.person),
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(height: 8,),
                CustomTextField(
                  textEditingController: supplierPositionController,
                  label: StringManager.position,
                  keyboardType: TextInputType.text,
                  suffixIcon: const Icon(Icons.work_rounded),
                ),
                const SizedBox(height: 20,),
                Consumer<CompaniesController>(
                  builder: (context, companiesStateProvider, _){
                    return Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: TypeAheadField<CompanyEntity>(
                            textFieldConfiguration: TextFieldConfiguration(
                              controller: supplierCompanyNameController,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: (){
                                    supplierCompanyNameController.clear();
                                    supplierCompanyIdController.clear();
                                  },
                                  icon: const Icon(Icons.delete_forever),
                                ),
                                label: const Text('اضافه لشركة'),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                            suggestionsCallback: (String pattern)async{
                              return companiesStateProvider.gettingCompanies!.where(
                                      (company) => company.companyName!.contains(pattern)
                              ).toList();
                            },
                            itemBuilder: (context, company) {
                              return ListTile(
                                title: Text(company.companyName!),
                                subtitle: Text(company.companyDescription ?? ''),
                              );
                            },
                            onSuggestionSelected: (CompanyEntity? suggestion) {
                              supplierCompanyNameController.text = suggestion!.companyName!;
                              supplierCompanyIdController.text = suggestion.id.toString();
                            },
                          ),
                        ),
                        IconButton(
                          onPressed: (){
                            showDialog(
                              context: context,
                              builder: (context) => const AddCompanyDialog(),
                            );
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 20,),
                Consumer<SectionsController>(
                  builder: (context, sectionsStateProvider, _){
                    return Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: TypeAheadField<SectionEntity>(
                            textFieldConfiguration: TextFieldConfiguration(
                              controller: supplierSectionNameController,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: (){
                                    supplierSectionNameController.clear();
                                    supplierSectionIdController.clear();
                                  },
                                  icon: const Icon(Icons.delete_forever),
                                ),
                                label: const Text('اضافه لتصنيف'),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                            suggestionsCallback: (String pattern)async{
                              return sectionsStateProvider.gettingSections!.where(
                                      (section) => section.sectionName!.contains(pattern)
                              ).toList();
                            },
                            itemBuilder: (context, company) {
                              return ListTile(
                                title: Text(company.sectionName!),
                                //subtitle: Text(company. ?? ''),
                              );
                            },
                            onSuggestionSelected: (SectionEntity? suggestion) {
                              supplierSectionNameController.text = suggestion!.sectionName!;
                              supplierSectionIdController.text = suggestion.id.toString();
                            },
                          ),
                        ),
                        IconButton(
                          onPressed: (){
                            showDialog(
                              context: context,
                              builder: (context) => const AddSectionDialog(),
                            );
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 20,),
                Consumer<GroupsController>(
                  builder: (context, groupsStateProvider, _){
                    return Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: TypeAheadField<GroupEntity>(
                            textFieldConfiguration: TextFieldConfiguration(
                              controller: supplierGroupNameController,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: (){
                                    supplierGroupNameController.clear();
                                    supplierGroupIdController.clear();
                                  },
                                  icon: const Icon(Icons.delete_forever),
                                ),
                                label: const Text('اضافه لمجموعه'),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                            suggestionsCallback: (String pattern)async{
                              return groupsStateProvider.gettingGroups!.where(
                                      (group) => group.groupName!.contains(pattern)
                              ).toList();
                            },
                            itemBuilder: (context, group) {
                              return ListTile(
                                title: Text(group.groupName!),
                                //subtitle: Text(company. ?? ''),
                              );
                            },
                            onSuggestionSelected: (GroupEntity? suggestion) {
                              supplierGroupNameController.text = suggestion!.groupName!;
                              supplierGroupIdController.text = suggestion.id.toString();
                            },
                          ),
                        ),
                        IconButton(
                          onPressed: (){
                            showDialog(
                              context: context,
                              builder: (context) => const AddGroupDialog(),
                            );
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('ارقام الموبيل'),
                    IconButton(
                      onPressed: _addPhoneField,
                      icon: const Icon(Icons.add_circle),
                    ),
                  ],
                ),
                for(int i = 0; i < _controllers.length; i++)Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controllers[i],
                        keyboardType: TextInputType.number, // Set appropriate keyboard type
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _deletePhoneField(i),
                    ),
                  ],
                ),
                const SizedBox(height: 8,),
                CustomTextField(
                  textEditingController: supplierPostalCodeController,
                  label: StringManager.supplierPostalCode,
                  suffixIcon: const Icon(Icons.signpost),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 8,),
                ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  children: _bankFields,
                ),
                const SizedBox(height: 25,),
                const Text('بيانات التواصل',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22
                ),),
                const SizedBox(height: 8,),
                CustomTextField(
                  textEditingController: supplierWhatsAppController,
                  label: StringManager.supplierWhatsAppNumber,
                  keyboardType: TextInputType.phone,
                  suffixIcon: const Icon(Icons.chat),
                  validator: (String? input) {
                    if (input == null || input.isEmpty) {
                      return null;
                    } else if (input.length != 11) {
                      return StringManager.phoneNumberNotValid;
                    } else if (input.length > 11) {
                      return StringManager.phoneNumberNotValid;
                    } else {
                      // Validate if input contains only digits
                      if (int.tryParse(input) == null) {
                        return StringManager.phoneNumberNotValid;
                      }
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 8,),
                CustomTextField(
                  textEditingController: supplierAddressController,
                  label: StringManager.supplierCompanyAddress,
                  keyboardType: TextInputType.streetAddress,
                  suffixIcon: const Icon(Icons.maps_home_work_outlined),
                ),
                const SizedBox(height: 8,),
                CustomTextField(
                  textEditingController: supplierLocationLinkController,
                  label: StringManager.supplierCompanyLocation,
                  keyboardType: TextInputType.url,
                  suffixIcon: const Icon(Icons.not_listed_location_rounded),
                  isObsecuredText: false,
                ),
                const SizedBox(height: 8,),
                CustomTextField(
                  textEditingController: supplierEmailController,
                  label: StringManager.supplierEmail,
                  keyboardType: TextInputType.emailAddress,
                  suffixIcon: const Icon(Icons.attach_email_rounded),
                  isObsecuredText: false,
                ),
                const SizedBox(height: 8,),
                CustomTextField(
                  textEditingController: supplierFacebookController,
                  label: StringManager.supplierFacebook,
                  keyboardType: TextInputType.url,
                  suffixIcon: const Icon(Icons.facebook),
                  isObsecuredText: false,
                ),
                const SizedBox(height: 8,),
                CustomTextField(
                  textEditingController: supplierNoteController,
                  label: StringManager.suppliernotes,
                  keyboardType: TextInputType.multiline,
                  suffixIcon: const Icon(Icons.note_add),
                  isObsecuredText: false,

                ),
                const SizedBox(height: 25,),

                Consumer<AddNewSupplierController>(
                  builder: (context, addSupplierController, _) {
                    return Column(
                      children: [
                        if (addSupplierController.addNewSupplierIsLoading)
                          const Center(
                              child: CircularProgressIndicator.adaptive()),

                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              List<PhoneEntity> phoneNumbers = [];
                              if(_controllers.first.text.isNotEmpty){
                                for (var controller in _controllers){
                                  phoneNumbers.add(
                                    PhoneEntity(
                                      phoneNumber: controller.text
                                    )
                                  );
                                }
                              }
                              List<BankInfoEntity> banks=[];
                              if(_bankNameControllers.first.text.isNotEmpty && _bankAccountControllers.first.text.isNotEmpty){
                                for (int i = 0; i < _bankNameControllers.length; i++) {
                                  String bankName = _bankNameControllers[i].text;
                                  String bankAccount = _bankAccountControllers[i].text;
                                  banks.add(BankInfoEntity(bankName: bankName, bankAccount: bankAccount));
                                }
                              }
                              AddNewSupplierParameter addNewSupplierParameters = AddNewSupplierParameter(
                                issupp: false,
                                supplierName: supplierNameController.text,
                                supplierFullName: supplierFullNameController.text,
                                supplierPostalCode: supplierPostalCodeController.text,
                                bankInfos: banks,
                                supplierPhoneNumbers: phoneNumbers,
                                supplierWhatsappNumber: supplierWhatsAppController.text,
                                address: supplierAddressController.text,
                                mapLocation: supplierLocationLinkController.text,
                                email: supplierEmailController.text,
                                facebook: supplierFacebookController.text,
                                notes: supplierNoteController.text,
                                order: 0,
                                companyId: int.parse(supplierCompanyIdController.text),
                                groupId: int.parse(supplierGroupIdController.text),
                                sectionId: int.parse( supplierSectionIdController.text),
                                supplierPosition: supplierPositionController.text,
                              );
                              await addSupplierController.addNewSupplier(addNewSupplierParameters);
                              if (addSupplierController.addNewSupplierResult != null) {
                                Provider.of<SupplierController>(context, listen: false).getSuppliers(const NoParameters());
                                Provider.of<ClientsController>(context, listen: false).getClients(const NoParameters());
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      '${addSupplierController.addNewSupplierErrorMessage}created successfully',
                                    ),
                                  ),
                                );
                              }else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                      Text(addSupplierController.addNewSupplierErrorMessage)),
                                );
                              }
                            }
                          },
                          child: addSupplierController.addNewSupplierIsLoading
                              ? const CircularProgressIndicator() : const Text(StringManager.add),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 35,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
