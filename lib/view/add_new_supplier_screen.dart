import 'dart:developer';
import 'package:eltawfiq_suppliers/controller/app_state_provider.dart';
import 'package:eltawfiq_suppliers/core/resources/string_manager.dart';
import 'package:eltawfiq_suppliers/core/router/app_router.dart';
import 'package:eltawfiq_suppliers/core/shared_widgets/custom_elevated_button.dart';
import 'package:eltawfiq_suppliers/core/shared_widgets/custom_text_field.dart';
import 'package:eltawfiq_suppliers/model/company_model.dart';
import 'package:eltawfiq_suppliers/model/group_model.dart';
import 'package:eltawfiq_suppliers/model/section_model.dart';
import 'package:eltawfiq_suppliers/model/supplier_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

class AddNewSupplierScreen extends StatefulWidget {
  const AddNewSupplierScreen({super.key});

  @override
  State<AddNewSupplierScreen> createState() => _AddNewSupplierScreenState();
}

class _AddNewSupplierScreenState extends State<AddNewSupplierScreen> {
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
        Provider.of<AppStateProvider>(context, listen: false).getCompanies(
            token:'15151'
            //Provider.of<AuthStateProvider>(context, listen: false).loginResult!.token!
        );
        Provider.of<AppStateProvider>(context, listen: false).getSections();
        Provider.of<AppStateProvider>(context, listen: false).getGroups(
            token: '1551'
            //Provider.of<AuthStateProvider>(context, listen: false).loginResult!.token!
        );
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
                const Text('بيانات المورد',style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22
              ),),
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
                  // validator: (String? input) {
                  //   if (input == null || input.isEmpty) {
                  //     return StringManager.fieldRequired;
                  //   } else {
                  //     return null;
                  //   }
                  // },
                ),
                // CustomTextFeild(
                //   textEditingController: supplierCompanyNameController,
                //   label: StringManager.supplierCompanyName,
                //   suffixIcon: const Icon(Icons.maps_home_work_outlined),
                //   keyboardType: TextInputType.name,
                //   // validator: (String? input){
                //   //   if(input == null || input.isEmpty){
                //   //     return StringManager.fieldRequired;
                //   //   }else{
                //   //     return null;
                //   //   }
                //   // },
                // ),
                const SizedBox(height: 20,),
                Consumer<AppStateProvider>(
                  builder: (context, companiesStateProvider, _){
                    return Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: TypeAheadField<CompanyModel>(
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
                          ),
                        ),
                        IconButton(onPressed: (){}, icon: const Icon(Icons.add)),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 20,),
                Consumer<AppStateProvider>(
                  builder: (context, sectionsStateProvider, _){
                    return Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: TypeAheadField<SectionModel>(
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
                          ),
                        ),
                        IconButton(
                            onPressed: (){
                              // showDialog(
                              //     context: context,
                              //     builder: (context) => const AddNewSectionDialog(),
                              // );
                            },
                            icon: const Icon(Icons.add)),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 20,),
                Consumer<AppStateProvider>(
                  builder: (context, groupsStateProvider, _){
                    return Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: TypeAheadField<GroupModel>(
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
                          ),
                        ),
                        IconButton(onPressed: (){}, icon: const Icon(Icons.add)),
                      ],
                    );
                  },
                ),
                CustomTextField(
                  textEditingController: supplierFullNameController,
                  label: StringManager.supplierFullName,
                  suffixIcon: const Icon(Icons.person),
                  keyboardType: TextInputType.name,
                  // validator: (String? input){
                  //   if(input == null || input.isEmpty){
                  //     return StringManager.fieldRequired;
                  //   }else{
                  //     return null;
                  //   }
                  // },
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
                for (int i = 0; i < _controllers.length; i++)
                  Row(
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

                CustomTextField(
                  textEditingController: supplierPostalCodeController,
                  label: StringManager.supplierPostalCode,
                  suffixIcon: const Icon(Icons.signpost),
                  keyboardType: TextInputType.number,
                  // validator: (String? input){
                  //   if(input == null || input.isEmpty){
                  //     return StringManager.fieldRequired;
                  //   }else{
                  //     return null;
                  //   }
                  // },
                ),

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
                // ListView(
                //   shrinkWrap: true,
                //   physics: const BouncingScrollPhysics(),
                //   children: _phoneTextFields,
                // ),
                CustomTextField(
                  textEditingController: supplierAddressController,
                  label: StringManager.supplierCompanyAddress,
                  keyboardType: TextInputType.streetAddress,
                  suffixIcon: const Icon(Icons.maps_home_work_outlined),
                  // validator: (String? input){
                  //   if(input == null || input.isEmpty){
                  //     return StringManager.fieldRequired;
                  //   }else{
                  //     return null;
                  //   }
                  // },
                ),
                CustomTextField(
                  textEditingController: supplierLocationLinkController,
                  label: StringManager.supplierCompanyLocation,
                  keyboardType: TextInputType.url,
                  suffixIcon: const Icon(Icons.not_listed_location_rounded),
                  isObsecuredText: false,
                  // validator: (String? input){
                  //   if(input == null || input.isEmpty){
                  //     return StringManager.fieldRequired;
                  //   }else{
                  //     return null;
                  //   }
                  // },
                ),
                CustomTextField(
                  textEditingController: supplierEmailController,
                  label: StringManager.supplierEmail,
                  keyboardType: TextInputType.emailAddress,
                  suffixIcon: const Icon(Icons.attach_email_rounded),
                  isObsecuredText: false,
                  // validator: (String? input){
                  //   if(input == null || input.isEmpty){
                  //     return StringManager.fieldRequired;
                  //   }else{
                  //     return null;
                  //   }
                  // },
                ),
                CustomTextField(
                  textEditingController: supplierFacebookController,
                  label: StringManager.supplierFacebook,
                  keyboardType: TextInputType.url,
                  suffixIcon: const Icon(Icons.facebook),
                  isObsecuredText: false,
                  // validator: (String? input){
                  //   if(input == null || input.isEmpty){
                  //     return StringManager.fieldRequired;
                  //   }else{
                  //     return null;
                  //   }
                  // },
                ),
                CustomTextField(
                  textEditingController: supplierNoteController,
                  label: StringManager.suppliernotes,
                  keyboardType: TextInputType.multiline,
                  suffixIcon: const Icon(Icons.note_add),
                  isObsecuredText: false,
                  // validator: (String? input){
                  //   if(input == null || input.isEmpty){
                  //     return StringManager.fieldRequired;
                  //   }else{
                  //     return null;
                  //   }
                  // },
                ),
                const SizedBox(
                  height: 25,
                ),

                Consumer<AppStateProvider>(
                  builder: (context, addSupplierStateProvider, _) {
                    return Column(
                      children: [
                        if (addSupplierStateProvider.createSupplierIsLoading)
                          const Center(
                              child: CircularProgressIndicator.adaptive()),
                        CustomElevatedButton(
                          label: StringManager.add,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              // await _addSupplierStateProvider.createSupplier(
                              //     supplierName: supplierNameController.text,
                              //     supplierPhoneNumber: supplierPhoneController.text,
                              //     supplierWhatsappNumber: supplierWhatsAppController.text);
                              // List to store phone numbers
                              List<String> phoneNumbers = [];
                              //print(_phoneControllers);
                                if(_controllers.first.text.isNotEmpty){
                                  for (var controller in _controllers){
                                    phoneNumbers.add(controller.text);
                                  }
                                }

                              // List to store bank data
                              List<BankInfo> banks=[];
                              if(_bankNameControllers.first.text.isNotEmpty && _bankAccountControllers.first.text.isNotEmpty){
                                for (int i = 0; i < _bankNameControllers.length; i++) {
                                  String bankName = _bankNameControllers[i].text;
                                  String bankAccount = _bankAccountControllers[i].text;
                                  banks.add(BankInfo(bankName: bankName, bankAccount: bankAccount));
                                }
                              }
                              SupplierModel supplierModel = SupplierModel(
                                supplierId: 0,
                                supplierName: supplierNameController.text,
                                //companyName: supplierCompanyNameController.text,
                                supplierFullName: supplierFullNameController.text,
                                supplierPostalCode: supplierPostalCodeController.text,
                                bankInfo: banks,
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
                              await addSupplierStateProvider.createSupplier(
                                  supplier: supplierModel,
                                token: ''
                                //Provider.of<AuthStateProvider>(context, listen: false).loginResult!.token!
                              );
                              addSupplierStateProvider.getSuppliers(
                                  id: 1
                                  //Provider.of<AuthStateProvider>(context, listen: false).loginResult!.user!.id!
                              );
                              if (addSupplierStateProvider.createSupplierResult != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(StringManager.supplierAdded),
                                  ),
                                );
                                Future.delayed(const Duration(seconds: 2), () {
                                  RouteGenerator.navigationReplacementTo(AppRoutes.homeScreenRoute);
                                });
                              }
                              if (addSupplierStateProvider.createSupplierErrorMessage.isNotEmpty) {
                                log(addSupplierStateProvider.createSupplierErrorMessage);
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text(StringManager.error),
                                    content: Text(addSupplierStateProvider
                                        .createSupplierErrorMessage),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(StringManager.ok),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            }
                          },
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
