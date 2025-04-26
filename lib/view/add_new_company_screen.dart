import 'package:eltawfiq_suppliers/controller/app_state_provider.dart';
import 'package:eltawfiq_suppliers/core/resources/string_manager.dart';
import 'package:eltawfiq_suppliers/core/shared_widgets/custom_text_field.dart';
import 'package:eltawfiq_suppliers/model/company_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddNewCompanyScreen extends StatefulWidget {
  const AddNewCompanyScreen({super.key});

  @override
  State<AddNewCompanyScreen> createState() => _AddNewCompanyScreenState();
}

class _AddNewCompanyScreenState extends State<AddNewCompanyScreen> {

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Provider.of<AppStateProvider>(context, listen: false).resetCreateCompanyState();
  }

  final TextEditingController companyNameTextFormField = TextEditingController();
  final TextEditingController companyDescribtionTextFormField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppStateProvider>(context);
    //final authState = Provider.of<AuthStateProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(StringManager.addNewCompany),
      ),
      body:  Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  textEditingController: companyNameTextFormField,
                  label: StringManager.addNewCompany,
                  onChanged: (newValue){
                    companyNameTextFormField.text = newValue!;
                    return null;
                  },
                  suffixIcon: const Icon(Icons.home_work_outlined),
                  keyboardType: TextInputType.name,
                  validator: (String? input){
                    if(input == null || input.isEmpty){
                      return StringManager.fieldRequired;
                    }else{
                      return null;
                    }
                  },
                ),
                CustomTextField(
                  textEditingController: companyDescribtionTextFormField,
                  label: StringManager.addCompanyDescribtion,
                  onChanged: (newValue){
                    companyDescribtionTextFormField.text = newValue!;
                    return null;
                  },
                  suffixIcon: const Icon(Icons.home_work_outlined),
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 35,),
                if (appState.createCompanyIsLoading)
                  const CircularProgressIndicator(),
                if (!appState.createCompanyIsLoading)
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        final newCompany = CompanyModel(
                          companyName: companyNameTextFormField.text,
                          companyDescription: companyDescribtionTextFormField.text,
                        );
                        appState.createCompany(
                          token: '51515151',
                          //authState.loginResult!.token!,
                          companyModel: newCompany,
                        );
                      }
                    },
                    child: const Text(StringManager.add),
                  ),
                if (appState.createCompanyErrorMessage.isNotEmpty)
                  Text(
                    appState.createCompanyErrorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                if (appState.createCompanyResult != null)
                  Text(
                    'Company created: ${appState.createCompanyResult!.companyName}',
                    style: const TextStyle(color: Colors.green),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
