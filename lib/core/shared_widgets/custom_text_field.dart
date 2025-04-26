import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.textEditingController,
    required this.label,
    this.isObsecuredText,
    this.validator,
    this.onChanged,
    this.keyboardType,
    this.suffixIcon,
    this.autoFocus,
    this.focusNode,
    this.onEditingComplete,
  });

  final TextEditingController textEditingController;
  final String label;
  final bool? isObsecuredText;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final bool? autoFocus;
  final FocusNode? focusNode;
  final void Function()? onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      autofocus: autoFocus ?? false,
      focusNode: focusNode,
      decoration: InputDecoration(
        labelText: label,
        suffix: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(
            color: Colors.blue,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
      ),
      obscureText: isObsecuredText ?? false,
      keyboardType: keyboardType ?? TextInputType.text,
      validator: validator,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
    );
  }
}
