import 'package:flutter/material.dart';
import 'package:travo_app/constant/utils/color_constant.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final String? errorMsg;
  final String? Function(String?)? onChanged;
  final Widget? prefixIcon;

  const CommonTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      required this.keyboardType,
      this.suffixIcon,
      this.onTap,
      this.validator,
      this.focusNode,
      this.errorMsg,
      this.onChanged,
      this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(fontWeight: FontWeight.bold),
      
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      obscuringCharacter:  '*',
      keyboardType: keyboardType,
      focusNode: focusNode,
      onTap: onTap,
      textInputAction: TextInputAction.next,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: hintText,
        // hintText: hintText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide:
              const BorderSide(color: ColorConstant.whiteColor),
        ),
        filled: true,
        errorText: errorMsg,
      ),
    );
  }
}
