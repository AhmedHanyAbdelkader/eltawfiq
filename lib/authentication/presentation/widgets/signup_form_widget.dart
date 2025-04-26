
import 'package:eltawfiq_suppliers/core/resources/assets_manager.dart';
import 'package:eltawfiq_suppliers/core/resources/size_manager.dart';
import 'package:eltawfiq_suppliers/core/resources/string_manager.dart';
import 'package:eltawfiq_suppliers/core/shared_methods/validation_functions.dart';
import 'package:eltawfiq_suppliers/core/shared_widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _showPassword  = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Image.asset(ImageManager.logo,
              height: SizeManager.s_250,
              width: SizeManager.s_250,
              fit: BoxFit.contain,
            ),
            CustomTextField(
              textEditingController: _emailController,
              label: StringManager.name,
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return StringManager.fieldRequired;
                }
                return null;
              },
            ),
            const SizedBox(height: SizeManager.s_20,),
            StatefulBuilder(
              builder: (context, passwordFieldBuilder){
                return CustomTextField(
                  textEditingController: _passwordController,
                  label: StringManager.password,
                  isObsecuredText: _showPassword,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (input)=> validateUserNameOrPassword(input),
                  suffixIcon: IconButton(
                    icon: Icon(
                        _showPassword == true
                            ? Icons.visibility_off
                            : Icons.visibility
                    ),
                    onPressed: (){
                      passwordFieldBuilder((){
                        _showPassword = !_showPassword;
                      });
                    },
                  ),
                ) ;
              },
            ),

            const SizedBox(height: SizeManager.s_20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Handle sign in
                }
              },
              child: const Text(StringManager.register),
            ),
          ],
        ),
      ),
    );
  }
}