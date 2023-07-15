import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../constants/custom_colors.dart';

FormBuilderTextField customNoBorderTextField(
    String name, IconData prefixIcon, IconData? suffixIcon, String labelText,
    {String? hintText,
    Widget? prefix,
    String? initialValue,
    bool isHint = false,
    bool obscureText = false,
    bool isFloating = true,
    String? helperText,
    String? Function(String?)? validator,
    void Function()? onSuffixTap,
    void Function(String?)? onChanged}) {
  return FormBuilderTextField(
    initialValue: initialValue,
    cursorColor: CustomColors.mainBlueColor,
    name: name,
    minLines: 5,
    maxLines: 100,
    maxLength: 2000,
    obscureText: obscureText,
    validator: validator,
    onChanged: onChanged,
    decoration: customFormDecoration(
        hintText, labelText, prefixIcon, suffixIcon,
        prefix: prefix,
        helperText: helperText,
        onSuffixTap: onSuffixTap,
        isFloating: isFloating),
  );
}

InputDecoration customFormDecoration(String? hintText, String labelText,
    IconData? prefixIcon, IconData? suffixIcon,
    {String? helperText,
    Widget? prefix,
    bool isHint = false,
    required bool isFloating,
    void Function()? onSuffixTap}) {
  return InputDecoration(
      hintText: isHint ? '' : hintText,
      prefix: prefix,
      helperText: helperText,
      contentPadding: const EdgeInsets.only(top: 20.0, bottom: 20),
      helperMaxLines: 7,
      helperStyle: const TextStyle(fontSize: 13),
      floatingLabelStyle:
          const TextStyle(color: CustomColors.mainBlueColor, fontSize: 18),
      floatingLabelAlignment: FloatingLabelAlignment.start,
      floatingLabelBehavior: isFloating
          ? FloatingLabelBehavior.always
          : FloatingLabelBehavior.never,
      fillColor: CustomColors.mainBlueColor,
      border: isFloating ? null : InputBorder.none,
      focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: CustomColors.mainBlueColor)),
      labelText: labelText,
      labelStyle: TextStyle(
          fontSize: isFloating ? 18 : 12,
          fontWeight: FontWeight.normal,
          color: CustomColors.greyBgColor));
}
