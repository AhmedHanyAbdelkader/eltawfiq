import 'package:eltawfiq_suppliers/authentication/domain/use_cases/login_user_use_case.dart';
import 'package:eltawfiq_suppliers/authentication/presentation/controllers/login_user_controller.dart';
import 'package:eltawfiq_suppliers/core/resources/assets_manager.dart';
import 'package:eltawfiq_suppliers/core/resources/size_manager.dart';
import 'package:eltawfiq_suppliers/core/resources/string_manager.dart';
import 'package:eltawfiq_suppliers/core/router/app_router.dart';
import 'package:eltawfiq_suppliers/core/shared_methods/validation_functions.dart';
import 'package:eltawfiq_suppliers/core/shared_widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _buttonFocusNode = FocusNode();
  bool _showPassword  = true;

  @override
  Widget build(BuildContext context) {
    final loginController = context.watch<LoginUserController>();

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
              autoFocus: true,
              focusNode: _emailFocusNode,
              onEditingComplete: (){
                _emailFocusNode.unfocus();
                FocusScope.of(context).requestFocus(_passwordFocusNode);
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
                  //autoFocus: true,
                  focusNode: _passwordFocusNode,
                  onEditingComplete: (){
                    _passwordFocusNode.unfocus();
                    FocusScope.of(context).requestFocus(_buttonFocusNode);
                  },
                ) ;
              },
            ),

            const SizedBox(height: SizeManager.s_20),
            ElevatedButton(
              focusNode: _buttonFocusNode,
              onPressed: loginController.loginUserIsLoading ? null : () async {
                if (_formKey.currentState!.validate()) {
                  await loginController.loginUser(
                    LoginUserParameters(
                      email: _emailController.text,
                      password: _passwordController.text,
                    ),
                  );

                  if (loginController.loginUserResult != null) {
                    RouteGenerator.navigationReplacementTo(AppRoutes.homeScreenRoute);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(loginController.editUserErrorMessage),
                      ),
                    );
                  }
                }
              },
              child: loginController.loginUserIsLoading
                  ? const CircularProgressIndicator.adaptive()
                  : const Text(StringManager.login),
            ),
          ],
        ),
      ),
    );
  }
}