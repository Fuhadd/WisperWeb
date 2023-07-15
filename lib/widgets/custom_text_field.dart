import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../constants/custom_colors.dart';

FormBuilderTextField customTextField(
    String name, IconData prefixIcon, IconData? suffixIcon, String labelText,
    {String? hintText,
    Widget? prefix,
    String? initialValue,
    bool isHint = false,
    bool obscureText = false,
    String? helperText,
    String? Function(String?)? validator,
    void Function()? onSuffixTap,
    void Function(String?)? onChanged}) {
  return FormBuilderTextField(
    initialValue: initialValue,
    cursorColor: CustomColors.mainBlueColor,
    name: name,
    obscureText: obscureText,
    validator: validator,
    onChanged: onChanged,
    decoration: customFormDecoration(
        hintText, labelText, prefixIcon, suffixIcon,
        prefix: prefix, helperText: helperText, onSuffixTap: onSuffixTap),
  );
}

InputDecoration customFormDecoration(String? hintText, String labelText,
    IconData? prefixIcon, IconData? suffixIcon,
    {String? helperText,
    Widget? prefix,
    bool isHint = false,
    void Function()? onSuffixTap}) {
  return InputDecoration(
      hintText: isHint ? '' : hintText,
      prefix: prefix,
      helperText: helperText,
      helperMaxLines: 7,
      helperStyle: const TextStyle(fontSize: 13),
      floatingLabelStyle: const TextStyle(color: CustomColors.mainBlueColor),
      fillColor: CustomColors.mainBlueColor,
      focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: CustomColors.mainBlueColor)),
      prefixIcon: Icon(
        prefixIcon,
        size: 16,
        color: CustomColors.blackBgColor.withOpacity(0.6),
      ),
      // prefixIconColor: Colors.red,
      suffixIcon: GestureDetector(
        onTap: onSuffixTap,
        child: Icon(
          suffixIcon,
          size: 20,
          color: CustomColors.blackIconColor,
        ),
      ),
      labelText: labelText,
      labelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: CustomColors.greyBgColor));
}
