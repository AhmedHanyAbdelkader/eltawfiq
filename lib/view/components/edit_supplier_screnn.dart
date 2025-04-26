import 'dart:convert';

import 'package:eltawfiq_suppliers/controller/app_state_provider.dart';
import 'package:eltawfiq_suppliers/core/network/api_constance.dart';
import 'package:eltawfiq_suppliers/core/resources/string_manager.dart';
import 'package:eltawfiq_suppliers/core/shared_widgets/custom_text_field.dart';
import 'package:eltawfiq_suppliers/model/company_model.dart';
import 'package:eltawfiq_suppliers/model/group_model.dart';
import 'package:eltawfiq_suppliers/model/section_model.dart';
import 'package:eltawfiq_suppliers/model/supplier_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
class EditSupplierScreen extends StatefulWidget {
  const EditSupplierScreen({super.key, required this.supplier});
  final SupplierModel supplier;

  @override
  State<EditSupplierScreen> createState() => _EditSupplierScreenState();
}

class _EditSupplierScreenState extends State<EditSupplierScreen> {

  late List<TextEditingController> _controllers;


  final List<TextEditingController> _bankNameControllers = [];
  final List<TextEditingController> _bankAccountControllers = [];
  final List<FocusNode> _bankNameFocusNodes = [];
  final List<FocusNode> _bankAccountFocusNodes = [];
  List<Widget> _bankFields = [];

  @override
  void initState() {
    super.initState();
    if(widget.supplier.supplierPhoneNumbers != null){
      _controllers = widget.supplier.supplierPhoneNumbers!.map((phone) => TextEditingController(text: phone)).toList();
    }
    _initializeBankFields();

  }


  void _initializeBankFields() {
    if(widget.supplier.bankInfo != null){
      for (var bankData in widget.supplier.bankInfo!) {
        _addBankField(
          bankName: bankData['bank_name']?? '',
          bankAccount: bankData['bank_account']?? '',
        );
      }
    }

  }

  void _addBankField({String bankName = '', String bankAccount = ''}) {
    TextEditingController bankNameController = TextEditingController(text: bankName);
    TextEditingController bankAccountController = TextEditingController(text: bankAccount);
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
              _addNewBankField();
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
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }

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

    final TextEditingController supplierNameController = TextEditingController(
        text: widget.supplier.supplierName
    );
    final TextEditingController supplierPositionController = TextEditingController(
      text: widget.supplier.supplierPosition
    );

    final TextEditingController supplierCompanyNameController = TextEditingController();
    final TextEditingController supplierCompanyIdController = TextEditingController();

    final TextEditingController supplierSectionIdController = TextEditingController();
    final TextEditingController supplierSectionNameController = TextEditingController();

    final TextEditingController supplierGroupIdController = TextEditingController();
    final TextEditingController supplierGroupNameController = TextEditingController();

    final TextEditingController supplierFullNameController = TextEditingController(
      text: widget.supplier.supplierFullName
    );
    final TextEditingController supplierPostalCodeController = TextEditingController(
      text: widget.supplier.supplierPostalCode
    );
    //final TextEditingController supplierPhoneController = TextEditingController();
    final TextEditingController supplierWhatsAppController = TextEditingController(
      text: widget.supplier.supplierWhatsappNumber
    );
    final TextEditingController supplierAddressController = TextEditingController(
      text: widget.supplier.address
    );
    final TextEditingController supplierLocationLinkController = TextEditingController(
      text: widget.supplier.mapLocation
    );
    final TextEditingController supplierEmailController = TextEditingController(
      text: widget.supplier.email
    );
    final TextEditingController supplierFacebookController = TextEditingController(
      text: widget.supplier.facebook
    );
    final TextEditingController supplierNoteController = TextEditingController(
      text: widget.supplier.notes
    );

