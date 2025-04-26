import 'package:eltawfiq_suppliers/authentication/presentation/widgets/signin_form_widget.dart';
import 'package:eltawfiq_suppliers/core/resources/size_manager.dart';
import 'package:eltawfiq_suppliers/core/resources/string_manager.dart';
import 'package:flutter/material.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(StringManager.login),
          automaticallyImplyLeading: false, // This hides the back button
        ),
        body: const Padding(
          padding: EdgeInsets.all(SizeManager.s_16),
          child: SignInForm(),
        ),
      ),
    );
  }
}