    return  Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(StringManager.editSupplierData),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextField(
                  textEditingController: supplierNameController,
                  label: StringManager.supplierName,
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
                CustomTextField(
                  textEditingController: supplierPositionController,
                  label: StringManager.position,
                  keyboardType: TextInputType.text,
                  suffixIcon: const Icon(Icons.work_rounded),
                ),
                const SizedBox(height: 20,),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(widget.supplier.company?.companyName ?? '',
                    style: const TextStyle(
                        color: Colors.black
                    ),),
                ),
                Consumer<AppStateProvider>(
                  builder: (context, companiesStateProvider, _){
                    return TypeAheadField<CompanyModel>(
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
                        return companiesStateProvider.getCompaniesResult!.where(
                                (company) => company.companyName.contains(pattern)
                        ).toList();
                      },
                      itemBuilder: (context, company) {
                        return ListTile(
                          title: Text(company.companyName),
                          subtitle: Text(company.companyDescription ?? ''),
                        );
                      },
                      onSuggestionSelected: (CompanyModel? suggestion) {
                        supplierCompanyNameController.text = suggestion!.companyName;
                        supplierCompanyIdController.text = suggestion.companyId.toString();
                      },
                    );
                  },
                ),
                const SizedBox(height: 20,),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(widget.supplier.section?.name ?? '',
                    style: const TextStyle(
                        color: Colors.black
                    ),),
                ),
                Consumer<AppStateProvider>(
                  builder: (context, sectionsStateProvider, _){
                    return TypeAheadField<SectionModel>(
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
                        return sectionsStateProvider.getSectionsResult!.where(
                                (section) => section.name.contains(pattern)
                        ).toList();
                      },
                      itemBuilder: (context, company) {
                        return ListTile(
                          title: Text(company.name),
                          //subtitle: Text(company. ?? ''),
                        );
                      },
                      onSuggestionSelected: (SectionModel? suggestion) {
                        supplierSectionNameController.text = suggestion!.name;
                        supplierSectionIdController.text = suggestion.id.toString();
                      },
                    );
                  },
                ),
                const SizedBox(height: 20,),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(widget.supplier.group?.groupName ?? '',
                    style: const TextStyle(
                        color: Colors.black
                    ),),
                ),
                Consumer<AppStateProvider>(
                  builder: (context, groupsStateProvider, _){
                    return TypeAheadField<GroupModel>(
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
                        return groupsStateProvider.getGroupsResult!.where(
                                (group) => group.groupName.contains(pattern)
                        ).toList();
                      },
                      itemBuilder: (context, group) {
                        return ListTile(
                          title: Text(group.groupName),
                          //subtitle: Text(company. ?? ''),
                        );
                      },
                      onSuggestionSelected: (GroupModel? suggestion) {
                        supplierGroupNameController.text = suggestion!.groupName;
                        supplierGroupIdController.text = suggestion.groupId.toString();
                      },
                    );
                  },
                ),
                CustomTextField(
                  textEditingController: supplierFullNameController,
                  label: StringManager.supplierFullName,
                  suffixIcon: const Icon(Icons.person),
                  keyboardType: TextInputType.name,
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
                ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: _controllers.length,
                  itemBuilder: (context, index) {
                    return TextField(
                      decoration: InputDecoration(
                        suffix: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deletePhoneField(index),
                        ),
                      ),
                      controller: _controllers[index],
                      keyboardType: TextInputType.number,
                    );
                  },
                ),
                CustomTextField(
                  textEditingController: supplierPostalCodeController,
                  label: StringManager.supplierPostalCode,
                  suffixIcon: const Icon(Icons.signpost),
                  keyboardType: TextInputType.number,
                ),
                ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  children: _bankFields,
                ),
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
                CustomTextField(
                  textEditingController: supplierAddressController,
                  label: StringManager.supplierCompanyAddress,
                  keyboardType: TextInputType.streetAddress,
                  suffixIcon: const Icon(Icons.maps_home_work_outlined),
                ),
                CustomTextField(
                  textEditingController: supplierLocationLinkController,
                  label: StringManager.supplierCompanyLocation,
                  keyboardType: TextInputType.url,
                  suffixIcon: const Icon(Icons.not_listed_location_rounded),
                  isObsecuredText: false,
                ),
                CustomTextField(
                  textEditingController: supplierEmailController,
                  label: StringManager.supplierEmail,
                  keyboardType: TextInputType.emailAddress,
                  suffixIcon: const Icon(Icons.attach_email_rounded),
                  isObsecuredText: false,
                ),
                CustomTextField(
                  textEditingController: supplierFacebookController,
                  label: StringManager.supplierFacebook,
                  keyboardType: TextInputType.url,
                  suffixIcon: const Icon(Icons.facebook),
                  isObsecuredText: false,
                ),
                CustomTextField(
                  textEditingController: supplierNoteController,
                  label: StringManager.suppliernotes,
                  keyboardType: TextInputType.multiline,
                  suffixIcon: const Icon(Icons.note_add),
                  isObsecuredText: false,
                ),
                const SizedBox(
                  height: 25,
                ),
                ElevatedButton.icon(
                    onPressed: ()async {
                      int supplierId = 7;
                      final supplierData = {
                        'supplier_name': 'New Supplier Name',
                        'supplier_full_name': 'New Supplier Full Name',
                        'supplier_postal_code': '12345',
                        'company_name': 'New Company Name',
                        'supplier_phone_numbers': ['123-456-7890', '098-765-4321'],
                        'supplier_whatsapp_number': '01234567890',
                        'address': '123 Main St, Anytown, USA',
                        'map_location': '37.7749,-122.4194',
                        'email': 'newemail@example.com',
                        'facebook': 'facebook.com/newsupplier',
                        'notes': 'Updated supplier notes',
                        'supplier_total': 1000.0,
                        'supplier_payed': 500.0,
                        'supplier_remained': 500.0,
                        'company_id': 2,
                        'supplier_position': 'Manager',
                        //'group_id': 3,
                        'sec_id': 4,
                      };
                      final url = Uri.parse('${ApiConstance.baseUrl}/api/auth/suppliers/$supplierId');

                      final response = await http.put(
                        url,
                        headers: {
                          'Content-Type': 'application/json',
                        },
                        body: json.encode(supplierData),
                      );

                      if (response.statusCode == 200) {
                        // Successfully updated supplier
                        if (kDebugMode) {
                          print('Supplier updated successfully');
                        }
                      } else {
                        // Handle the error
                        if (kDebugMode) {
                          print('Failed to update supplier: ${response.body}');
                        }
                      }


                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('تعديل'),
                ),
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
